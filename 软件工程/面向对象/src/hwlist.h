#include<stdio.h>
#include"courselist.h"
class Hwlist
{
private:
    int here[cnum*hwnum]={0};
    hwork hwlist[cnum*hwnum];
public:
   
    void addhw(Courselist,char*);
    void showhwlist(void);
};

int searchcourse(Courselist clist,char* name){
        int i;
    for(i=0;i<cnum;i++){
        if(strcmp(clist.list[i].cname,name)==0){
            return i;
        }
        i++;
    }
    if(i==cnum){
        return -1;
    }
    return -1;
}
int emptyhw(course course1){
    int i;
    for(i=0;i<hwnum;i++){
        if(strcmp(course1.hworks[i].title,"")==0){
            return i;
        }
        i++;
    }
    if(i==hwnum){
        return -1;
    }
    return -1;
}
void Hwlist::addhw(Courselist clist,char* name){
    hwork nowhw;
    char com[20];
    char dead[20];
    if(int index=searchcourse(clist,name)!=-1){
        if (int x=emptyhw(clist.list[index])!=-1)
        {
            printf("请输入作业标题:\n");
             scanf("%s",com);
            printf("请输入截至日期:月-日-时-分\n");
            scanf("%s",dead);
            strcpy(nowhw.title,com);
            strcpy(nowhw.deadline,dead);
            char yn[2];
            printf("确定要添加吗？y/n\n");
            scanf("%s",yn);
            if(strcmp(yn,"y")==0){
                clist.list[index].hworks[x]=nowhw;
                this->here[index*x]=1;
                this->hwlist[index*x]=nowhw;
                printf("添加作业成功\n");
                return;
            }
            else{
                printf("成功取消!\n");
                return;
            }
        }
        else{
             printf("你这科作业也太多了，先写几个吧\n");
             return;
        }
    }
    else{
        printf("没有这个课程，请先添加课程\n");
        return;
    }
}
void Hwlist::showhwlist(){
    int i=0;
    int index=1;
    while(i<cnum*hwnum){
        if(this->here[i]){
            printf("作业情况如下：\n");
            printf("第%d项作业--%s--%s\n",index,this->hwlist[i].title,this->hwlist[i].deadline);
            index++;
        }
        i++;
    }
}



