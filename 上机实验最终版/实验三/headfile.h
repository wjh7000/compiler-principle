#ifndef CP_H
#define CP_H

#include <stdio.h>
#include <string.h>
#include <malloc.h>

typedef struct listele
{
    int instrno;           //指令号
    struct listele *next;  
}listele;

    listele* new_listele(int no)
    {
        listele* p = (listele*)malloc(sizeof(listele));
        p->instrno = no;
        p->next = NULL;
        return p;
    }


typedef struct instrlist
{
    listele *first,*last;
}instrlist;

    instrlist* new_instrlist(int instrno)
    {
        instrlist* p = (instrlist*)malloc(sizeof(instrlist));
        p->first = p->last = new_listele(instrno);
        return p;
    }

    instrlist* merge(instrlist *list1, instrlist *list2)
    {
        instrlist *p;
        if (list1 == NULL) p = list2;
        else
        {
            if (list2!=NULL)
            {
                if (list1->last == NULL)
                {
                    list1->first = list2->first;
                    list1->last =list2->last;
                }else list1->last->next = list2->first;
                list2->first = list2->last = NULL;
                free(list2);
            }
            p = list1;
        }
        return p;
    }

typedef struct node
{
     instrlist *truelist, *falselist, *nextlist;
    char addr[256];
    char lexeme[256];
    char oper[3];
    int instr;
}node;

    int filloperator(node *dst, char *src)
    {
        strcpy(dst->oper, src);
        return 0;
    }    
    int filllexeme(node *dst, char *yytext)
    {
        strcpy(dst->lexeme, yytext);
        return 0;
    }
    int copyaddr(node *dst, char *src)
    {
        strcpy(dst->addr, src);
        return 0;
    }
    int new_temp(node *dst, int index)
    {
        sprintf(dst->addr, "t%d", index);
        return 0;
    }
    int copyaddr_fromnode(node *dst, node src)
    {
        strcpy(dst->addr, src.addr);
        return 0;
    }

typedef struct codelist
{
      int linecnt, capacity;
    int temp_index; //表示临时变量索引的整数
    char **code;    //一个字符串数组
}codelist;

      codelist* newcodelist()
    {
        codelist* p = (codelist*)malloc(sizeof(codelist));
        p->linecnt = 0;
        p->capacity = 1024;
        p->temp_index = 0;
        p->code = (char**)malloc(sizeof(char*)*1024);
        return p;
    }

    int get_temp_index(codelist* dst)
    {
        return dst->temp_index++;
    }

    int nextinstr(codelist *dst) { return dst->linecnt; }
    
      int Gen(codelist *dst, char *str)
    {

        if (dst->linecnt >= dst->capacity)//容量不够：扩容
        {
            dst->capacity += 1024;
            dst->code = (char**)realloc(dst->code, sizeof(char*)*dst->capacity);
            if (dst->code == NULL)
            {
                printf("short of memeory\n");
                return 0;
            }
        }
        dst->code[dst->linecnt] = (char*)malloc(strlen(str)+20);     //申请一个内存空间存放中间字符串

              strcpy(dst->code[dst->linecnt], str);                    //字符串复制

              dst->linecnt++;                                  //行号加1

        return 0;
    }

    char tmp[1024];

    int gen_goto_blank(codelist *dst)
    {
        sprintf(tmp, "goto");
        Gen(dst, tmp);
        return 0;
    }

    int gen_goto(codelist *dst, int instrno)
    {
        sprintf(tmp, "goto %d", instrno);
        Gen(dst, tmp);
        return 0;
    }

    int gen_if(codelist *dst, node left, char* op, node right)
    {
        sprintf(tmp, "if %s %s %s goto", left.addr, op, right.addr);
        Gen(dst, tmp);
        return 0;
    }

    int gen_1addr(codelist *dst, node left, char* op)
    {
        sprintf(tmp, "%s %s", left.addr, op);
        Gen(dst, tmp);
        return 0;
    }

    int gen_2addr(codelist *dst, node left, char* op, node right)
    {
        sprintf(tmp, "%s = %s %s", left.addr, op, right.addr);
        Gen(dst, tmp);
        return 0;
    }

    int gen_3addr(codelist *dst, node left, node op1, char* op, node op2)
    {
        sprintf(tmp, "%s = %s %s %s", left.addr, op1.addr, op, op2.addr);
        Gen(dst, tmp);
        return 0;
    }

    int gen_assignment(codelist *dst, node left, node right)
    {
        gen_2addr(dst, left, "", right);
        return 0;
    }

    int backpatch(codelist *dst, instrlist *list, int instrno)
    {
        if (list!=NULL)
        {
            listele *p=list->first;
            char tmp[20];
        
            sprintf(tmp, " %d", instrno);
            while (p!=NULL)
            {
                if (p->instrno<dst->linecnt)
                    strcat(dst->code[p->instrno], tmp);
                p=p->next;
            }
        }
        return 0;
    }

    int print(codelist* dst)
    {
        int i;
        
        for (i=0; i < dst->linecnt; i++)
            printf("%5d:  %s\n", i, dst->code[i]);
        return 0;
    }

#endif