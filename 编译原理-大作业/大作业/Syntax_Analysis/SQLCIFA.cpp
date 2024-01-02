#include "SQLCIFA.h"

Token Sqlprase::ParseIDN(void)
{
    memset(tep,0,20);
    Token token;
    int i;
    regex reg("^[a-zA-Z_]([a-zA-Z0-9_]+)?$"); //以字母或下划线开头，包含字母、数字、以及下划线
    for (i = 0;; now++)                       //为字母、数字和下划线（_）组成的不以数字开头的串
    {
        tep[i++] = *now;
        if (!regex_match(tep, reg)||*now=='\0')
            break;
    }
    tep[i - 1] = '\0';
    string s = (string)tep;
    if (KW.find(s) != KW.end()) //在关键字KW中可以找到
    {
        auto iter = KW.find(s);
        token.CreaToken(s, "KW", iter->second);
        return token;
    }
    //这里需要注意在OP中会出现AND，OR，XOR也是reg的格式，所以要在这里判断
    else if (!strcmp(tep, "OR") || !strcmp(tep, "AND") || !strcmp(tep, "XOR") || !strcmp(tep, "NOT"))
    {
            auto iter = OP.find(s);
            token.CreaToken(s, "OP", iter->second);
    }
     else if((!strcmp(tep,"ORDER")||!strcmp(tep,"GROUP"))&&*now+2!='\0'){
        printf("------\n");
        now++;
        tep[i-1]=*now;
        now++;
        tep[i]=*now;
        tep[i+1]='\0';
        s=(string)tep;
        auto iter = KW.find(s);
        token.CreaToken(s, "KW", iter->second);
        now++;
        printf("------\n");
    }
    else //不属于关键字KW,那么就是标识符IDN
    {
        token.CreaToken(s, "IDN", s);
    }
    return token;
};

Token Sqlprase::ParseINT(void)
{
    int i;
    int flag = 1; //用来检查FLOAT类型
    Token token;
    for (i = 0; isdigit(*now) || *now == '.'; now++)//如果中间有.，则更新为FLOAT
    {
        if (*now == '.')
        {
            if (flag)
            {
                flag = 0;
            }
            else
            {
                break;
            }
        }
        tep[i++] = *now;
    }
    tep[i] = '\0';
    if (flag)
    {
        token.CreaToken(tep, "INT", tep);
    }
    else
    {
        token.CreaToken(tep, "FLOAT", tep);
    }
    return token;
};

Token Sqlprase::ParseOP(void)
{
    Token token;
    if (*now == '<' || *now == '>' || *now == '!'||*now == '='||*now=='.')  //(2)>(3)<(4)>=(5)<=(6)!=(7)<=>
    {
        if (*(now + 1) == '=')
        {
            if (*(now + 2) == '>')  //(7)<=>
            {
                tep[0] = *now;
                tep[1] = *(++now);
                tep[2] = *(++now);
                tep[3] = '\0';
                token.CreaToken(tep,"OP","7");
            }
            else    //(4)>=(5)<=(6)!=
            {
                tep[0] = *now;
                tep[1] = *(++now);
                tep[2] = '\0';
                string s = (string)tep;
                auto iter = OP.find(s);
                token.CreaToken(s, "OP", iter->second);
            }
        }
        else    //(1)=(2)>(3)<
        {
            tep[0] = *now;
            tep[1]='\0';
            string s = (string)tep;
            auto iter = OP.find(s);
            token.CreaToken(s, "OP", iter->second);
        }
    }
    else    //(9)&&(10)||
    {
        tep[0] = *now;
        tep[1] = *(++now);
        tep[2] = '\0';
        string s = (string)tep;
        auto iter = OP.find(s);
        token.CreaToken(s, "OP", iter->second);
    }
    now++;
    return token;
};

Token Sqlprase::ParseSE(void)
{
    Token token;
    tep[0] = *now;
    tep[1] = '\0';
    string s = (string)tep;
    auto iter = SE.find(s);
    printf("%s\n",tep);
    token.CreaToken(s, "SE", iter->second);
    now++;
    return token;
};

Token Sqlprase::ParseSTR(void){
    Token token;
    int i;
    for(i=0,now++;*now!='\"';now++){
        tep[i++]=*now;
    }
    tep[i]='\0';
    token.CreaToken(tep,"STRING",tep);
    now++;
    return token;
}

bool isop(char *now)
{
    char temp[10];
    temp[0] = *now;
    temp[1] = '\0';
    regex reg("[=|>|<|!|\\&|\\||.]");
    return regex_match(temp, reg);
};

bool isse(char* now)
{
    char temp[10];
    temp[0] = *now;
    temp[1] = '\0';
    regex reg("[(|)|,]");
    return regex_match(temp, reg);
};

vector<Token>
Sqlprase::ParseMain(void)
{
    vector<Token> returntoken;
    while (*now != '\0')
    {
        while (isspace(*now))
            now++; //如果当前指向空格向后移动
        if (isalpha(*now)||*now=='_') //开头如果是字母，开始寻找标识符（IDN）
        {//注意部分SE可能会识别成IDN需要特别识别
            returntoken.push_back(ParseIDN());
        }
        else if (isdigit(*now)) //开头是数字，则开始寻找整数（INT），浮点数（FLOAT）
        {
            returntoken.push_back(ParseINT());
        }
        else if (isop(now))//如果是OP运算符则开始寻找OP
        {
            returntoken.push_back(ParseOP());
        }
        else if(isse(now))//如果类型为SE
        {
            returntoken.push_back(ParseSE());
        }
        else if(*now=='\"'){//如果开头是"则识别为STR
            returntoken.push_back(ParseSTR());
        }

    }
    return returntoken;
};