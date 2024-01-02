#include <iostream>
#include <set>
#include <map>
#include <string>
#include <cstring>
using namespace std;

map<int, pair<set<string>, string>> Rules = {
    {1, {{"毛发"}, "哺乳动物"}},
    {2, {{"奶"}, "哺乳动物"}},
    {3, {{"羽毛"}, "鸟"}},
    {4, {{"飞", "下单"}, "鸟"}},
    {5, {{"吃肉"}, "食肉动物"}},
    {6, {{"犬齿", "有爪", "眼盯前方"}, "食肉动物"}},
    {7, {{"哺乳动物", "蹄"}, "有蹄类动物"}},
    {8, {{"哺乳动物", "反刍动物 "}, "有蹄类动物"}},
    {9, {{"哺乳动物", "食肉动物", "黄褐色", "暗斑点"}, "金钱豹"}},
    {10, {{"哺乳动物", "食肉动物", "黄褐色", "黑色条纹"}, "虎"}},
    {11, {{"有蹄类动物", "长脖子", "长腿", "暗斑点"}, "长颈鹿"}},
    {12, {{"有蹄类动物", "黑色条纹"}, "斑马"}},
    {13, {{"鸟", "长脖子", "长腿", "不会飞", "黑白二色"}, "鸵鸟"}},
    {13, {{"鸟", "游泳", "不会飞", "黑白二色"}, "企鹅"}},
    {14, {{"鸟", "善飞"}, "信天翁"}}};

set<string> Results = {"金钱豹", "虎", "长颈鹿", "斑马", "鸵鸟", "企鹅", "信天翁"};

struct Cdata
{
    set<string> base;
    set<string> now;
    string result;
    map<int, set<string>> process;
} Cdata;

bool illation()
{
    bool flag = 1;
    while (flag) //将继续
    {
        flag = 0;
        for (auto whichru = Rules.begin(); whichru != Rules.end(); whichru++) //循环去规则中寻找
        {
            int n = 0; //查询当前规则产生式左侧在综合数据库中可以找到
            for (auto tofind = whichru->second.first.begin(); tofind != whichru->second.first.end(); tofind++)
            {
                if (Cdata.now.find(*tofind) != Cdata.now.end())
                {
                    n++;
                }
            }
            if (n == whichru->second.first.size()) //如果当前规则可以，则执行当前规则
            {
                flag = 1;
                for (auto tofind = whichru->second.first.begin(); tofind != whichru->second.first.end(); tofind++)
                {
                    auto f = Cdata.now.find(*tofind); //在当前综合数据库中找到当前规则的左部并删除
                    if (f != Cdata.now.end())
                    {
                        Cdata.now.erase(f);
                    }
                }
                Cdata.now.insert(whichru->second.second);                                //将执行的产生式右部加入到当前综合数据库
                Cdata.process.insert(pair<int, set<string>>(whichru->first, Cdata.now)); //把用的规则号加入过程中
            }
        }
    }
    if (Cdata.now.size() == 1)//如果只剩最后一个，则判断是否在结论库
    {
        for (auto iter = Results.begin(); iter != Results.end(); iter++)
        {
            string i = *Cdata.now.begin();
            if (i.compare(*iter) == 0)
            {
                Cdata.result = *iter;
                return 1;
            }
        }
    }
    else
    {
        Cdata.result = "找不到这个动物";
        return 0;
    }
    return 0;
}