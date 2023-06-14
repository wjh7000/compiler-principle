%{
    #include "lex.yy.c"
    #include "gram.h"
    #include <stdio.h>
    #include <math.h>
    #include <stdlib.h>
    #include <sys/malloc.h>
	#include <string.h>
    

    //typedef char* ElemType;
    

    typedef struct _treeNode{
            char* data;
            struct _treeNode* child[6];
    }treeNode;
    
    typedef struct _listNode{
        treeNode* dataNode;
        struct _listNode* next;
    }listNode;
    
    //初始化链表
    listNode* listInit(){
        listNode * listHead;
        listHead = (listNode*)malloc(sizeof(listNode))    //创建链表头结点
        listHead->next = NULL;
        return listHead;
    }

    //链表头插法插入节点
    void listInsert(listNode* head, treeNode* tn){
        
        listNode* newListNode = (listNode*)malloc(sizeof(listNode));
        listNode* present = head;
        newListNode->data = tn;
        newListNode->next = present->next;
        present->next = newListNode;
    }
    void listDeleteTop(listNode* head){
        listNode* topNode = head->next;
        if (topNode != NULL){
            treeNode* topTree = topNode->dataNode;
            for (int i = 0; i < 6; i++){
                if (topTree->child[i] != NULL){
                    free(topTree->child[i]);
                    topTree->child[i] = NULL;
                }
            }
            head->next = topNode->next;
            free(topNode);
            topNode = NULL;
        }
        
    }

    //创建叶结点
    treeNode* createLeaf(char* token, treeNode* subTree[6] = NULL){
        treeNode* treeHead = (treeNode*)malloc(sizeof(treeNode));
        if (treeHead != NULL){
            treeHead->data = token;
            for (int i = 0; i < 6; i++){
                treeHead->child[i] = subTree[i];
            }
        }
        else {
            printf("creat leaf failed");
            exit(-1);
        }
        return treeHead;
    }

    //后序遍历
    void printTree(treeNode* root, int recursiveLevel){
        if (root == NULL){
            return;
        }
        if (strcmp(root->data, " ") != 0){
            printf("%*s%s\n", recursive * 4, "", root->data);
        }
        for (int i = 0; i < 6; i++){
            printTree(root->child[i], recursiveLevel + 1);
        }
    }

    listNode list;
	listNode head ;
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

P : L  { 		  
                  
                  head = list->next;
				  T1 = head->dataNode;
                  T = createTree("P", T1);
                  listDeleteTop(list);
                  //list->next = head->next;
                  listInsert(list, T);
                  }
  | L P	{ 		  
                  head = list->next;
				  T1  = (head->next)->dataNode;
				  T2 = head->dataNode;
                  T = createTree("P", T1, T2);
                  list->next = (head->next)->next;
                  listInsert(list, T);   
        }
    


%%