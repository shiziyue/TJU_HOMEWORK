#include<bits/stdc++.h>
#include<cmath>
#define ll long long
using namespace std;
ll c[110],n[110];
ll k;
inline int read()
{
   int x=0,f=1;
   char ch=getchar();
   while(ch<'0'||ch>'9'){
       if(ch=='-')
           f=-1;
       ch=getchar();
   }
   while(ch>='0'&&ch<='9'){
       x=(x<<1)+(x<<3)+(ch^48);
       ch=getchar();
   }
   return x*f;
}
inline ll mod_ADD(ll a, ll b, ll m)
{
    ll res=0;
    while(b>0)
    {
        if(b&1)res=(res+a)%m;
        a=(a+a)%m;
        b>>=1;
    }
    return res;
}
inline void exgcd(ll a,ll b,ll &x,ll &y)
{
    if(b==0)
    {
        x=1,y=0;
        return;
    }
    exgcd(b,a%b,x,y);
    int tmp=x;
    x=y,y=tmp-a/b*y;
    return;
}
ll China()
{
    ll ans=0,m=1;
    for(ll i=1;i<=k;i++)
        m*=n[i];
    ll x,y;
    for(ll i=1;i<=k;i++)
    {
        ll p=m/n[i];
        exgcd(p,n[i],x,y);
        x=(x%n[i]+n[i])%n[i];
        ans=(ans+mod_ADD(mod_ADD(p,x,m),c[i],m))%m;
    }
    return (ans+m)%m;
}
int main()
{
    k = 3;
    c[1] = 352596;
    c[2] = 408368;
    c[3] = 6728;
    n[1] = 763813;
    n[2] = 828083;
    n[3] = 720761;
    int i;
    cout<<"Whether to use the default test sample?,1 to use ,0 not"<<endl;
    cin>>i;
    if(i){
        k = 3;
        c[1] = 352596;
        c[2] = 408368;
        c[3] = 6728;
        n[1] = 763813;
        n[2] = 828083;
        n[3] = 720761;
    }
    else{
        cout<<"Please enter-> C[1]"<<endl;
        cin>>c[1];
        cout<<"Please enter-> C[2]"<<endl;
        cin>>c[2];
        cout<<"Please enter-> C[3]"<<endl;
        cin>>c[3];
        cout<<"Please enter-> n[1]"<<endl;
        cin>>n[1];
        cout<<"Please enter-> n[2]"<<endl;
        cin>>n[2];
        cout<<"Please enter-> n[3]"<<endl;
        cin>>n[3];
    }
    //cout<<China()<<endl;;
    ll m3 = China();
    cout<<pow(m3,1.0/3);
    return 0;
}