#include <iostream>
#include <unordered_map>
#include <vector>
#include <string>
#include <regex> //正则表达式
using namespace std;

unordered_map<string, string> KW{
    {"SELECT", "1"}, {"FROM", "2"}, {"WHERE", "3"}, {"AS", "4"}, {"*","5"},{"INSERT", "6"}, {"INTO", "7"}, {"VALUES", "8"}, {"VALUE","9"}, {"DEFAULT","10"}, {"DELETE", "10"}, {"UPDATE","11"},{"SET","12"},{"DELETE","13"},{"JOIN", "14"}, {"LEFT", "15"}, {"RIGHT", "16"}, {"ON","17"},{"MIN", "18"}, {"MAX", "19"}, {"AVG", "20"}, {"SUM", "21"}, {"UNION", "22"}, {"ALL", "23"}, {"GROUPBY", "24"}, {"HAVING", "25"}, {"DISTINCT", "26"}, {"ORDERBY", "27"}, {"TRUE", "28"}, {"FALSE", "29"},{"UNKNOWN","30"},{"IS", "31"}, {"NULL", "32"}};
unordered_map<string, string> OP{
    {"=", "1"},
    {">", "2"},
    {"<", "3"},
    {">=", "4"},
    {"<=", "5"},
    {"!=", "6"},
    {"<=>", "7"},
    {"AND", "8"},
    {"&&", "9"},
    {"OR", "10"},
    {"||", "11"},
    {"XOR", "12"},
    {"NOT", "13"},
    {"!","14"},
    {"-","15"},
    {".","16"}
};
unordered_map<string, string> SE{
    {"(", "1"}, {")", "2"}, {",", "3"}};

struct Token
{
    string cifadanyuan;
    struct Value
    {
        string zhongbie;
        string neirong;
    } value;
    Token() {}
    void CreaToken(string cifadanyuan, string zhongbie, string neirong)//返回的三元组
    {
        this->cifadanyuan = cifadanyuan;
        this->value.zhongbie = zhongbie;
        this->value.neirong = neirong;
    }
    string Tokentostring()
    {
        return this->cifadanyuan + '\t' + "<" + this->value.zhongbie + "," + this->value.neirong + ">";
    }
};

class Sqlprase
{
public:
    char *now;
    char tep[20];

    Sqlprase(char *start) { this->now = start; } //初始化

    Token ParseIDN(void);
    Token ParseINT(void);
    Token ParseOP(void);
    Token ParseSE(void);
    Token ParseSTR(void);
    vector<Token> ParseMain(void); //词法分析主函数
};
