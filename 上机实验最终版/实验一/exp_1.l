%{
#include <stdio.h>
#include <stdlib.h>
#define ADD 1
#define SUB 2
#define MUL 3
#define DIV 4
#define GT 5
#define LT 6
#define EQ 7
#define GE 8
#define LE 9
#define NEQ 10
#define SLP 11
#define SRP 12
#define SEMI 13
#define IF 14
#define THEN 15
#define ELSE 16
#define WHILE 17
#define DO 18
#define BEGIN_N 19
#define END 20
#define IL -1

#define IDN 21
#define DEC 22
#define OCT 23
#define ILOCT 24
#define HEX 25
#define ILHEX 26
%}

%%
if                                        {return IF;}
then                                      {return THEN;}
else                                      {return ELSE;}
while                                     {return WHILE;}
do                                        {return DO;}
begin                                     {return BEGIN_N;}
end                                       {return END;}
[a-zA-Z][a-zA-Z0-9]*                      {return IDN;}
0|([1-9]+[0-9]*)                          {return DEC;}
0[0-7]+                                   {return OCT;}  
0[0-7]*[8-9]+[0-7]*                       {return ILOCT;}
0[xX][0-9a-fA-F]+                         {return HEX;} 
0[xX][0-9a-fA-F]*[g-zG-Z]+[0-9a-fA-F]*    {return ILHEX;}
\+                                        {return ADD;}
\-                                        {return SUB;}
\*                                        {return MUL;}
\/                                        {return DIV;}
\>                                        {return GT;}
\<                                        {return LT;}
\=                                        {return EQ;}
">="                                      {return GE;}
"<="                                      {return LE;}
"<>"                                      {return NEQ;}
\(                                        {return SLP;}
\)                                        {return SRP;}
\;                                        {return SEMI;}
[ \t\n]                                   {return IL;}
%%
int yylex();
int main()
{
    //yylex();
    //return 0;

    int token;
    int yytext_8;
    int yytext_16;
    token = yylex();
    while(token != 0){
        switch(token){
            case IDN:
                printf("IDN  %s\n", yytext);
                break;
            case DEC:
                printf("DEC  %s\n", yytext);
                break;
            case OCT:
                yytext_8 = strtol(yytext, NULL, 8);
                printf("OCT  %d\n", yytext_8);
                break;
            case ILOCT:
                printf("ILOCT  -\n");
                break;
            case HEX:
                yytext_16 = strtol(yytext, NULL, 16);
                printf("HEX  %d\n", yytext_16);
                break;
            case ILHEX:
                printf("ILHEX  -\n");
                break;
            case ADD:
                printf("ADD  -\n");
                break;
            case SUB:
                printf("SUB  -\n");
                break;
            case MUL:
                printf("MUL  -\n");
                break;
            case DIV:
                printf("DIV  -\n");
                break;
            case GT:
                printf("GT  -\n");
                break;
            case LT:
                printf("LT  -\n");
                break;
            case EQ:
                printf("EQ  -\n");
                break;
            case GE:
                printf("GE  -\n");
                break;
            case LE:
                printf("LE  -\n");
                break;
            case NEQ:
                printf("NEQ  -\n");
                break;
            case SLP:
                printf("SLP  -\n");
                break;
            case SRP:
                printf("SRP  -\n");
                break;
            case SEMI:
                printf("SEMI  -\n");
                break;
            case IF:
                printf("IF  -\n");
                break;
            case THEN:
                printf("THEN  -\n");
                break;
            case ELSE:
                printf("ELSE  -\n");
                break;
            case WHILE:
                printf("WHILE  -\n");
                break;
            case DO:
                printf("DO  -\n");
                break;
            case BEGIN_N:
                printf("BEGIN  -\n");
                break;
            case END:
                printf("END  -\n");
                break;
        }
        token = yylex();
    }

    
}
