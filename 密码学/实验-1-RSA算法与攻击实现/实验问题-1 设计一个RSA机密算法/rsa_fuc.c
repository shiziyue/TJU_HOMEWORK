#include <stdbool.h>
#include <time.h>
#include <stdlib.h>
using namespace std;

#define MAX_64num 18446744073709551615


typedef unsigned long long uli;

bool flag;  //用于提示输入是否符合规范，若不重新输入
//加密
struct encrypt_data
{
    uli p;
    uli q;
    uli e;
    uli m;
};
//解密
struct decrypt_data
{
    uli p;
    uli q;
    uli d;
    uli c;
};

uli gcd(uli a, uli b)
{
  uli c;
  while ( a != 0 ) {
    c = a; a = b%a;  b = c;
  }
  return b;
}

//扩展欧几里得算法，计算唯一整数d
// a fai,b e
uli ExtEuclid(uli a, uli b)
{
 uli x = 0, d = 1, u = 1, v = 0, gcd = b, m, n, q, r;
 while (a!=0) {
   q = gcd/a; r = gcd % a;
   m = x-u*q; n = d-v*q;
   gcd = a; a = r; x = u; d = v; u = m; v = n;
   }
   return d;
}

uli mod2(uli a, uli b, uli n){
    uli big1[2]={0, 0};
    uli d = 0;
    uli tmp1 = 0, tmp2 = 0;
    int i = 0;
    for(i; i<64; i++){
        tmp1 = a * ((b>>(63-i))&1);
        if((2*d)<d){
            uli tmp = d;
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
uli rsa_modExp(uli M, uli e, uli n)
{
    uli res = 1;
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

//Fermat素性测试
bool Fermatpritest(uli n,uli ref){
    srand((unsigned)time(NULL));
    uli i;
    for(i=0;i<ref;i++){
        uli a = (rand() % (n-2-2+1)) + 2;//随机选取整数a,2<=a<=n-2
        uli r = (uli)rsa_modExp(a,n-1,n);
        if(r!=1){
            cout<<"---"<<n<<"It is a composite number, does not meet the specifications, please re-enter the procedure"<<endl;
            return 0;
        }
    }
    cout<<"---"<<n<<"is prime, conforms to the specification, and continues execution"<<endl;
    return 1;
}

//rsa加密函数
uli rsa_encrypt(struct encrypt_data data)
{
    uli c = rsa_modExp(data.m,data.e,data.p*data.q);

    return c;
}

//rsa解密函数
uli rsa_decrypt(struct decrypt_data data)
{
    //cout<<data.p*data.q<<endl;
    uli c = rsa_modExp(data.c,data.d,data.p*data.q);

    return c;
}
