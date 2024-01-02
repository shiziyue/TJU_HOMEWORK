#include <string.h>
#include <stdio.h>
#include <stdlib.h>


#define MAX_COURSE 10
#define MAX_HW 5
#define MAX_WI 5
#define EACH_VAR 20

typedef struct Hwork
{
    int exist=0;
    char desp[EACH_VAR];
    char ddline[EACH_VAR];
} Hwork;

typedef struct Cwire
{   
    char chapter[EACH_VAR];
    char fileurl[EACH_VAR];
    /* data */
} Cwire;


typedef struct  Course
{
    char name[EACH_VAR];
    int exist=0;
    char date[EACH_VAR];
    char where[EACH_VAR];
    char meet_num[EACH_VAR];
    Hwork hwork[MAX_HW];
    Cwire cwire[MAX_WI];
} Course;

typedef struct Clist
{
    Course course[MAX_COURSE];
} Clist;


void prtwelcome()//welcome first
{
    printf("===============Welcome===============\n");
    printf("|      Now you are in the master directory\n");
    printf("|Commends are as follow:\n");
    printf("|---addc---添加课程\n");
    printf("|---delc---删除课程(包括课件和作业)\n");
    printf("|---showc---展示课程信息\n");
    printf("|---delhw---添加作业至某课程\n");
    printf("|---showhw---展示所有作业信息\n");
    printf("---cat---你可以使用cat来定位具体的作业或者课程\n");
    printf("=================End=================\n\n");
}

void show_which(Clist clist,int which){

}


void addc(Clist &clist){
    printf("请输入：课程名称, 上课时间,地点,会议号(用空格隔开)\n");
    Course course1;
    scanf("%s",course1.name);
    scanf("%s",course1.date);
    scanf("%s",course1.where);
    scanf("%s",course1.meet_num);
    course1.exist=1;
    int i=0;
    while (i<MAX_COURSE)
    {
        if(clist.course[i].exist==0){
            clist.course[i]=course1;
            break;
        }
        i++;
    }
     if(i==MAX_COURSE){
         printf("你的课太多了，退几个\n\n");
         return;
      }
    printf("添加成功\n\n");
    return;
}

void showc(Clist clist){
    int i;
    int index=1;
    printf("=====课程列表=====\n");
   for(i=0;i<MAX_COURSE;i++){
      if(clist.course[i].exist){
         printf("第%d门课:%s=%s=%s=%s\n",index,clist.course[i].name,clist.course[i].date,clist.course[i].where,clist.course[i].meet_num);
         index++;
      }
   }
   printf("\n");
   return;
}

void delc(Clist &clist){
    int i;
    char name[EACH_VAR];
    showc(clist);
    printf("输入您要删除的课程名称\n");
    scanf("%s",name);
    for(i=0;i<MAX_COURSE;i++){
        if(strcmp(clist.course[i].name,name)==0){
            char yn[2];
            printf("确定要删除=%s=这个课程吗(y/n)\n",clist.course[i].name);
            scanf("%s",yn);
            if(strcmp(yn,"y")==0){
                Course c1;
                clist.course[i]=c1;
                printf("此处还有一个操作将这堂课的课件导出到用户需要的位置（还未实现）\n");
                printf("删除成功!\n\n");
            }
            break;
        }
    }
    if(i==MAX_COURSE){
        printf("未找到您要删除的课程\n\n");
    }
   return;
}

int searchcourse(Clist clist,char* name){
    int i;
    char nam[EACH_VAR];
    strcpy(nam,name);
    for(i=0;i<MAX_COURSE;i++){
        if((strcmp(clist.course[i].name,nam)==0)&&clist.course[i].exist){
            return i;
        }
    }
    if(i==MAX_COURSE){
        return -1;
    }
    return -1;
}

int emptyhw(Course course){
    int i;
    for(i=0;i<MAX_HW;i++){
        printf("%s\n",course.hwork[i].desp);
        if((strcmp(course.hwork[i].desp,"")==0)&&course.hwork[i].exist==0){
            //printf("xxx%d\n",i);
            return i;
        }
    }
    if(i==MAX_HW){
        return -1;
    }
    return -1;
}

void showhw(Clist &clist){
    int index=0;
    int i=0;
    int now=1;
    printf("作业列表如下：\n");
    for ( i = 0; i < MAX_COURSE; i++)
    {
        if(clist.course[i].exist){
            printf("%s的作业有：\n",clist.course[i].name);
            for(index=0;index<MAX_HW;index++)
            {
                if((strcmp(clist.course[i].hwork[index].desp,"")!=0)&&clist.course[i].hwork[index].exist){
                    printf("\t第%d项作业:%s==%s\n",now,clist.course[i].hwork[index].desp,clist.course[i].hwork[index].ddline);
                    now++;
                }
            }
        }
        now=1;
    }
    printf("\n");
    return;
}

void addhw(Clist &clist,char* name){
    int ind,x;
    char na[EACH_VAR];
    strcpy(na,name);
    if((ind=searchcourse(clist,na))!=-1){
        if ( (x=emptyhw(clist.course[ind]))!=-1)
        {
            //printf("xxx%d\n",x);
            Hwork hwork1;
            char desp[EACH_VAR];
            char ddline[EACH_VAR];
            printf("请输入作业标题:\n");
            scanf("%s",hwork1.desp);
            printf("请输入截至日期:月-日-时-分\n");
            scanf("%s",hwork1.ddline);
            hwork1.exist=1;
            char yn[4];
            printf("确定要添加吗？(y/n)\n");
            scanf("%s",yn);
            if(strcmp(yn,"y")==0){
                clist.course[ind].hwork[x]=hwork1;
                //printf("%d %d",ind,x);
                printf(" %s %s",clist.course[ind].hwork[x].desp,clist.course[ind].hwork[x].ddline);
                printf("添加作业成功\n\n");
                return;
            }
            else{
                printf("成功取消!\n\n");
                return;
            }
        }
        else{
             printf("你这科作业也太多了，先写几个吧\n\n");
             return;
        }
    }
    else{
        printf("没有这个课程，请先添加课程\n\n");
        return;
    }
}

void handlemaster(char* commend,Clist &clist){
      if (strcmp(commend,"help")==0)
        {
            /* code */
        }
        else if(strcmp(commend,"addc")==0){
            addc(clist);
        }
        else if(strcmp(commend,"delc")==0){
            delc(clist);
        }
        else if(strcmp(commend,"addhw")==0){
            char name[20];
            showc(clist);
            printf("请输入目标课程名称\n");
            scanf("%s",name);
            addhw(clist,name);
            memset(name,0,strlen(name));
        }
        else if(strcmp(commend,"showc")==0){
            showc(clist);
        }
        else if(strcmp(commend,"showhw")==0){
            showhw(clist);
        }
        else{
            printf("Error Commend!!!    --input =help= for more information\n\n");
        }
        return;
}
