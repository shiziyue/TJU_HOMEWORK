#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include <set>
#include <map>
using namespace std;

struct Production //产生式
{
    string id;                   //  产生式的序号
    string left;                 //  产生式左侧符号
    string right;                //  产生式右侧符号
    vector<string> rights; //产生式右侧符号集
    Production(){};
    Production(string line)
    {
        int numid = line.find(".");
        int jiantou = line.find("->");
        if (numid == string::npos || jiantou == string::npos)
        {
            cout << "grammar.txt 中语法定义格式有错误" << endl;
            return;
        }
        id = line.substr(0, numid);                         //找到  .
        left = line.substr(numid + 1, jiantou - numid - 2); //找到箭头->
        this->right = line.substr(jiantou + 3);
        stringstream ss(right);
        while ((!ss.eof())) //按照空格分开
        {
            string temp;
            ss >> temp;
            if (temp != "")
                rights.push_back(temp);
        }
    }
};

struct Grammar
{
    set<string> Terms;              //终结符
    set<string> UTerms;             //非终结符
    vector<Production> productions; //语法的产生式集合
    Grammar(string path)
    {
        ifstream infile(path);
        string line;
        while (getline(infile, line))
        {
            if (line == "")
            {
                continue;
            }
            productions.push_back(Production(line)); //将每一行读取进产生式
        }
        infile.close();
        int num = productions.size();
        for (int i = 0; i < productions.size(); i++)
        { //在产生式左侧的全是非终结符
            UTerms.insert(productions[i].left);
        }
        for (int i = 0; i < productions.size(); i++)
        { //如果产生式的右侧符号不能在非终结符中找到
            for (int j = 0; j < productions[i].rights.size(); j++)
            { //则是终结符
                if (UTerms.find(productions[i].rights[j]) == UTerms.end())
                {
                        Terms.insert(productions[i].rights[j]);
                }
            }
        }
    }
};

class Syntax_Analysis
{
public:
    map<string, set<string>> FirstTable;
    map<string, set<string>> FollowTable;
    map<string, map<string, Production>> PredictTable;//<A，<a，产生式>>
    void Init_FirstTable(Grammar grammar);
    void Init_FollowTable(Grammar grammar);
    void Init_PredictTable(Grammar grammar);
    void Print_FirstTable(void);
    void Print_FollowTable(void);
    void Print_PredictTable(Grammar grammar,string path);
    bool Analysis(Grammar grammar,vector<Token>token);
};
