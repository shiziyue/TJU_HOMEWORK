#include "Syntax.h"
#include <iomanip>
#include <set>
#include <fstream>
#include <string>
void Syntax_Analysis::Init_FirstTable(Grammar grammar)
{
    //(1)如果X∈VT,则FIRST(X)={X}
    for (auto iter = grammar.Terms.begin(); iter != grammar.Terms.end(); iter++)
    {
        string term = *iter;
        set<string> first;
        first.insert(term);
        pair<string, set<string>> s(term, first);
        FirstTable.insert(s);
    }

    cout << "---------------------------------------" << endl;
    //初始化剩余的<文法符号,相应的First集>
    for (auto iter2 = grammar.UTerms.begin(); iter2 != grammar.UTerms.end(); iter2++)
    {
        string uterm = *iter2;
        set<string> first;
        pair<string, set<string>> s1(uterm, first);
        FirstTable.insert(s1);
    }
    cout << "---------------------------------------" << endl;
    for (auto iter3 = grammar.productions.begin(); iter3 != grammar.productions.end(); iter3++)
    {
        set<string> first;
        // cout << "iter3==   " << iter3->right << endl;
        //  pair<string, set<string>> s3(iter3->right, first);
        //   cout<<iter3->right<<endl;
        bool exist = 1;
        for (auto pipaei = FirstTable.begin(); pipaei != FirstTable.end(); pipaei++)
        {
            // cout<<"pipei---"<<pipaei->first<<endl;
            // cout<<"---------"<<iter3->right<<endl;
            if (pipaei->first.compare(iter3->right) == 0)
            {
                //cout << "pipei---" << pipaei->first << endl;
                //cout << "---------" << iter3->right << endl;
                exist = 0;
            }
        }
        if (exist)
        {
            //cout << "iter3==   " << iter3->right << endl;
            FirstTable.insert(pair<string, set<string>>(iter3->right, first));
        }
    }
    // for (auto which = FirstTable.begin(); which != FirstTable.end(); which++)
    // {
    //     cout << "\t" << which->first;
    //     cout << endl;
    //     cout << &which->first << endl;
    //     cout << endl;
    // }
    cout << "---------------------------------------" << endl;
    //构造FIRST集合的算法 I
    bool change = true;
    while (change)
    {
        change = false;
        for (auto prdt = grammar.productions.begin(); prdt != grammar.productions.end(); prdt++)
        {
            set<string> tarfirst = FirstTable.find(prdt->left)->second; //找到每个产生式左侧对应的first集合
            auto rightsyb = prdt->rights.begin();                       //指向当前产生式右部符号集
            bool flag = true;
            while (flag)
            {
                flag = false;
                if (rightsyb == prdt->rights.end())
                {
                    tarfirst.insert("$");
                }
                else
                {
                    set<string> tofind = FirstTable.find(*rightsyb)->second; //找到产生式右侧符号的first集合
                    for (auto iter = tofind.begin(); iter != tofind.end(); iter++)
                    {
                        if (tarfirst.find(*iter) == tarfirst.end())
                        { //如果当前不在左侧的first集中加入
                            tarfirst.insert(*iter);
                            change = true; //更新状态还需继续遍历
                        }
                        else if (*iter == "$")
                        { //如果有$则需要去向后一个右部符号的first集
                            flag = true;
                            rightsyb++;
                        }
                    }
                }
            }
            FirstTable[prdt->left] = tarfirst; //更新当前左部最近的first集
        }
    }
    //构造FIRST集合Ⅱ
    for (auto prdt = grammar.productions.begin(); prdt != grammar.productions.end(); prdt++)
    {
        if (FirstTable.find(prdt->right) != FirstTable.end())
        {
            // cout<<prdt->right<<endl;
            // cout<<"====="<<endl;
            set<string> tarfirst = FirstTable.find(prdt->right)->second; //找到每个产生式右侧对应的first集合
            auto rightsyb = prdt->rights.begin();                        //指向当前产生式右部符号集
            bool flag = true;
            while (flag)
            {
                flag = false;
                if (rightsyb == prdt->rights.end())
                {
                    tarfirst.insert("$");
                }
                else
                {
                    set<string> tofind = FirstTable.find(*rightsyb)->second; //找到产生式右侧符号的first集合
                    for (auto iter = tofind.begin(); iter != tofind.end(); iter++)
                    {
                        if (tarfirst.find(*iter) == tarfirst.end())
                        { //如果当前不在左侧的first集中加入
                            tarfirst.insert(*iter);
                        }
                        else if (*iter == "$")
                        { //如果有$则需要去向后一个右部符号的first集
                            flag = true;
                            rightsyb++;
                        }
                    }
                }
            }
            FirstTable[prdt->right] = tarfirst; //更新当前右部最近的first集
        }
    }
}

void Syntax_Analysis::Print_FirstTable()
{
    cout << "FIRST:" << endl;
    for (auto which = FirstTable.begin(); which != FirstTable.end(); which++)
    {
        cout << "\t" << which->first;
        cout << endl;
        //cout << &which->first << endl;
        cout << "\t\t=  [";
        for (auto iter = which->second.begin(); iter != which->second.end(); iter++)
            cout << *iter << " ";
        cout << "]";
        cout << endl;
    }
    cout << endl;
    cout << endl;
    // for (auto which = FirstTable.begin(); which != FirstTable.end(); which++)
    // {
    //     cout << "\t" << which->first;
    //     cout << endl;
    // }
}

void Syntax_Analysis::Init_FollowTable(Grammar grammar)
{
    FollowTable["root"].insert("#"); // 1) 对于文法的开始符号S, 置#于FOLLOW(S)中;
    bool keepon = true;
    while (keepon)
    {
        keepon = false;
        for (auto prdct = grammar.productions.begin(); prdct != grammar.productions.end(); prdct++)
        {
            int length = prdct->rights.size(); //产生式右部的长度
            bool existepsilon[1000] = {0};     //去first中寻找对应的产生式右部是否存在$转换
            for (int i = 1; i < length; i++)
            {
                if (FirstTable[prdct->rights[i]].find("$") != FirstTable[prdct->rights[i]].end())
                {
                    existepsilon[i] = 1;
                }
            }
            // 2)若A->αBβ是一个产生式, 则把FIRST(β)\{ε}加至FOLLOW(B)中;
            for (int i = 0; i < length - 1; i++)
            {
                int j = i + 1;
                set<string> &B1 = FollowTable[prdct->rights[i]]; //相当于上文的B
                int late = B1.size();
                do
                {
                    set<string> &Bnextfirst = FirstTable[prdct->rights[j]]; // B后面的符号的first集合
                    auto iter = Bnextfirst.find("$");
                    B1.insert(Bnextfirst.begin(), iter);
                    B1.insert(++iter, Bnextfirst.end());
                    j++;
                } while (j < length && existepsilon[j - 1]); //
                if (late < B1.size())                        //发生改变了，还将继续向后
                {
                    keepon = true;
                }
            }
            //(3）若A->αB是一个产生式，FOLLOW(A)加至FOLLOW(B)
            set<string> &A = FollowTable[prdct->left];
            set<string> &B2 = FollowTable[prdct->rights[length - 1]];
            int late2 = B2.size();
            B2.insert(A.begin(), A.end());
            if (B2.size() != late2)
                keepon = true; //如果发生改变就继续
            //(3)或A->αBβ是一个产生式而β => ε (即ε∈FIRST(β) ), 则把FOLLOW(A)加至FOLLOW(B)中
            for (int i = 0; i < length - 1; i++)
            { //β => ε (即ε∈FIRST(β) )
                if (existepsilon[i + 1])
                {
                    set<string> &B3 = FollowTable[prdct->rights[i]];
                    int late3 = B3.size();
                    B3.insert(A.begin(), A.end());
                    if (late3 < B3.size())
                        keepon = true;
                }
            }
        }
    }
}

void Syntax_Analysis::Print_FollowTable()
{
    cout << "FOLLOW:" << endl;
    for (auto which = FollowTable.begin(); which != FollowTable.end(); which++)
    {
        cout << "\t" << which->first << "\t=\t";
        cout << "[ ";
        for (auto iter = which->second.begin(); iter != which->second.end(); iter++)
            cout << *iter << " ";
        cout << "]";
        cout << endl;
    }
    cout << endl;
}

// (1) 对文法G的每个产生式A->α,执行第(2)和(3)步；
// (2) 对每个终结符a∈FIRST(α), 把A->α加入M[A, a]中；
// (3) 若ε∈ FIRST(α), 则对任何b∈FOLLOW(A), 把A->ε加入M[A, b]中；
// (4) 把所有无定义的M[A, a]标上“出错标志”。
void Syntax_Analysis::Init_PredictTable(Grammar grammar)
{
    for (auto prdt = grammar.productions.begin(); prdt != grammar.productions.end(); prdt++)
    { // (1) 对文法G的每个产生式A->α,执行第(2)和(3)步；
        string aerf = prdt->right;
        set<string> first_of_aerf = FirstTable[aerf];
        // for (auto i = first_of_aerf.begin(); i != first_of_aerf.end(); i++)
        // {
        //     cout << *i << "--";
        // }
        string A = prdt->left;
        // (2) 对每个终结符a∈FIRST(α), 把A->α加入M[A, a]中；
        for (auto a = grammar.Terms.begin(); a != grammar.Terms.end(); a++)
        {
            if (first_of_aerf.find(*a) != first_of_aerf.end())
            {
                //cout << "对每个终结符a∈FIRST(α), 把A->α加入M[A, a]中；" << endl;
                pair<string, Production> s(*a, *prdt);
                PredictTable[A].insert(s);
            }
        }
        //(3) 若ε∈ FIRST(α), 则对任何b∈FOLLOW(A), 把A->ε加入M[A, b]中；
        if (FirstTable[aerf].find("$") != FirstTable[aerf].end())
        {
            //cout << "若ε∈ FIRST(α), 则对任何b∈FOLLOW(A), 把A->ε加入M[A, b]中；" << endl;
            set<string> follow_of_A = FollowTable[A];
            for (auto b = follow_of_A.begin(); b != follow_of_A.end(); b++)
            {
                //PredictTable[A][*b] = Production("0." + A + " -> $");
                PredictTable[A][*b].rights.push_back("$");
            }
        }
    }
}

void Syntax_Analysis::Print_PredictTable(Grammar grammar, string file_name)
{
    ofstream outfile;
    outfile.open(file_name, ios::out); // csv文件以逗号为分隔符，回车换行符
    outfile << "PredicTable";
    for (auto a = grammar.Terms.begin(); a != grammar.Terms.end(); a++)
    { //填表第一行
        if (*a == "$")
            continue;
        if (*a == ",") //逗号特殊处理
        {
            string dou = ",";
            string re = dou + "\"" + *a + "\"";
            outfile << re;
            continue;
        }

        outfile << "," + *a;
    }
    outfile << ",#" << endl;
    for (auto A = grammar.UTerms.begin(); A != grammar.UTerms.end(); A++)
    { // M[A,a]=production
        outfile << *A;
        for (auto a = grammar.Terms.begin(); a != grammar.Terms.end(); a++)
        {
            if (PredictTable[*A].count(*a) == 0) //没有M[A,a]
            {
                // cout<<"空"<<endl;
                outfile << ",";
            }
            else
            {
                outfile << "," + PredictTable[*A][*a].id + "." + PredictTable[*A][*a].left + "->" + PredictTable[*A][*a].right;
            }
            if (*a == "$")
                continue;
        }
        if (PredictTable[*A]["#"].id != "")
        {
            outfile << "," + PredictTable[*A]["#"].id + "." + PredictTable[*A]["#"].left + "->" + PredictTable[*A]["#"].right << endl;
        }
        else
            outfile << "," << endl;
    }
    cout << "符号表在同文件夹中的PredictTable.csv中" << endl;
}

// (1) push #S; 指针ip指向串w#的第一个符号a;
// (2) repeat
// (3) 令X为栈顶符号,a为ip所指的符号;
// (4)
// (5)
// (6)
// if !"#$%&' then
// if X=a=# then 接受w
// else if Ｘ=a ≠ # then 弹出X,并使ip前进
// else /* X为非终结符*/
// (7)
// (8)
// (9) àY1Y2…Yk then
// (10)
// if M[X,a]=X
// begin
// 弹出X;
// (13) end
// (14) else error
// (15) until Ｘ=#; /* 栈为空 *
bool Syntax_Analysis::Analysis(Grammar grammar, vector<Token> tokenlist)
{
    vector<string> Symbolzhan;
    Symbolzhan.push_back("#");
    Symbolzhan.push_back("root");
    int ip = 0;
    string a;
    int step = 1;
    while (ip <= tokenlist.size())
    {
        string X = Symbolzhan.back();
        if (ip == tokenlist.size())
            a = "#";
        else
        {
            if (tokenlist[ip].value.zhongbie == "KW" || tokenlist[ip].value.zhongbie == "OP" || tokenlist[ip].value.zhongbie == "SE")
            {
                a = tokenlist[ip].cifadanyuan;
            }
            else
                a = tokenlist[ip].value.zhongbie;
        }
        if (grammar.Terms.find(X) != grammar.Terms.end() || X == "#")
        {
            if (X == a && a == "#")
            {
                cout << step++ <<"\t"<< "#" <<"\t"<< "accept" <<endl;
                return 1;
            }
            else if (X == a && X != "#")
            {
                Symbolzhan.pop_back();
                ip++;
                cout << step++ << "\t";
                cout << "/";
                cout << "\t" << X << "#" << a << "\t"
                     << "move" << endl;
            }
        }
        else
        {
            if (PredictTable[X].count(a) != 0)
            {
                Production Y1Y2Y3 = PredictTable[X][a];
                Symbolzhan.pop_back();
                for (int i = Y1Y2Y3.rights.size() - 1; i >= 0; i--)
                {
                    if (Y1Y2Y3.rights[i] != "$")
                        Symbolzhan.push_back(Y1Y2Y3.rights[i]);
                }
                cout << step++ << "\t" << Y1Y2Y3.id << "\t" << X << "#" << a << "\t"
                     << "reduction" << endl;
            }
            else
            {
                cout << "错误" << endl;
                return 0;
            }
        }
    }
    return 0;
}
