#include <string>
#include <cstring>
#include <stdio.h>
#include <vector>
#include <iostream>
#include <algorithm>
#include<unordered_map>
#include <fstream> 
#include"SQLCIFA.cpp"
#include"syntax_method.cpp"
using namespace std;
int main(){
	ifstream file("sql.txt");
	istreambuf_iterator<char> beg(file), end;
	string data(beg, end);
	char* ch = (char*)data.c_str();
    file.close();
	Sqlprase SQL(ch);	
	vector<Token> Token_List = SQL.ParseMain();		//上述为生成TOken序列

	Grammar grammar("grammar.txt");

	 /*for(auto iter=grammar.Terms.begin();iter!=grammar.Terms.end();iter++){
	 	cout<<*iter<<"-";
	 	cout<<endl;
	 }
	 for(auto iter=grammar.UTerms.begin();iter!=grammar.UTerms.end();iter++){
	 	cout<<*iter<<"-";
	 	cout<<endl;
	 }*/
	
	Syntax_Analysis syntax;
	syntax.Init_FirstTable(grammar);
	syntax.Print_FirstTable();
	syntax.Init_FollowTable(grammar);
	syntax.Print_FollowTable();
	syntax.Init_PredictTable(grammar);
	syntax.Print_PredictTable(grammar,"PredictTable.csv");
	Token ret;
	for(int i = 0; i < Token_List.size(); i++){
		ret = Token_List[i];
		cout<<ret.Tokentostring()<<"\n";
	}
	syntax.Analysis(grammar,Token_List);
	return 0;
}