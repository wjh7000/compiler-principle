/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IF = 258,
     THEN = 259,
     ELSE = 260,
     WHILE = 261,
     DO = 262,
     BEGIN_N = 263,
     END = 264,
     ID = 265,
     DEC = 266,
     OCT = 267,
     ILOCT = 268,
     HEX = 269,
     ILHEX = 270,
     ADD = 271,
     SUB = 272,
     MUL = 273,
     DIV = 274,
     LT = 275,
     EQ = 276,
     GE = 277,
     LE = 278,
     NEQ = 279,
     SLP = 280,
     SRP = 281,
     SEMI = 282,
     token = 283,
     REL = 284
   };
#endif
/* Tokens.  */
#define IF 258
#define THEN 259
#define ELSE 260
#define WHILE 261
#define DO 262
#define BEGIN_N 263
#define END 264
#define ID 265
#define DEC 266
#define OCT 267
#define ILOCT 268
#define HEX 269
#define ILHEX 270
#define ADD 271
#define SUB 272
#define MUL 273
#define DIV 274
#define LT 275
#define EQ 276
#define GE 277
#define LE 278
#define NEQ 279
#define SLP 280
#define SRP 281
#define SEMI 282
#define token 283
#define REL 284




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

