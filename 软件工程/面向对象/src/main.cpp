#include<stdio.h>
//#include<course.h>

#include"hwlist.h"

#include<string.h>
#include<iostream>


using namespace std;

void prtwelcome(){
    printf("===============Welcome===============\n");
    printf("|      Now you are in the master directory\n");
    printf("|Commends are as follow:\n");
    printf("|---addc---添加课程\n");
    printf("|---delc---删除课程(包括课件和作业)\n");
    printf("|---showc---展示课程信息\n");
    printf("|---delhw---添加作业至某课程\n");
    printf("|---showhw---展示所有作业信息\n");
    printf("|---showhw---展示所有作业信息\n");
    printf("---cat---你可以使用cat来定位具体的作业或者课程\n");
    printf("=================End=================\n");
}

void handlemaster(char* commend,Courselist &nowclistn,Hwlist &nowhwlist){
      if (strcmp(commend,"help")==0)
        {
            /* code */
        }
        else if(strcmp(commend,"addc")==0){
            nowclistn.newcourses();
        }
        else if(strcmp(commend,"delc")==0){
            char yn[4];
            char name[20];
            printf("请输入您要删除的课程名称\n");
            scanf("%s",name);
            //cin>>name;

            printf("提交 or 取消，y/n？\n");
            scanf("%s",yn);
            printf("%s\n",name);
             if(strcmp(yn,"y")==0){
                 nowclistn.delcourses(name);
             }
        }
        else if(strcmp(commend,"addhw")==0){
            char which[20];
            printf("请输入要添加的作业的课程:\n");
            scanf("%s",which);
            nowhwlist.addhw(nowclistn,which);
        }
        else if(strcmp(commend,"showc")==0){
            nowclistn.showcourses();
        }
        else if(strcmp(commend,"showhw")==0){
            nowhwlist.showhwlist();
        }
        else{
            printf("Error Commend!!!    --input =help= for more information\n");
        }
}
void handlecourses(course &course1,char*commend){

}
void handehomeworks(char* comm,Courselist &nowclistn,Hwlist &nowhwlist){
    
}

void handlecat(char* com,Courselist &nowclistn,Hwlist &nowhwlist){
    if(strcmp(com,"c")==0){
        printf("Now you are in course catalogue");
        char comm[20];
        printf("You can input coursename or back to back\n");
        while(scanf("%s",comm)){
            if(strcmp(comm,"back")==0){
                printf("Back to master\n");
                return;
            }
            else{

            }

        }
    }
    else if(strcmp(com,"hw")){
        printf("Now you are in homework catalogue");
        char comm[20];
        while(scanf("%s",comm)){
            if(strcmp(comm,"back")==0){
                printf("Back to master\n");
                return;
            }

        }
    }
    else{
        printf("Fail to find that catalogue");
        return;
    }
}


int main(int argc, char* argv[]){
    char commend[100];
    Courselist nowclistn;
    Hwlist nowhwlist;
    prtwelcome();
    while(scanf("%s",commend)){
        if (strcmp(commend,"q")==0)
        {
            printf("Quit Success!!!\n");
            return 1;
        }
        else if(strcmp(commend,"cat")==0){
            char com[10];
            printf("请输入c或hw来访问具体课程和作业\n");
            scanf("%s",com);
            handlecat(com,nowclistn,nowhwlist);
        }
        else{
            handlemaster(commend,nowclistn,nowhwlist);
        }

    }
}

