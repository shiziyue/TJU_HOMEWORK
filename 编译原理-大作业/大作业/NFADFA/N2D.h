#include <iostream>
#include <fstream>
#include <Windows.h>
#include <string>
#include <vector>
#include <set>
#include <stack>
#include <map>
using namespace std;
typedef struct SE //  相邻状态之间的始末节点
{
    int start; // start-->end
    int end;
} SE;
typedef struct Regex_NFA //  NFA的数据
{
    multimap<string, SE> nfa;   //  相邻节点和所经过的弧
    map<string, int> all_input; //  所经过的弧和相应出现次数
    map<int, bool> cellstate;   //  相应节点的始末
} Regex_NFA;
typedef struct DFA
{
    map<int, set<int>> SimaC;     // <状态ID，状态转换闭包集合>
    map<int, set<int>> NewStatus; // <生成的新状态ID，转换闭包集合>
    multimap<string, SE> dfa;     // 保存DFA（输入-前状态-后状态）
    map<int, bool> DFAState;      // <状态ID，是否终态> DFA所有状态ID
    map<set<int>, bool> partition; // <划分,是否可再分>  true--可再分  false--不可再分
} DFA;
typedef struct MDFA{
    multimap<string,SE>mdfa;// 最小化DFA
    map<int, set<int>> cells_incell;		// <生成的新状态ID，转换闭包集合>
    map<int, bool> MDFAstate;				// <状态ID，是否终态> 最小化DFA的所有状态ID
}MDFA;
typedef struct Line //  保存了每一个正则表达式，NFA，DFA，MINNFA
{
    string Token_Name;  //  token的名称
    string Token_Regex; //  相应的正则
    Regex_NFA NFA;      //当前token的NFA
    DFA DFA;            // token的DFA
    MDFA MDFA;          //token的最小化DFA
    struct Line *next;
} Regex_Line;

//  将需要转化的正则表达式读入
int Read_Regex_Line(Regex_Line *now, string where);

//  打印出需要进行转化为NFA的正则表达式
void Regex_Print(Regex_Line now);

//  将每个正则表达式准换为相应的NFA
void NFA_TERMINAL(Regex_Line *now);
void Build_NFA(Regex_Line *now);
//  打印相应NFA
void Print_NFA(Regex_Line now);


// NFA转换DFA
void NFA2DFA(Regex_Line *now);
//打印相应DFA
void Print_DFA(Regex_Line now);



// DFA 最小化
void Min_DFA(Regex_Line *now);
//根据划分构建新状态
void Build_MDFA(Regex_Line *now);
//打印最小化DFA
void Print_MDFA(Regex_Line now);