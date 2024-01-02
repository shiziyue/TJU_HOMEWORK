#include <iostream>
#include <string.h>
#include "rsa_fuc.c"


using namespace std;

int main(){
    cout<<"Please select RSA Secret (en) or Decrypt (de):"<<endl;
    string model;
    cin>>model;
    if(model == "en"){
        struct encrypt_data en;
        cout<<"Please enter a prime number -> p:";   cin>>en.p;    cout<<endl;
        cout<<"Please enter a prime number -> q:";   cin>>en.q;    cout<<endl;
        cout<<"Please enter -> e:";   cin>>en.e;    cout<<endl;
        cout<<"Please enter -> m:";   cin>>en.m;    cout<<endl;
        //Fermat素性测试
        cout<<"Proceeding against p:"<<en.p<<","<<"q:"<<en.q<<"Perform a primacity test:"<<endl;
        if((!Fermatpritest(en.p,3))||!Fermatpritest(en.q,3)){
            cout<<"p,q does not conform to the prime form."<<endl;
            return 0;
        }
        //对e做参数检查
        cout<<"Proceeding against e:"<<en.e<<"和"<<"fai:"<<(en.p-1)*(en.q-1)<<"Perform a coprime test:"<<endl;
        if(gcd(en.e,(en.p-1)*(en.q-1))!=1){
            cout<<"e, fai is not interprime, wrong"<<endl;
            return 0;
        }
        else cout<<"e, fai coprime, calculation"<<endl;

        uli c = rsa_encrypt(en);
        cout<<"The encrypted information is c:"<<c<<endl;
        
    }
    else if(model == "de"){
        struct decrypt_data de;
        cout<<"Please enter a prime number -> p:";   cin>>de.p;    cout<<endl;
        cout<<"Please enter a prime number -> q:";   cin>>de.q;    cout<<endl;
        cout<<"Please enter -> d:";   cin>>de.d;    cout<<endl;
        cout<<"Please enter -> c:";   cin>>de.c;    cout<<endl;
        //cout<<"正在通过输入的p:"<<de.p<<"和"<<"q:"<<de.q<<"计算唯一正数d:"<<endl;
        //对e做参数检查待补充

        uli c = rsa_decrypt(de);
        cout<<"After decryption, the information is m:"<<c<<endl;
    }
    else{
        cout<<"Please re-enter the program selection"<<endl;
    }
    return 0;
}
