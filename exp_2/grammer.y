%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
int yylex(void);
void yyerror(char*);
%}

	%token IF
	%token THEN
	%token ELSE
	%token WHILE
	%token DO
	%token BEGIN_N
	%token END
	%token ADD
	%token SUB
	%token MUL
	%token DIV
	%token GT
	%token LT
	%token EQ
	%token GE
	%token LE
	%token NEQ
	%token SLP
	%token SRP
	%token SEMI
    %token KEY
	%token SPACE_ENTER
	%token UNDEFINE
	%token DEC
	%token HEX
	%token OCT
	%token ILHEX
	%token ILOCT
	%token IDN
	%token END_OF_INPUT

%%
P: L   
 | L P
 ;   

L: S SEMI  {printf("correct!\n");}
 ;

S: IDN EQ E
 | IF C THEN S
 | IF C THEN S ELSE S
 | WHILE C DO S
 ;

C: E GT E
 | E LT E
 | E EQ E
 | E GE E
 | E LE E
 | E NEQ E
 ;

E: E ADD T
 | E SUB T
 | T
 ;

T: T MUL F
 | T DIV F
 | F
 ;

F: SLP E SRP
 | IDN
 | OCT
 | DEC
 | HEX
 ;
%%

int main() {
    yyparse();
    return 0;
}
int yywrap(){
	return 1;
}

void yyerror(char* msg) {
    printf("Syntax error: %s\n", msg);
}
