%{
#include<stdio.h>
int words =0;
%}
%%
[Aa][A-Za-z]* {words++;}
[^ \t\n]+
%%
int main(int argc,char* argv[]) {
 if(argc != 2){
 printf("Usage: %s <input_file>\n",argv[0]);
 return 1;
}
FILE* input_file = fopen(argv[1],"r");
if(!input_file){
perror("Error opening input file");
return 1;
}
yyin = input_file;
yylex();
fclose(input_file);
 printf("Words starting with A: %d",words);
return 0;
}
int yywrap(){
return 1;
}