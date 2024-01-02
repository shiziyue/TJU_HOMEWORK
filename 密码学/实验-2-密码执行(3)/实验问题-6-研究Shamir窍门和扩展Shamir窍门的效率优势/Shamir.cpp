#include <iostream>
using namespace std;

#define ul_64 unsigned long long
#define MAX_64num 18446744073709551615
//ghabp
//g^ah^b(mod p)

int get_L(ul_64 num){
    int L = 0;
    for(ul_64 tep = num;tep!=0;tep=tep>>1){  //计算r的比特长度
        L++;
    }
    return L;
}

ul_64 mod2(ul_64 a, ul_64 b, ul_64 n){
    ul_64 big1[2]={0, 0};
    ul_64 d = 0;
    ul_64 tmp1 = 0, tmp2 = 0;
    int i = 0;
    for(i; i<64; i++){
        tmp1 = a * ((b>>(63-i))&1);
        if((2*d)<d){
            ul_64 tmp = d;
            big1[1] = MAX_64num - tmp;
            big1[0] = MAX_64num - n;
            tmp = tmp - big1[1];
            tmp = tmp + big1[0];
            tmp2 = tmp;
        }
        else{
            tmp2 = (2 * d)%n;
        }
        if((tmp1+tmp2)<tmp1){
            big1[1] = MAX_64num - tmp2;
            big1[0] = MAX_64num - n;
            d = tmp1 - big1[1];
            d = d + big1[0];
        }
        else{
            d = (tmp1+tmp2)%n;
        }
    }
    return d;
}

ul_64 Shamir(ul_64 g,ul_64 h,ul_64 a,ul_64 b,ul_64 p,int & m){
    m = 0;
    ul_64 gh = g*h;
    m++;
    ul_64 A = 1;
    ul_64 ai,bi;
    int t = get_L(a)>get_L(b)?get_L(a):get_L(b);
    for(int i = t;i>=0;i--){
        if(i!= t){
            // A = A*A;
            A = mod2(A,A,p); 
            m++;
        }
        ai = (a>>i)&1;
        bi = (b>>i)&1;
        if(ai!=0||bi!=0){
            if(ai!=0 && bi==0)
            { //A = A*g; 
                A = mod2(A,g,p);
                m++;}
            else if(bi!=0 && ai==0){ 
                //A = A*h; 
                A = mod2(A,h,p);
                m++;}
            else { 
                //A = A*g*h; 
                A = mod2(A,gh,p);
                m++;}
        }
    }
    return A;
}

int NAF(ul_64 a,int *d){
    int t_a = get_L(a);
    int ci = 0;
    int ci1;
    for(int i=0;i<=t_a;i++){
        ci1 = (int)(((int)((int)((a>>i)&1)+(int)((a>>(i+1)&1)))+ci)/2); //(int)(a/b) -1
        d[i] = (int)((a>>i)&1)+ci-2*ci1;
        ci = ci1;
    }
    return t_a;
}

ul_64 exp_Shamir(ul_64 g,ul_64 h,ul_64 a,ul_64 b,ul_64 p,int & n){
    n = 0;
    int d[64] = {0};
    int f[64] = {0};
    int t = NAF(a,d);
    int t_b = NAF(b,f);
    t = t>t_b?t:t_b;

    // cout<<"wNAF如下:"<<endl;
    // for(int j = t;j>=0;j--){
    //     cout<<d[j]<<" ";
    // }cout<<endl;
    // cout<<"wNAF如下:"<<endl;
    // for(int j = t;j>=0;j--){
    //     cout<<f[j]<<" ";
    // }cout<<endl;

    float g_1 = 1/g, h_1 = 1/h, g_1h = h/g, gh_1 = g/h, g_1h_1 = 1/(g*h), gh = g*h;
    n = n+4;
    ul_64 A = 1;
    for(int i = t;i>=0;i--){
        // cout<<A<<endl;
        if(i!=t){ A = mod2(A,A,p);n++;}
        if(d[i]!=0||f[i]!=0){
            // cout<<"12"<<endl;
            if(d[i]==0&&f[i]==1){A = A*h;n++;}
            else if(d[i]==0&&f[i]==-1){A = A*h_1;n++;}
            else if(d[i]==1&&f[i]==1){A = A*gh;n++;}
            else if(d[i]==1&&f[i]==0){A = A*g;n++;}
            else if(d[i]==1&&f[i]==-1){A = A*g/h;n++;}
            else if(d[i]==-1&&f[i]==-1){A = A/g/h;n++;}
            else if(d[i]==-1&&f[i]==0){A = A/g;n++;}
            else if(d[i]==-1&&f[i]==1){A = A*g/h;n++;}
        }
    }
    return A;
}

int main(){
    int m;
    ul_64 g,h,a,b,p;
    cout<<"Please Enter -> g:";
    cin>>g;
    cout<<"Please Enter -> h:";
    cin>>h;
    cout<<"Please Enter -> a:";
    cin>>a;
    cout<<"Please Enter -> b:";
    cin>>b;
    cout<<"Please Enter -> p:";
    cin>>p;
    // ul_64 B = Shamir(2,2,3,7,10000,m);
    ul_64 B = Shamir(g,h,a,b,p,m);
    cout<<endl;
    cout<<"g^a*h^b(mod p):"<<B<<endl;
    cout<<"The number of multiplications required for Shamir's trick:"<<m<<endl;
    // int m;
    ul_64 A = exp_Shamir(g,h,a,b,p,m);
    cout<<"g^a*h^b(mod p):"<<A<<endl;
    cout<<"The number of multiplications required for Exp-Shamir's trick:"<<m<<endl;
}
