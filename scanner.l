%{
	#include <stdio.h>
	#include<stdlib.h>
	 #include <string.h>

	#include "parser.tab.c"
	extern FILE *yyin;
%}
number 			[0-9]+
alpha       [a-zA-Z]
alnum       {alpha}|{number}
print       [ -~]
DecimalNUM	 [0-9]+("."[0-9]+)?
ID          [a-zA-Z]+
STRING      \"{print}*\" 

i[iI]
f[fF]
blank			[ \t\n]+
%%
{number}	{
				yylval = atoi(yytext);			//yylval value associated with token 
				return(NUMBER); }

{DecimalNUM} {	
				yylval = atoi(yytext);
				return(DECIMAL); }

{i}{f}			{return(IF);}
"else"		{return(ELSE);}
"for"|"FOR" 		{ return(FOR); }
"do"|"DO" 			{ return(DO); }
"while"|"WHILE"     { return(WHILE); }
"elif"|"ELIF"	{return(ELIF);}
"++"|"--"			{return(INCR);}
"||"                    { return (OROP); }
"&&"                    { return (ANDOP); }
"!"                     { return (NOTOP); }
"*"                     { return (MUL); }
"/"                     { return (DIV); }
"]"             { return (LBRACK); }
"["             { return (RBRACK); }
"{"             { return (LBRACE); }
"}"             { return (RBRACE); }
","             { return (COMMA); }
"="             { return (ASSIGN); }
"char"|"CHAR"           { return (CHAR); }
"int"|"INT"             { return (INT); }
"float"|"FLOAT"         { return (FLOAT); }
"double"|"DOUBLE"       { return (DOUBLE); }
"continue"|"CONTINUE"   { return (CONTINUE); }
"break"|"BREAK"         { return (BREAK); }
"void"|"VOID"           { return (VOID); }
"return"|"RETURN"       { return (RETURN); }
"BOOL" |"bool"			{return(BOOL);}

":"			{return(COLON);}
";"			{return(SEMI);}
"+"			{return(PLUS);}
">"			{ return(GT); }
"<"			{ return(LT); }
"<="		{return(LTEQ);}
">="     	{return(GTEQ);}
"!="			{return(DNEQ);}
"=="			{return(EQEQ);}
"-"			{return(MINUS);}
"("			{return(PL);}
")"			{return(PR);}
"exit"		{return(EXIT);}
"func"		{return(FUNC);}

{ID}            {
                    return (ID);
                }
{STRING}        { return (STRING); }


{blank}		{;}

.			{printf("Unexpected input %c",yytext[0]);}
%%

	  