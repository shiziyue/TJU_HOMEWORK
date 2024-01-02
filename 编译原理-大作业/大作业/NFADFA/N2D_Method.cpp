#include "N2D.h"

//将需要转化的正则表达式读入
int Read_Regex_Line(Regex_Line *now, string where)
{
    ifstream fp(where);
    string line;
    Regex_Line *point = now;
    if (fp)
    {
        while (getline(fp, line))
        {
            point->next = new Regex_Line;
            point = point->next;
            int start = line.find_first_of(":");
            int end = line.length();
            point->Token_Name = line.substr(0, start);
            point->Token_Regex = line.substr(start + 1, end - start - 1);
            point->next = NULL;
        }
        fp.close();
        return 1;
    }
    else
    {
        cout << "没有正则表达式的规则文件!" << endl;
        return 0;
    }
}
//打印出需要进行转化为NFA的正则表达式
void Regex_Print(Regex_Line now)
{
    Regex_Line *pointer = &now;
    while (pointer->next != NULL)
    {
        pointer = pointer->next;
        cout << pointer->Token_Name << " : " << pointer->Token_Regex << endl;
    }
}
//将每个正则表达式准换为相应的NFA,找到终点和所有输入集合
void NFA_TERMINAL(Regex_Line *now)
{
    Regex_Line *point = now;
    int Maxid = 0;
    for (auto it2 = point->NFA.nfa.begin(); it2 != point->NFA.nfa.end(); it2++)
    {
        if (Maxid < it2->second.end)
            Maxid = it2->second.end;
    }
    for (int i = 0; i <= Maxid; i++)
    {
        pair<int, bool> s(i, false);
        point->NFA.cellstate.insert(s);
    }
    auto iterM = point->NFA.cellstate.find(Maxid);
    iterM->second = true;
    set<int> Termin; // 存储所有终态的集合
    Termin.insert(Maxid);
    bool isnewT = true;
    while (isnewT)
    {
        isnewT = false;
        for (auto iter = Termin.begin(); iter != Termin.end(); iter++)
        {
            for (auto it = point->NFA.nfa.begin(); it != point->NFA.nfa.end(); it++)
            {
                if ((!Termin.count(it->second.start)) && it->first == "*" && it->second.end == *iter)
                {
                    Termin.insert(it->second.start);
                    isnewT = true;
                }
            }
        }
        if (isnewT)
        {
            for (auto ite = Termin.begin(); ite != Termin.end(); ite++)
            {
                auto itM = point->NFA.cellstate.find(*ite);
                itM->second = true;
            }
        }
    }
}
void Find_NFAinput(Regex_Line *now)
{
    for (auto iter = now->NFA.nfa.begin(); iter != now->NFA.nfa.end(); iter++)
    {
        if ((!now->NFA.all_input.count(iter->first)) && iter->first != "*")
        {
            int n = now->NFA.nfa.count(iter->first); // 查找当前输入在 NFA 中的总次数
            pair<string, int> s(iter->first, n);
            now->NFA.all_input.insert(s);
        }
    }
}
void Build_NFA(Regex_Line *now)
{
    Regex_Line *point = now;
    while (point->next != NULL)
    {

        point = point->next;
        int cell_id = 0;
        stack<int> end;
        stack<string> str;
        stack<int> eClourse;
        int IFOR = 0;        // 1代表 | 连接的字符，0则不是
        int orwhichcell = 0; // | 后连接的字符所连接的ℇ的开始状态
        str.push("$");
        eClourse.push(cell_id++);
        string nowregex = point->Token_Regex;
        for (int i = 0; i < nowregex.length(); i++)
        {
            switch (nowregex[i])
            {
            case '?':
            {
                string ch = str.top();
                if (ch == "#")
                {
                    int next = eClourse.top();
                    eClourse.pop();
                    int temp = eClourse.top();
                    eClourse.pop();
                    int prep = eClourse.top();
                    eClourse.push(temp);
                    eClourse.push(next);
                    SE new_cell;
                    new_cell.start = prep;
                    new_cell.end = next;
                    pair<string, SE> s("*", new_cell);
                    point->NFA.nfa.insert(s);
                }
                else
                {
                    eClourse.pop();
                    str.pop();
                    SE new_cell;
                    new_cell.start = eClourse.top();
                    new_cell.end = eClourse.top();
                    pair<string, SE> s(ch, new_cell);
                    point->NFA.nfa.insert(s);
                    pair<string, SE> ss("*", new_cell);
                    point->NFA.nfa.insert(ss);
                }
                break;
            }
            case '(':
            {
                eClourse.push(cell_id++);
                SE new_cell;
                new_cell.end = eClourse.top();
                eClourse.pop();
                new_cell.start = eClourse.top();
                eClourse.push(new_cell.end);
                pair<string, SE> s("*", new_cell);
                point->NFA.nfa.insert(s);
                str.push("(");
                break;
            }
            case '`':
            {
                string whole;
                while (nowregex[++i] != '`')
                {
                    whole += nowregex[i];
                }
                str.push(whole);
                eClourse.push(cell_id++);
                break;
            }
            case '&':
            {
                break;
            }
            case '|':
            {
                string ch = str.top();
                SE new_cell;
                new_cell.end = eClourse.top();
                eClourse.pop();
                new_cell.start = eClourse.top();
                orwhichcell = new_cell.end;
                if (ch != "#")
                {
                    pair<string, SE> s(ch, new_cell);
                    point->NFA.nfa.insert(s);
                }
                str.pop();
                IFOR = 1;
                break;
            }
            case '.':
            {
                string p;
                p.append(".");
                str.push(p);
                eClourse.push(cell_id++);
                break;
            }
            case '-':
            {
                string p;
                p.append("-");
                str.push(p);
                eClourse.push(cell_id++);
                break;
            }
            case '*':
            {
                string ch = str.top();
                if (ch == "#")
                {
                    int nxt = eClourse.top();
                    eClourse.pop();
                    int temp = eClourse.top();
                    eClourse.pop();
                    int prep = eClourse.top();
                    eClourse.push(temp);
                    eClourse.push(nxt);
                    SE p;
                    p.start = prep;
                    p.end = nxt;
                    pair<string, SE> s1("*", p);
                    point->NFA.nfa.insert(s1);
                    p.start = nxt;
                    p.end = prep;
                    pair<string, SE> s2("*", p);
                    point->NFA.nfa.insert(s2);
                }
                else
                {
                    eClourse.pop();
                    str.pop();
                    SE p;
                    p.start = eClourse.top();
                    p.end = p.start;
                    pair<string, SE> s1(ch, p);
                    point->NFA.nfa.insert(s1);
                }
                break;
            }
            case ')': //右括号
            {
                SE p;
                string ch = str.top(); // ch为s的栈顶
                int last = eClourse.top();
                while (ch != "(") //当s栈出栈不到"("时
                {
                    int nxt = eClourse.top();
                    eClourse.pop(); // start出一个栈
                    int pre = eClourse.top();
                    if (ch != "#")
                    {
                        p.start = pre;
                        p.end = nxt;
                        pair<string, SE> s1(ch, p);
                        point->NFA.nfa.insert(s1);
                    }
                    else
                        eClourse.pop();
                    str.pop();
                    ch = str.top();
                }
                end.push(cell_id++);
                p.start = last;
                p.end = end.top();
                pair<string, SE> s1("*", p);
                point->NFA.nfa.insert(s1);
                if (IFOR == 1) //如果括号中有一个 | ，则多一条ℇ
                {
                    p.start = orwhichcell;
                    p.end = end.top();
                    pair<string, SE> s2("*", p);
                    point->NFA.nfa.insert(s2);
                    IFOR = 0;
                }
                str.pop();     //现在把"("出栈
                str.push("#"); //一个"#"压栈
                int top_num = end.top();
                eClourse.push(top_num);
                end.pop();
                break;
            }
            default:
            {
                break;
            }
            }
        }
        string ch = str.top();
        while (ch != "$")
        {
            int nxt = eClourse.top();
            eClourse.pop();
            int pre = eClourse.top();
            if (ch != "#")
            {
                SE p;
                p.start = pre;
                p.end = nxt;
                pair<string, SE> s1(ch, p);
                point->NFA.nfa.insert(s1);
            }
            else
            {
                eClourse.pop();
            }
            str.pop();
            ch = str.top();
        }
        NFA_TERMINAL(point);
        Find_NFAinput(point);
    }
}

//打印相应NFA
void Print_NFA(Regex_Line now)
{
    Regex_Line *point = &now;
    while (point->next != NULL)
    {
        point = point->next;
        cout << "Token: " << point->Token_Name << " 得到的NFA如下" << endl;
        for (auto iter = point->NFA.nfa.begin(); iter != point->NFA.nfa.end(); iter++)
        {
            cout << iter->second.start << " -- " << iter->first << " --> " << iter->second.end << endl;
        }
        cout << "--------------------------------------------" << endl;
        cout << "     NFA状态如下" << endl;
        for (auto it = point->NFA.cellstate.begin(); it != point->NFA.cellstate.end(); it++)
        {
            if (it->second)
            {
                cout << "状态: " << it->first << " 是T" << endl;
            }
            else
                cout << "状态: " << it->first << " 是N" << endl;
        }
        cout << endl;
    }
}

// NFA转换DFA
void NFA2DFA(Regex_Line *now)
{
    Regex_Line *point = now;
    while (point->next != NULL)
    {
        int DFAStateID = 0; // 用来记录 DFA 中每一个状态的编号
        point = point->next;
        // 1 获取 NFA 中所有 State 的 epsilon 闭包，以备后续使用
        for (auto iter1 = point->NFA.cellstate.begin(); iter1 != point->NFA.cellstate.end(); iter1++)
        {
            set<int> epsilonClosure;             // 当前状态节点的 epsilon 闭包
            epsilonClosure.insert(iter1->first); // 任何节点的 epsilon 闭包含有节点自身
            // 对于 NFA 的每一个 State，遍历 NFA 所有的状态转换
            for (auto ite = point->NFA.nfa.begin(); ite != point->NFA.nfa.end(); ite++)
            {
                // 如果对应的状态转换的起点是当前的状态节点，且状态转换的输入是 epsilon
                if (ite->second.start == iter1->first && ite->first == "*")
                {
                    epsilonClosure.insert(ite->second.end); // 将当前状态装换的终点加入到当前 State 的 epsilon 闭包中
                }
            }
            bool func = true; // true 为当前 State 的遍历有发现 epsilon 转化
            while (func)
            {
                func = false;
                // 遍历直接 epsilon 闭包中状态节点
                for (auto it = epsilonClosure.begin(); it != epsilonClosure.end(); it++)
                {
                    for (auto ite = point->NFA.nfa.begin(); ite != point->NFA.nfa.end(); ite++) // 遍历 NFA 的 epsilon 转化
                    {
                        if (ite->second.start == *it && ite->first == "*" && !epsilonClosure.count(ite->second.end))
                        {
                            epsilonClosure.insert(ite->second.end); // 合并完善当前 State 的 epsilon 闭包
                            func = true;
                        }
                    }
                }
            }
            pair<int, set<int>> s1(iter1->first, epsilonClosure); // <当前状态节点, 当前状态节点的 epsilon 闭包>
            point->DFA.SimaC.insert(s1);                          // 存储上述 pair
        }
        // 2 获取初始状态的 epsilon 闭包，找到切入点
        auto iter2 = point->DFA.SimaC.begin();               // 准备遍历所有 State 的 epsilon 闭包
        pair<int, set<int>> s1(DFAStateID++, iter2->second); // State 0 所有的 epsilon 转换能够到达的节点
        point->DFA.NewStatus.insert(s1);                     // 新的 State ID 生成
        // 3 判断开始状态是否为终止状态，是则添加到 DFA 的终态集合中
        // 遍历 DFA 初始 State 的 epsilon 闭包
        for (auto iter3 = iter2->second.begin(); iter3 != iter2->second.end(); iter3++)
        {
            if (point->NFA.cellstate.find(*iter3)->second)
            {
                pair<int, bool> s1(0, true); // 则 DFA 的初态也为终态
                point->DFA.DFAState.insert(s1);
                break;
            }
        }
        if (!point->DFA.DFAState.count(0)) // 若 DFA 的初态闭包汇总不包含 NFA 的终态
        {
            pair<int, bool> s1(0, false); // 则作为非终态加入
            point->DFA.DFAState.insert(s1);
        }
        // 4 构造经过输入弧转化后的新状态集合
        set<set<int>> AllSet; // DFA State 集合，此时只有初态
        for (auto iter4 = point->DFA.NewStatus.begin(); iter4 != point->DFA.NewStatus.end(); iter4++)
        {
            // 遍历 NFA 的所有输入
            for (auto itr3 = point->NFA.all_input.begin(); itr3 != point->NFA.all_input.end(); itr3++)
            {
                // 存储 NFA 中的 State 合集，这些 State 将作为 1 个 State 出现在 DFA 中
                set<int> NewOne;
                for (auto it4 = iter4->second.begin(); it4 != iter4->second.end(); it4++)
                {
                    auto it5 = point->NFA.nfa.find(itr3->first);
                    int num = point->NFA.nfa.count(itr3->first);
                    for (int i = 0; i < num; i++, it5++)
                        if (it5->second.start == *it4 && it5->first == itr3->first) // 找到经过特定输入转换后的 State
                            NewOne.insert(it5->second.end);                         // 把它们加入到新的 State 集合中
                }
                if (!NewOne.empty())
                { // 如果有 NFA State 集合产生
                    set<int> New1;
                    // 转换闭包替换
                    auto it4 = NewOne.begin();
                    for (; it4 != NewOne.end(); it4++)
                    {
                        auto itr = point->DFA.SimaC.find(*it4);
                        New1.insert(itr->second.begin(), itr->second.end());
                    }
                    NewOne.insert(New1.begin(), New1.end());
                    if (!AllSet.count(NewOne))
                    { // 如果现有 State 中不包含此转换闭包// 则添加 DFA State
                        SE ppp;
                        ppp.start = iter4->first;
                        ppp.end = DFAStateID;
                        pair<string, SE> s1(itr3->first, ppp);
                        point->DFA.dfa.insert(s1);
                        it4 = NewOne.begin();
                        for (; it4 != NewOne.end(); it4++)
                        {
                            // 若 DFA State 的集合包含原 DFA 终态
                            // 则新 State 也是终态
                            if (point->NFA.cellstate.find(*it4)->second == true)
                            {
                                pair<int, bool> s2(DFAStateID, true);
                                point->DFA.DFAState.insert(s2);
                                break;
                            }
                        }
                        if (!point->DFA.DFAState.count(DFAStateID))
                        {
                            pair<int, bool> s3(DFAStateID, false);
                            point->DFA.DFAState.insert(s3);
                        }
                        pair<int, set<int>> s4(DFAStateID++, NewOne);
                        point->DFA.NewStatus.insert(s4);
                        AllSet.insert(NewOne);
                    }
                    // 没有新的 NFA State 集合产生
                    else
                    {
                        SE ppp;
                        ppp.start = iter4->first;
                        for (auto iterr = point->DFA.NewStatus.begin(); iterr != point->DFA.NewStatus.end(); iterr++)
                        {
                            if (iterr->second == New1)
                            {
                                ppp.end = iterr->first;
                                break;
                            }
                        }
                        pair<string, SE> s5(itr3->first, ppp);
                        point->DFA.dfa.insert(s5);
                    }
                }
                else
                {
                    SE pp;
                    pp.start = iter2->first;
                    pp.end = -1;
                    pair<string, SE> s6(itr3->first, pp);
                    point->DFA.dfa.insert(s6);
                }
            }
        }
    }
}

//打印相应DFA
void Print_DFA(Regex_Line now)
{
    Regex_Line *point = &now;
    while (point->next != NULL)
    {
        point = point->next;
        cout << "Token: " << point->Token_Name << " 得到的DFA如下" << endl;
        for (auto iter = point->DFA.dfa.begin(); iter != point->DFA.dfa.end(); iter++)
        {
            if (iter->second.end != -1)
                cout << iter->second.start << " -- " << iter->first << " --> " << iter->second.end << endl;
        }
        cout << "--------------------------------------------" << endl;
        cout << "     DFA状态如下" << endl;
        for (auto it = point->DFA.DFAState.begin(); it != point->DFA.DFAState.end(); it++)
        {
            if (it->second)
            {
                cout << "状态: " << it->first << " 是T" << endl;
            }
            else
                cout << "状态: " << it->first << " 是N" << endl;
        }
        cout << endl;
    }
}
// DFA 最小化
void Min_DFA(Regex_Line *now)
{
    Regex_Line *point = now;
    while (point->next != NULL)
    {
        point = point->next;
        //首先划分终态和非终态，并将无后继的状态分出来
        set<int> End;                          //终态划分
        set<int> NotEnd;                       //非终态划分
        set<int> NoNext;                       //无后继划分
        int NoNextState;                       //无后继状态
        auto DFAitem = point->DFA.dfa.begin(); // DFAmap的迭代器
        for (auto iter = point->DFA.DFAState.begin(); iter != point->DFA.DFAState.end(); iter++)
        {
            if (iter->second)
            {
                bool If_Next = false; //标识此状态是否有后继状态
                for (; DFAitem != point->DFA.dfa.end(); DFAitem++)
                {
                    if (DFAitem->second.start == iter->first && DFAitem->second.end != -1)
                    {
                        If_Next = true;
                        break;
                    }
                }
                End.insert(iter->first);
                if (!If_Next)
                { //无后继
                    NoNextState = iter->first;
                }
            }
            else
            { //非终态
                NotEnd.insert(iter->first);
            }
        }
        if (End.size() > 1 && End.count(NoNextState))
        {
            End.erase(NoNextState);
            NoNext.insert(NoNextState);
        }
        pair<set<int>, bool> s1(End, true);
        point->DFA.partition.insert(s1);
        if (!NotEnd.empty())
        { //如果非终态划分不为空
            pair<set<int>, bool> s2(NotEnd, true);
            point->DFA.partition.insert(s2);
        }
        if (!NoNext.empty())
        { //如果无后继划分不为空
            pair<set<int>, bool> s3(NoNext, false);
            point->DFA.partition.insert(s3);
        }

        map<set<int>, set<int>> NeedToDelSets; //<需要删除状态的划分,需要删除的状态>
        bool STOP = false;                     //是否需要继续遍历（即所有划分是否还可再划分）
        int StateAFIN = -1;                    //当前划分内的状态经过当前输入后的状态
        while (!STOP)
        {
            STOP = true;
            //对所有输入进行判断
            for (auto inItem = point->NFA.all_input.begin(); inItem != point->NFA.all_input.end(); inItem++)
            {
                //遍历所有划分
                for (auto Partitem = point->DFA.partition.begin(); Partitem != point->DFA.partition.end(); Partitem++)
                {
                    //遍历当前划分可以再划分
                    if (Partitem->second)
                    {
                        StateAFIN = -1;
                        set<int> BelongAFIN; //当前划分内的状态经过当前输入后的状态  所属的划分(主流划分)
                        for (auto Setiter = Partitem->first.begin(); Setiter != Partitem->first.end(); Setiter++)
                        {
                            auto DFAitem = point->DFA.dfa.find(inItem->first);
                            int num = point->DFA.dfa.count(inItem->first);
                            for (int i = 0; i < num; i++, DFAitem++)
                            {
                                if (DFAitem->second.start == *Setiter && DFAitem->second.end != -1)
                                {
                                    if (DFAitem->second.start == *Setiter && DFAitem->second.end != -1)
                                    {
                                        StateAFIN = DFAitem->second.end;
                                        break;
                                    }
                                }
                                if (StateAFIN != -1) //不等于-1时 则找到后续状态，直接跳出
                                    break;
                            }
                        }
                        if (StateAFIN == -1)
                        { //当前划分没有主流划分，则下一个划分
                            continue;
                        }
                        else
                        { //当前划分有主流划分
                            for (auto which = point->DFA.partition.begin(); which != point->DFA.partition.end(); which++)
                            {
                                //如果某划分内含有此状态则确定一个主流划分
                                if (which->first.count(StateAFIN))
                                {
                                    BelongAFIN = which->first;
                                    break;
                                }
                            }
                        }
                        set<int> FinalPART; //用于存放符合要求的状态
                        for (auto Setiter = Partitem->first.begin(); Setiter != Partitem->first.end(); Setiter++)
                        {
                            int state = -1; //开始对当前划分内的状态进行分组
                            auto DFAit = point->DFA.dfa.find(inItem->first);
                            int num = point->DFA.dfa.count(inItem->first);
                            for (int i = 0; i < num; i++, DFAit++)
                            {
                                if (DFAit->second.start == *Setiter && DFAit->second.end != -1)
                                {
                                    state = DFAit->second.end;
                                    break;
                                }
                            }
                            if (!BelongAFIN.count(state))
                            {                                                                     //如果有后续状态，并且不在主流划分中
                                FinalPART.insert(*Setiter);                                       //则将此（前状态）放到新划分中
                                if (NeedToDelSets.count(Partitem->first))                         //如果已经需要修改
                                    NeedToDelSets.find(Partitem->first)->second.insert(*Setiter); //则把要删除的状态加到第二个集合
                                else                                                              //否则
                                {
                                    set<int> DeleteStatus;
                                    DeleteStatus.insert(*Setiter);
                                    pair<set<int>, set<int>> s1(Partitem->first, DeleteStatus);
                                    NeedToDelSets.insert(s1); //标记当前划分以便一次遍历后修改
                                }
                            }
                        }
                        if (!FinalPART.empty()) //若产生新划分
                        {
                            if (FinalPART.size() == 1)
                            {
                                pair<set<int>, bool> s1(FinalPART, false);
                                point->DFA.partition.insert(s1);
                            }
                            else if (FinalPART.size() > 1)
                            {
                                pair<set<int>, bool> s2(FinalPART, true);
                                point->DFA.partition.insert(s2);
                            }
                        }
                    }
                }
                while (!NeedToDelSets.empty())
                {
                    STOP = false;
                    auto NewSet = NeedToDelSets.begin()->first; //修改后的新划分
                    auto itSet = NeedToDelSets.begin()->second.begin();
                    while (itSet != NeedToDelSets.begin()->second.end()) //删除元素
                    {
                        NewSet.erase(*itSet);
                        itSet++;
                    }
                    point->DFA.partition.erase(NeedToDelSets.begin()->first);
                    NeedToDelSets.erase(NeedToDelSets.begin());
                    if (NewSet.size() == 1)
                    {
                        pair<set<int>, bool> s1(NewSet, false);
                        point->DFA.partition.insert(s1); //插入新划分
                    }
                    else if (NewSet.size() > 1)
                    {
                        pair<set<int>, bool> s1(NewSet, true);
                        point->DFA.partition.insert(s1); //插入新划分
                    }
                }
            }
        }
    }
}
//根据划分构建新状态
void Build_MDFA(Regex_Line *now)
{
    Regex_Line *point = now;
    while (point->next != NULL)
    {

        point = point->next;
        //首先构建MinDFA新状态
        int MDFAID = 0;
        for (auto iter = point->DFA.partition.begin(); iter != point->DFA.partition.end(); iter++)
        {
            pair<int, set<int>> s1(MDFAID++, iter->first);
            point->MDFA.cells_incell.insert(s1);
        }
        //确定所有终态和非终态
        for (auto itM = point->MDFA.cells_incell.begin(); itM != point->MDFA.cells_incell.end(); itM++)
        {
            for (auto itDS = point->DFA.DFAState.begin(); itDS != point->DFA.DFAState.end(); itDS++)
            {
                if (itDS->second && itM->second.count(itDS->first))
                {
                    pair<int, bool> s2(itM->first, true);
                    point->MDFA.MDFAstate.insert(s2);
                    break;
                }
            }
            if (!point->MDFA.MDFAstate.count(itM->first))
            {
                pair<int, bool> s3(itM->first, false);
                point->MDFA.MDFAstate.insert(s3);
            }
        }
        // MinDFA图中 添加结点（边）
        for (auto itM = point->MDFA.cells_incell.begin(); itM != point->MDFA.cells_incell.end(); itM++)
        {
            for (auto itset = itM->second.begin(); itset != itM->second.end(); itset++)
            {
                for (auto itdfa = point->DFA.dfa.begin(); itdfa != point->DFA.dfa.end(); itdfa++)
                {
                    if (itdfa->second.end != -1 && itdfa->second.start == *itset)
                    {
                        for (auto it2 = point->MDFA.cells_incell.begin(); it2 != point->MDFA.cells_incell.end(); it2++)
                        {
                            if (it2->second.count(itdfa->second.end))
                            {
                                SE p;
                                p.start=itM->first;
                                p.end=it2->first;
                                auto itmdfa=point->MDFA.mdfa.find(itdfa->first);
                                int n=point->MDFA.mdfa.count(itdfa->first);
                                bool same=false;
                                for(int i=0;i<n;i++,itmdfa++){
                                    if(itmdfa->second.end==p.end&&itmdfa->second.start==p.start){
                                        same=true;
                                        break;
                                    }
                                }
                                if(!same){
                                    pair<string,SE>s4(itdfa->first,p);
                                    point->MDFA.mdfa.insert(s4);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
//打印最小化DFA
void Print_MDFA(Regex_Line now){
    Regex_Line *point = &now;
    while (point->next != NULL)
    {
        point = point->next;
        cout << "Token: " << point->Token_Name << " 得到的MDFA如下" << endl;
        for (auto iter = point->MDFA.mdfa.begin(); iter != point->MDFA.mdfa.end(); iter++)
        {
            cout << iter->second.start << " -- " << iter->first << " --> " << iter->second.end << endl;
        }
        cout << "--------------------------------------------" << endl;
        cout << "     MDFA状态如下" << endl;
        for (auto it = point->MDFA.MDFAstate.begin(); it != point->MDFA.MDFAstate.end(); it++)
        {
            if (it->second)
            {
                cout << "状态: " << it->first << " 是T" << endl;
            }
            else
                cout << "状态: " << it->first << " 是N" << endl;
        }
        cout << endl;
    }
}


