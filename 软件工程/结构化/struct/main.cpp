#include"compose.h"



int main(){
    Clist clist;
    char comd[100];
    
    prtwelcome();
    while(1){
         printf("<master>");
         scanf("%s",comd);
        if (strcmp(comd,"q")==0)
        {
            printf("Quit Success!!!\n\n");
            return 1;
        }
        else if(strcmp(comd,"cat-c")==0){
            //show_which(clist,which);
            //handlecat_c(com,nowclistn,nowhwlist);
            printf("有待完善\n");
        }
        else if(strcmp(comd,"cat-hw")==0){
            printf("有待完善\n");
            //handlecat_hw(com,nowclistn,nowhwlist);
        }
        else{
            handlemaster(comd,clist);
        }
    memset(comd,0,strlen(comd));
    }

}