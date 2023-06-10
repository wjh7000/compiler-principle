%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "myyacc.tab.h"
#include<math.h>

int installID();
int installNum();
int yylval;
int n_num = 0;
int n_id = 0;
double num[1000];
char *id[1000];
int line_num=0;

%}

delim	[ \t]
ws		{delim}+
letter_	[_A-Za-z]
digit	[0-9]
id	    {letter_}({letter_}|{digit})*
number	{digit}+(\.{digit}+)?([E\e][+\-]?{digit}+)?
comment	\/\*(\*[^/]|[^*])*\*\/

%%

"\n"        {line_num++;}
{ws}		{/* no return*/}
{comment}	{/* no return*/}
if			{return IF;}
else		{return ELSE;}
while		{return WHILE;}
do			{return DO;}
break		{return BREAK;}
real		{return REAL;}
true		{return TRUE;}
false		{return FALSE;}
int			{yylval = INT; return BASIC;}
char		{yylval = CHAR; return BASIC;}
bool		{yylval = BOOL; return BASIC;}
float		{yylval = FLOAT; return BASIC;}
{id}		{yylval = installID(); return ID;}
{number}	{yylval = installNum(); return NUMBER;}
"<"			{return LT;}
"<="		{return LE;}
"="			{return '=';}
">"			{return GT;}
">="		{return GE;}
"=="		{return EQ;}
"!="		{return NE;}
"||"		{return OR;}
"&&"		{return AND;}
"!"			{return NOT;}
"+"			{return '+';}
"-"			{return '-';}
"*"			{return '*';}
"/"			{return '/';}
","			{return ',';}
"("			{return '(';}
")"			{return ')';}
"["			{return '[';}
"]"			{return ']';}
";"			{return ';';}
"{"			{return '{';}
"}"			{return '}';}

%%
int installID()
{
    int i;
	char buf[81];
	if (yyleng > 80)
		return -1;
	memset(buf, 0, yyleng + 1);
	memcpy(buf, yytext, yyleng);
	for (i = 0; i < n_id; i++)
		if (!strcmp(buf, id[i]))
			return i;
	id[n_id] = (char *) malloc(yyleng + 1);
	memset(id[n_id], 0, yyleng + 1);
	memcpy(id[n_id], yytext, yyleng);
	return n_id++;
}

int installNum()
{
	char buf[81];
	if (yyleng > 80)
		return -1;
	
	memset(buf, 0, yyleng + 1);
	memcpy(buf, yytext, yyleng);
	num[n_num] = atof(buf);
	
	return n_num++;
}
yywrap() { return 1; }