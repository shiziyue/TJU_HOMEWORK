#include <iostream>
#include <stdlib.h>
#include <vector>

using namespace std;

#define ul64 unsigned long long

int check_L_num(ul64 num){
    int L = 0;
    for(ul64 tep = num;tep!=0;tep=tep>>1){  //计算r的比特长度
        L++;
    }
    return L;
}

vector<string> k_ary(ul64 e,int k){
    vector<string> kuai;
    int e_length = check_L_num(e);
    char e_str[64];
    itoa(e,e_str,2);
    int yu = e_length % k;
    int bu = k-yu;
    int i = yu;
    if(i){
        string temp;
        while (bu)
        {
            temp.append("0");
            bu--;
        }
        for(int j = 0; j < i;j++)
            temp = temp + e_str[j];
        kuai.push_back(temp);
        //cout<<temp<<endl;
    }
    while (i < e_length-yu)
    {
        string temp;
        for(int j=i;j<i+k;j++){
            temp = temp + e_str[j];
        }
        kuai.push_back(temp);
        //cout<<temp<<endl;
        i = i + k;
    }
    
    
    // cout<<e_length<<endl;
    printf("e: %lld The binary of e is :%s\r\n",e,e_str);
    cout<<"e k-ary:"<<endl;
    for(auto iter=kuai.begin();iter!=kuai.end();iter++){
        cout<<*iter<<"  ";
    }
    cout<<endl;
    return kuai;
}

int main(){
    ul64 e;
    cout<<"Please enter e:";
    cin>>e;
    cout<<"Please enter k:";
    int k;
    cin>>k;
    k_ary(e,k);
}
