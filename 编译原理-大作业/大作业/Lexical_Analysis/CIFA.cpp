#include <string>
#include <cstring>
#include <stdio.h>
#include <vector>
#include <iostream>
#include <algorithm>
#include<unordered_map>
#include <fstream> 
#include"SQLCIFA.cpp"
using namespace std;
int main(){
	ifstream file("sql.txt");
	istreambuf_iterator<char> beg(file), end;
	string data(beg, end);
	char* ch = (char*)data.c_str();
    file.close();
	Sqlprase SQL(ch);

	vector<Token> s = SQL.ParseMain();
	Token ret;
	ofstream file_writer("Token_List.txt", ios_base::out);
	ofstream ofs;
	ofs.open("Token_List.txt");
	cout<<endl;
	for(int i = 0; i < s.size(); i++){
		ret = s[i];
		cout<<ret.Tokentostring()<<"\n";
		ofs<<ret.Tokentostring()+'\n';
	}
	ofs.close();
	return 0;
}
