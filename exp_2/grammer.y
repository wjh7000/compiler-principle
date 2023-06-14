%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
int yylex(void);
void yyerror(char*);


typedef struct _syntax_tree_node{
	    struct _syntax_tree_node * parent;
	    struct _syntax_tree_node * children[10];
	    int children_num;
	    char name[1000];
	} syntax_tree_node;

    //create node
	syntax_tree_node * create_new_node(){
	    syntax_tree_node* node = new syntax_tree_node;
        node->parent = NULL;
        node->children = {NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
        node->children_num = 0;
        node->name = "empty";
        return node;
	}

	int add_child(syntax_tree_node* parent, syntax_tree_node* child){
	    for (int i = 0; i < 10; i++){
	        if (parent->children[i] == NULL){
	            child->parent = parent;
	            parent->children[i] = child;
	            return i;
	        }
	    }
	}

	void del_node(syntax_tree_node* node, int recursive){
        for (int i = 0; i < 10; i++){
            if (node->children[i] != NULL){
                void del_node(node->children[i], i);
                node->children[i] = NULL;
            }
        }
        node->parent->children[recursive] = NULL;
        delete node;
	}

	typedef struct _syntax_tree{
	    syntax_tree_node * root;
	} syntax_tree;

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
