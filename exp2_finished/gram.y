
%{
    #include "lex.yy.c"
    #include <stdio.h>
    #include <math.h>
    #include <stdlib.h>
    #include <malloc.h>
	#include <String.h>
    //语法树的结构
    typedef char* ElemType; 
 
	int i;
    typedef struct BiTNode{
        ElemType data;
        struct BiTNode *lChild, *mChild, *rChild, *l2Child, *m2Child, *r2Child;
    }BiTNode, *BiTree;
 
    typedef struct Node{
        BiTNode *data;
        struct Node *next;
    }Node, *LinkedList;
  void yyerror (char const *);
//创建链表
LinkedList LinkedListInit()    
{    
     Node *L;    
     L = (Node *)malloc(sizeof(Node));
	 
     L->next = NULL;
     return L;
}
 
//插入节点，头插法
LinkedList LinkedListInsert(LinkedList L,BiTNode *x)    
{    
     Node *pre;
     pre = L;
     Node *p;
     p = (Node *)malloc(sizeof(Node));    
     p->data = x;     
     p->next = pre->next;    
     pre->next = p;    
     return L;                               
}
 
//创建叶子
BiTree createLeaf(ElemType root)
{
 
     BiTree T = (BiTree)malloc(sizeof(BiTNode));
     if (T != NULL) {
               T->data = root;
               T->lChild = NULL;
               T->mChild = NULL;
               T->rChild = NULL;
			  T->l2Child = NULL;
               T->m2Child = NULL;
               T->r2Child = NULL;
     }
     else exit(-1);
     return T;
}
 
BiTree createTree(ElemType root, BiTree lleaf, BiTree mleaf, BiTree rleaf, 
					BiTree l2leaf, BiTree m2leaf, BiTree r2leaf)
{
 
     BiTree T = (BiTree)malloc(sizeof(BiTNode));
     if (T != NULL) {
               T->data = root;
               T->lChild = lleaf;
               T->mChild = mleaf;
               T->rChild = rleaf;
               T->l2Child = l2leaf;
               T->m2Child = m2leaf;
               T->r2Child = r2leaf;
     }
     else exit(-1);
     return T;
}
 
//后序遍历
void TraverseBiTree(BiTree T)
{
     if (T == NULL) return ;
     TraverseBiTree(T->lChild);
     TraverseBiTree(T->mChild);
     TraverseBiTree(T->rChild);
	 TraverseBiTree(T->l2Child);
     TraverseBiTree(T->m2Child);
     TraverseBiTree(T->r2Child);
     if(strcmp(T->data, " ") != 0) printf("%s ", T->data);
}
 
void Print6aryTree(BiTree root, int level) {
    if (root == NULL) {
        return;
    }

    // 如果字符串内容为空格，则不输出节点
    if (strcmp(root->data, " ") != 0) {
        printf("%*s%s\n", level * 4, "", root->data);
    }

    Print6aryTree(root->lChild, level + 1);
    Print6aryTree(root->mChild, level + 1);
    Print6aryTree(root->rChild, level + 1);
    Print6aryTree(root->l2Child, level + 1);
    Print6aryTree(root->m2Child, level + 1);
    Print6aryTree(root->r2Child, level + 1);
}
 
//变量的申明，全局变量必须赋初值
    LinkedList list;
	//LinkedList list = NULL;
    //LinkedList head = NULL;
	LinkedList head ;
    BiTree T, T1, T2, T3,T4,T5,T6;
    
%}


	%token IF;
	%token THEN;
	%token ELSE;
	%token WHILE;
	%token DO;
	%token BEGIN_N;
	%token END;
	%token IDN;
	%token DEC;
	%token OCT;
	%token ILOCT;
	%token HEX;
	%token ILHEX;
	%token ADD;
	%token SUB;
	%token MUL;
	%token DIV;
	%token GT;
	%token LT;
	%token EQ;
    %token GE;
	%token LE;
	%token NEQ;
	%token SLP;
	%token SRP;
	%token SEMI;


%%
P: L  { 		  
                  head = list->next;
				  T1  = head->data;
				  T2 = createLeaf(" ");
                  T3 = createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("P", T1, T2, T3,T4,T5,T6);
                  list->next = head->next;
                  LinkedListInsert(list, T);   }
				  
 | L P	 { 		  
                  head = list->next;
				  T1  = (head->next)->data;
				  T2 = head->data;
                  T3 = createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("P", T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                  LinkedListInsert(list, T);   }
 ;   

L: S SEMI  { head = list->next;
                  T = head->data;
                  printf("Traverse BiTree:\n");
                  //TraverseBiTree(T); 
				  Print6aryTree(T, 0);
				  printf("\n");
				//  printf ("answer:%d\n", $1);
				}
 ;

S: IDN EQ E	 { 		//printf("S->IDN = E\n");  
                  head = list->next;
				  T1 = createLeaf("IDN");
				  T2 = createLeaf("=");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("S", T1, T2, T3,T4,T5,T6);
                  list->next = head->next;
                  LinkedListInsert(list, T);   }

 | IF C THEN S	{ 		//printf("S->IF C THEN S\n");  
                  head = list->next;
				  T1 = createLeaf("IF");
				  T2 = (head->next)->data;
                  T3 = createLeaf("THEN");
				  T4 = head->data;
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("S",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;//pop expel E
                  LinkedListInsert(list, T);   }

 | IF C THEN S ELSE S { 		//printf("S->IF C THEN S ELSE S\n");  
                  head = list->next;
				  T1 = createLeaf("IF");
				  T2 = (head->next->next)->data;
                  T3 = createLeaf("THEN");
				  T4 = (head->next)->data;
				  T5 = createLeaf("ELSE");
				  T6 = head->data;
                  T = createTree("S",T1, T2, T3,T4,T5,T6);
                  list->next = ((head->next)->next)->next;
                  LinkedListInsert(list, T);   }
 
 
 | WHILE C DO S		{ 		//printf("S->WHILE C DO S\n");  
                  head = list->next;
				  T1 = createLeaf("WHILE");
				  T2 = (head->next)->data;
                  T3 = createLeaf("DO");
				  T4 = head->data;
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("S",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                  LinkedListInsert(list, T);   }
 ;

C: E GT E		 { //printf("C->E>E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf(">");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C", T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                  LinkedListInsert(list, T);  }

 | E LT E	{ //printf("C->E<E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("<");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C", T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                  LinkedListInsert(list, T);   }
				  
 | E EQ E		{ //printf("C->E=E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("=");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                  LinkedListInsert(list, T);  }
				  
 | E GE E	 	{ //printf("C->E>=E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("=");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);  }
				  
 | E LE E		{ //printf("C->E<=E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("<=");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
				 
 | E NEQ E		{ //printf("C->E!=E\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("!=");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("C",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
 ;

E: E ADD T	{ //printf("E->E+T\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("+");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("E",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
				 
 | E SUB T	{ //printf("E->E-T\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("-");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("E",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
 
 
 | T			{ //printf("T\n");  
                  head = list->next;
                  T1 = head->data;
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("E",T1, T2, T3,T4,T5,T6);
                  list->next = head->next;
                 LinkedListInsert(list, T);   }
 ;

T: T MUL F	{ //printf("T->T*F\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("*");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("T",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
				 
 | T DIV F	{ //printf("T->T/F\n");  
                  head = list->next;
                  T1 = (head->next)->data;
                  T2 = createLeaf("/");
                  T3 = head->data;
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("T",T1, T2, T3,T4,T5,T6);
                  list->next = (head->next)->next;
                 LinkedListInsert(list, T);   }
				 
 | F			{ //printf("T->F\n");  
                  head = list->next;
                  T1 = head->data;
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("T",T1, T2, T3,T4,T5,T6);
                  list->next = head->next;
                 LinkedListInsert(list, T);   }
 ;

F: SLP E SRP	{ //printf("F->'('E')'\n");  
                  head = list->next;
                  T1 = createLeaf("(");
                  T2 = head->data;
                  T1 = createLeaf(")");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("F",T1, T2, T3,T4,T5,T6);
                  list->next = head->next;
                 LinkedListInsert(list, T);   }
				 
 | IDN			{ //printf("IDN\n");  
                  T1 = createLeaf("IDN");
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("F",T1, T2, T3,T4,T5,T6);
                 LinkedListInsert(list, T);   }
				 
 | OCT			{ //printf("OCT\n");  
                  T1 = createLeaf("OCT");
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("F",T1, T2, T3,T4,T5,T6);
                 LinkedListInsert(list, T);   }
				 
 | DEC			{ //printf("DEC\n");  
                  T1 = createLeaf("DEC");
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("F",T1, T2, T3,T4,T5,T6);
                 LinkedListInsert(list, T);   }
		
 | HEX			{ //printf("HEX\n");  
                  T1 = createLeaf("HEX");
                  T2 = createLeaf(" ");
                  T3 =  createLeaf(" ");
				  T4 = createLeaf(" ");
				  T5 = createLeaf(" ");
				  T6 = createLeaf(" ");
                  T = createTree("F",T1, T2, T3,T4,T5,T6);
                 LinkedListInsert(list, T);   }
 ;
%%

int main() {
	list = LinkedListInit();
	head = NULL;
     T=NULL, T1=NULL, T2=NULL, T3=NULL,T4=NULL,T5=NULL,T6=NULL;
    yyparse();
	while(1);
    return 0;
	
}



void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}
