#include"production.h"
#include<string>
#include <sstream>
int main(){
    cout<<endl;
    // for(auto iter = Rules.begin();iter!=Rules.end();iter++){
    //     cout<<iter->first<<endl;
    //     for(auto it = iter->second.first.begin();it!=iter->second.first.end();it++){
    //        cout<<*it<<endl;
    //     }
    //     cout<<iter->second.second<<endl;
    // }
    cout<<"请输入要查询的关键字用英文逗号隔开："<<endl;
    string str,tmp;		
    cin>>str;
    stringstream input(str);
    while (getline(input, tmp, ',')) Cdata.base.insert(tmp);
    Cdata.now=Cdata.base;
    cout<<endl;
    cout<<"综合数据库:";
    for(auto i=Cdata.now.begin();i!=Cdata.now.end();i++){
        cout<<*i<<" ";
    }
    cout<<endl;
    cout<<endl;
    // for(auto i=Cdata.base.begin();i!=Cdata.base.end();i++){
    //     cout<<*i<<endl;
    // }
    illation();
    for(auto i=Cdata.process.begin();i!=Cdata.process.end();i++){
        cout<<"     使用的产生式规则序号为：";
        cout<<i->first<<endl;
        cout<<"         当前综合数据库状态：";
        for(auto iter = i->second.begin();iter!=i->second.end();iter++){
            cout<<*iter<<"  ";
        }
        cout<<endl;
        cout<<endl;
    }
    cout<<"最终结果:    "<<Cdata.result<<endl;
}
