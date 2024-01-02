#include "course.h"
#include<string.h>

#define cnum 10

class Courselist
{
public:
   course list[cnum];

   int  newcourses(void);
   int delcourses(char* name);
   void showcourses(void);
};



int Courselist::newcourses(void)
{
     printf("请输入：课程名称, 上课时间,老师,会议号,密码(用空格隔开)\n");
      course  course1;
      scanf("%s",course1.cname);
      course1.id=1;
      scanf("%s",course1. coursetime);
      scanf("%s",course1.teacher);
      scanf("%s",course1.meeting);
      scanf("%s",course1.mima);
      int i=0;
      while (i<10)
      {
         if(this->list[i].id==0){
            this->list[i]=course1;
            break;
         }
         i++;
      }
      if(i==10){
         printf("你的课太多了，退几个\n");
         return 0;
      }
   printf("添加成功\n");
    return 1;
}

int Courselist::delcourses(char* name){
   int i;
   char n[10];
   strcpy(n,this->list[0].cname);
   printf("%s\n",n);
   for(i=0;i<10;i++){
      if(strcmp(n,name)==0){
         course c1;
         this->list[i]=c1;
         printf("删除成功!\n");
         break;
      }
   }
   if(i==10){
      printf("未找到您要删除的课程\n");
   }
   return 1;
}

void Courselist::showcourses(void){
    int i;
    int index=1;
   for(i=0;i<10;i++){
      if(this->list[i].id){
         printf("第%d门课:%s=%s=%s=%s=%s\n",index,this->list[i].cname,this->list[i].coursetime,this->list[i].teacher,this->list[i].meeting,this->list[i].mima);
         index++;
      }
   }
}