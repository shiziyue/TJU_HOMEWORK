#include "N2D_Method.cpp"


int main(){
    Regex_Line now;
    now.next=NULL;
    if(!Read_Regex_Line(&now,"regex_rule.txt")){
        return 0;
    }
    Regex_Print(now);
    Build_NFA(&now);
    NFA2DFA(&now);
    Min_DFA(&now);
    Build_MDFA(&now);


    Print_NFA(now);
    Print_DFA(now);
    Print_MDFA(now);
}