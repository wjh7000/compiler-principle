%{
/****************************************************************************
myparser.y
ParserWizard generated YACC file.

Date: 2013Äê5ÔÂ25ÈÕ
****************************************************************************/
#include <stdio.h>
#include<stdlib.h>
#include <string.h>
#include "myyacc.tab.h"
int linenum = 1;
void yyerror(const char *msg);
extern double num[1000];
extern char *id[1000];
extern int yylex();

%}

%token LT LE EQ NE GT GE OR AND NOT

%token INT CHAR BOOL FLOAT

%token ID NUMBER IF ELSE WHILE DO BREAK BASIC TRUE FALSE REAL

%left '+' '-'
%left '*' '/'
%right UMINUS
%nonassoc IF_THEN
%nonassoc ELSE
%%

/////////////////////////////////////////////////////////////////////////////
// rules section

// place your YACC rules here (there must be at least one)
program	:	block						{printf("(%d)\tprogram -> block\n",linenum++);}
;
block	:	'{' decls stmts '}'			{printf("(%d)\tblock -> decls stmts\n",linenum++);}
;
decls	:	decls decl					{printf("(%d)\tdecls -> decls decl\n",linenum++);}
		|								{printf("(%d)\tdecls -> e\n",linenum++);}
;
decl	:	type ID ';'					{printf("(%d)\tdecl -> type %s;\n",linenum++, id[$2]);}
;
type	: 	type '[' NUMBER ']'			{printf("(%d)\ttype -> type[num]\n",linenum++);}
		|	BASIC						{
											switch ($1) 
											{
											case INT:
												printf("(%d)\ttype -> int\n",linenum++);break;
											case CHAR:
												printf("(%d)\ttype -> char\n",linenum++);break;
											case BOOL:
												printf("(%d)\ttype -> bool\n",linenum++);break;
											case FLOAT:
												printf("(%d)\ttype -> float\n",linenum++);break;
											}
										}
										
;
stmts	:	stmts stmt						{printf("(%d)\tstmts -> stmts stmt\n",linenum++);}
		|									{printf("(%d)\tstmts -> e\n",linenum++);}
;
stmt	:	loc '=' bool ';'				{printf("(%d)\tstmt -> loc = bool;\n",linenum++);}	
		|	IF '(' bool ')' stmt %prec IF_THEN 			{printf("(%d)\tstmt -> if (bool) stmt\n",linenum++);}
		|	IF '(' bool ')' stmt ELSE stmt	{printf("(%d)\tstmt -> if (bool) stmt else stmt\n",linenum++);}
		|	WHILE '(' bool ')' stmt			{printf("(%d)\tstmt -> while (bool) stmt\n",linenum++);}
		|	DO stmt WHILE '(' bool ')' ';'	{printf("(%d)\tstmt -> do stmt while (bool);\n",linenum++);}
		|	BREAK ';'						{printf("(%d)\tstmt -> break;\n",linenum++);}
		|	block							{printf("(%d)\tstmt -> block\n",linenum++);}
;
loc		:	loc '[' bool ']'				{printf("(%d)\tloc -> loc [bool]\n",linenum++);}
		|	ID								{printf("(%d)\tloc -> %s\n",linenum++, id[$1]);}
		
;
bool		:	bool OR join			{printf("(%d)\tbool -> bool || join\n",linenum++);}
			|	join						{printf("(%d)\tbool -> join\n",linenum++);}
;
join		:	join AND equality		{printf("(%d)\tjoin -> join && equality\n",linenum++);}
			|	equality					{printf("(%d)\tjoin -> equality\n",linenum++);}
;
equality	:	equality EQ rel				{printf("(%d)\tequality -> equality == rel\n",linenum++);}
			|	equality NE rel				{printf("(%d)\tequality -> equality != rel\n",linenum++);}
			|	rel							{printf("(%d)\tequality -> rel\n",linenum++);}
;
rel			:	expr LT expr				{printf("(%d)\trel -> expr < expr\n",linenum++);}
			|	expr LE expr				{printf("(%d)\trel -> expr <= expr\n",linenum++);}
			|	expr GE expr				{printf("(%d)\trel -> expr >= expr\n",linenum++);}
			|	expr GT expr				{printf("(%d)\trel -> expr > expr\n",linenum++);}
			|	expr						{printf("(%d)\trel -> expr\n",linenum++);}

;
expr	:	expr '+' term				{printf("(%d)\texpr -> expr + term\n",linenum++);}
		|	expr '-' term				{printf("(%d)\texpr -> expr - term\n",linenum++);}
		|	term						{printf("(%d)\texpr -> term\n",linenum++);}
;
term	:	term '*' unary				{printf("(%d)\tterm -> term * unary\n",linenum++);}
		|	term '/' unary				{printf("(%d)\tterm -> term / unary\n",linenum++);}
		|	unary						{printf("(%d)\tterm -> unary\n",linenum++);}
;
unary	:	NOT unary				{printf("(%d)\tunary --> ! unary\n",linenum++);}
		|	'-' unary					{printf("(%d)\tunary -> - unary\n",linenum++);}
		|	factor						{printf("(%d)\tunary -> factor\n",linenum++);}
;
factor	:	'(' bool ')'				{printf("(%d)\tfactor -> (bool)\n",linenum++);}
		|	loc							{printf("(%d)\tfactor -> loc\n",linenum++);}
		|	NUMBER						{printf("(%d)\tfactor -> %f\n",linenum++, num[$1]);}
		|	TRUE						{printf("(%d)\tfactor -> true\n",linenum++);}
		|	FALSE						{printf("(%d)\tfactor -> false\n",linenum++);}
;

%%

void yyerror(const char *msg)
{ printf("ERROR:%s\n",msg);}

int main(int argc, char *argv[])
{
	return yyparse();
	return 0;
}
