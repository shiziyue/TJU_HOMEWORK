#include <iostream>
#include <time.h>
#include <stdlib.h>
using namespace std;
#define MAX_64num 18446744073709551615
#define CONFIDENCE_t 10

//#define MAX_64num 9223372036854775807
typedef unsigned long long ul;

ul save_prim[45] = {3,5,7,11,13,17,19,23, 29, 31, 37, 41, 43, 47, 53, 59, 61,
67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149,
151, 157, 163, 167, 173, 179, 181, 191, 193, 197,199};


ul mod2(ul a, ul b, ul n){
    ul big1[2]={0, 0};
    ul d = 0;
    ul tmp1 = 0, tmp2 = 0;
    int i = 0;
    for(i; i<64; i++){
        tmp1 = a * ((b>>(63-i))&1);
        if((2*d)<d){
            ul tmp = d;
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

//模函数 C=M^e mod n
ul rsa_modExp(ul M, ul e, ul n)
{
    ul res = 1;
    while(e > 0) {
         /* Need long multiplication else this will overflow...
         必须使用长乘法，否则这将溢出*/
        if(e & 1) {
            //res = (res * M) % n;
            res = mod2(res,M,n);
         }
        e = e >> 1;
        //M = (M * M) % n; /* Same deal here */
        M = mod2(M,M,n);
     }
    return res;
}

//Miller-Rabin输入一个奇整数n>3，和一个安全参数t>=1
//输出 1为素数，0为合数
bool MILIERRABIN(ul n,int t){
    if(n<=3 || t<1) return 0;
    ul r = n-1;
    int s = 0;
    while((r & 0x1)==0 && r){//(1)写n-1=2^s * r
        r = r >> 1;
        s++;
    }
    //cout<<"s:"<<s<<endl;
    //cout<<"r:"<<r<<endl;
    for(int i=0;i<t;i++){
        srand((ul)time(0));
        ul a = (rand() % (n-2-2+1)) + 2; //选择一个随机整数 a, 2<=a<=n-2
        //cout<<"a:"<<a<<endl;
        ul y = rsa_modExp(a,r,n);//计算 y = a^r(mod n)
        //cout<<"y:"<<y<<endl;
        if(y!=1 && y!=n-1){
            int j = 1;
            while(j<=s-1 && y!=n-1){
                y = rsa_modExp(y,y,n);//计算 y = y^2(mod n)
                if(y==1){
                    //cout<<n<<"为合数"<<endl;
                    return 0;
                }
                j = j + 1;
            }
            if(y!=n-1){
                //cout<<n<<"为合数"<<endl;
                return 0;
            }
        }
    }
    //cout<<n<<"为素数"<<endl;
    return 1;
}

//生成比特长度为L的素数
// ul gen_prime_limit_L(int L){
//     ul limt_s = 0x1<<L; //限制s的规模
//     ul s = (rand()|limt_s)%(limt_s-1)|limt_s>>1; //保证s的比特长度正好等于所计算的
//     while(!MILIERRABIN(s,CONFIDENCE_t)){
//         s = (rand()|limt_s)%(limt_s-1)|limt_s>>1;
//     }
//     return s;
// }
ul gen_prime_limit_L(int L){
    ul limt_s = 0x1<<L; //限制s的规模
    ul s; //保证s的比特长度正好等于所计算的
    int i;
    while (true)
    {
       s = (rand()|limt_s)%(limt_s-1)|limt_s>>1;
       bool cont = true;
        for(i=0; i<45; i++){
            if(s%save_prim[i]==0&&s!=save_prim[i]){
                cont = false;
                break;
            }
        }    
        if(cont){
            if(MILIERRABIN(s,CONFIDENCE_t)){
                return s;
            }
        }
    }
}

//查看数的比特长度L
int check_L_num(ul num){
    int L = 0;
    for(ul tep = num;tep!=0;tep=tep>>1){  //计算r的比特长度
        L++;
    }
    return L;
}

//根据要求L，返回两个随机的比特长度
void gen_bit_L(int L,int& L_s,int& L_t){
    srand((ul)time(0));//用于产生随机数
    int wuchas,wuchat;// s的比特误差，t的比特误差
    wuchat = wuchas = rand()%9-4; // -4<=wuchas<=4 比特长度误差+-4
    while (wuchat==wuchas)  //比特误差不能相等
    {
        wuchat = rand()%9-4;
    }
    L_s = (L-1)/2 + 1 + wuchas; // L/2 向上取余 再加比特误差；
    L_t = (L-1)/2 + 1 + wuchat;
    L_t = L_s - 2;
}

//Gordon的产生强素数算法，产生强素数p
//指定长度L 的强素数 0<L<=32
//输出比特长度为L的强素数p，p+1的大素因子s,p-1的大素因子r,r-1大素因子t
//(要求：s，r，t比特长度约为l/2，比特长度误差±4；如无符合要求的强素数程序应该给出明确说明)
ul Gordon(int L){
    srand((ul)time(0));//用于产生随机数
    int L_s,L_t;// s的比特长度，t的比特长度
    gen_bit_L(L,L_s,L_t);
    // cout<<"s的比特长度L_s:"<<L_s<<endl;
    // cout<<"t的比特长度L_t:"<<L_t<<endl;
    L_s = L/2;
    L_t = L/2-1;

    cout<<"The bit length of sL_s:"<<L_s<<endl;
    cout<<"The bit length of t -> L_t:"<<L_t<<endl;

    ul s = gen_prime_limit_L(L_s);
    ul t = gen_prime_limit_L(L_t);

    // s = 51427;
    // t = 32119;

    while (1)   //直到跑出符合规格的p
    {

        cout<<"s:"<<s<<endl;
        cout<<"t:"<<t<<endl;
        cout<<"The bit length of s -> L_s:"<<check_L_num(s)<<endl;
        cout<<"The bit length of t -> L_t:"<<check_L_num(t)<<endl;
        //选择一个整数i0，在序列i0,i0+1,i0+2...中发现第一个素数i，r = 2*i*t+1
        ul i0 = 0;
        ul r;
        for(i0;;i0++){
            r = 2*i0*t+1;
            if(MILIERRABIN(r,CONFIDENCE_t))
                break;
        }

        int L_r = check_L_num(r);
        cout<<"The bit length of r -> Lforr:"<<L_r<<endl;
        cout<<"r:"<<r<<endl;

        //计算p0 = 2*(s^(r-2)(mod r)*s-1
        ul p0 = 2*rsa_modExp(s,r-2,r)*s-1;
        int L_p0 = check_L_num(p0);
        cout<<"The bit length of p0 ->  Lforp0:"<<L_p0<<endl;
        cout<<"p0:"<<p0<<endl;
        if(L_p0>L){//如果p0都大的话，直接取小
            //s = gen_prime_limit_L(L_s-1);
            t = gen_prime_limit_L(check_L_num(t)-1);
            continue;
        }
        ul p;
        ul j0 = 0;
        for(j0;;j0++){
            p = p0+2*j0*r*s;
            // cout<<"p:"<<p<<endl;
            if(MILIERRABIN(p,CONFIDENCE_t))break;
        }

        int L_p = check_L_num(p);
        cout<<"The bit length of p -> L_p:"<<L_p<<endl;
        cout<<"p:"<<p<<endl;
        if(L_p==L){
            cout<<"FIND IT!!!!!!!!!!!!!!!!!!!!!"<<endl;
            cout<<"\ts:"<<s<<endl;cout<<"\tThe bit length of s -> L_s:"<<check_L_num(s)<<endl;
            cout<<"\tt:"<<t<<endl;cout<<"\tThe bit length of t -> L_t:"<<check_L_num(t)<<endl;
            cout<<"\tr:"<<r<<endl;cout<<"\tThe bit length of r -> L_r:"<<L_r<<endl;
            cout<<"\tp:"<<p<<endl;cout<<"\tThe bit length of p -> L_p:"<<L_p<<endl;
            return p;
        }
        else if (L_p>L)
        {
            t = gen_prime_limit_L(L_t-1);
            cout<<"P too big"<<endl;
        }
        else {
            t = gen_prime_limit_L(check_L_num(t)+1);
            cout<<"P too small"<<endl;
        }
    }

}

int main(){
    int l;
    cout<<"Please enter the bit length to generate the prime number:";
    cin>>l;
    Gordon(l);
}