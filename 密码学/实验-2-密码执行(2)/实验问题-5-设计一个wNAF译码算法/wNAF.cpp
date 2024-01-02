#include <iostream>

using namespace std;
#define ul long long

ul mods(ul k,int w2){
    int temp = k % w2;
    ul u = w2 - temp >=temp ? temp : temp- w2;
    return u;
}

int wNAF(int w,ul k, ul *ki){
    int i = 0;
    int w2 = 1;
    for(int j = 0;j<w;j++){
        w2 = w2 * 2;
    }
    // cout<<w2<<endl;
    
    while (k>=1)
    {
        if(k%2){
            ki[i] = mods(k,w2);
            k = k - ki[i];
        }
        else{
            ki[i] = 0;
        }
        k = k/2;
        i = i + 1;
    }
    // cout<<i<<endl;
    // for(int j = 63;j>=0;j--){
    //     cout<<ki[i]<<" ";
    // }
    return i;
}

int main(){
    ul ki[64];
    // ul *ki = new ul[64];
    int w;
    ul k;
    cout<<"Please enter -> w:";
    cin>>w;
    cout<<"Please enter -> k:";
    cin>>k;
    int i = wNAF(w,k,ki);
    cout<<"wNAF as follow:"<<endl;
    for(int j = i-1;j>=0;j--){
        cout<<ki[j]<<" ";
    }
    // ki.delete()
    cout<<endl;
    return 0;
}