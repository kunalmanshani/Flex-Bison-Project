%{ 
	#include<stdio.h>
	#include<stdlib.h>
	#include <stdbool.h>
	void yyerror(char *s);
 
%}

%token IF ELSE PR PL PLUS MINUS SEMI EXIT NUMBER ELIF DECIMAL
ID LT GT LTEQ GTEQ DNEQ EQEQ FOR INCR OROP ANDOP NOTOP FUNC
LBRACK RBRACK LBRACE RBRACE WHILE STRING CHAR INT FLOAT
DOUBLE CONTINUE BREAK VOID RETURN COMMA ASSIGN DO COLON BOOL
%left PLUS MINUS MUL DIV 
%start line

%%
line:	|exp2
		|do_while_statement
		|declarations
		|ifElse
		|Elseif
		|function
		|if_condition
		|for_statement
		|while_statement
		| EXIT {printf("In Exit..."); exit(0);}
		;

declaration2: type names2 ASSIGN NUMBER;
names2: ID;

declarations: declarations declaration | declaration;

declaration: type names SEMI {printf("variable decleard sucessfully");} ;

type: INT | CHAR | FLOAT | DOUBLE | BOOL ;

names: names COMMA variable assign  | variable | variable ASSIGN tail ;

assign: ASSIGN tail | /*EMPTY*/ ;

tail: NUMBER | DECIMAL | ID ;

variable: ID  
;

type2: type2 COMMA BOOL |type2 COMMA DOUBLE| type2 COMMA FLOAT| type2 COMMA CHAR|type2 COMMA INT | INT | CHAR | FLOAT | DOUBLE | BOOL |VOID;

function: FUNC ID PL type2 PR COLON exp SEMI {printf("function decleared..");};
do_while_statement:DO COLON exp WHILE PL condi PR SEMI {printf("do while loop executed..");};
while_statement: WHILE PL condi PR COLON exp SEMI  {printf("while loop executed..");};
for_statement: FOR PL declaration2 SEMI condi SEMI increment PR COLON exp SEMI {printf("for loop executed..");};   
increment: e INCR| INCR e;
e: ID;


condi:
    exp OROP exp|
    exp ANDOP exp|
    NOTOP exp  |
    exp EQEQ exp |
    exp DNEQ exp |
    exp LT exp |
    exp GT exp |
    exp LTEQ exp |
    exp GTEQ exp |
    PL exp PR
;
Elseif: IF PL condition PR COLON exp elif ELSE COLON exp SEMI {printf("if elseif else executed..");};

elif: ELIF PL condition PR COLON exp | ELIF PL condition PR COLON exp elif


ifElse: IF PL condition PR COLON exp ELSE COLON exp SEMI ;
if_condition: IF PL condition PR COLON exp SEMI ;

condition: exp LT exp 
		   | exp GT exp 
		   | exp GTEQ exp
		   | exp LTEQ exp 
		   | exp EQEQ exp
		   | exp DNEQ exp
		   ;

exp: exp PLUS exp
		| exp MINUS exp 
		| exp DIV exp 			}
		| exp MUL exp 
		| PL exp PR 
		|NUMBER
		|DECIMAL
		|ID 
		  ;
exp2: exp2 PLUS exp2 	
	| exp2 MINUS exp2 
	| exp2 DIV exp2 
		| exp2 MUL exp2 
		| PL exp2 PR 
		|NUMBER 
		  ;



%%

void yyerror(char *s){
	printf("Error happend %s",s);
}

int yywrap(){
	return 1;
}

int main(void){
	return yyparse();
}