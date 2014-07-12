/* A Bison parser, made by GNU Bison 2.7.12-4996.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT_LIT = 258,
     BOOL_LIT = 259,
     REAL_LIT = 260,
     ID = 261,
     OP = 262,
     NL = 263,
     INT = 264,
     REAL = 265,
     BOOL = 266,
     VOID = 267,
     LPAR = 268,
     RPAR = 269,
     LPARR = 270,
     RPARR = 271,
     LPARC = 272,
     RPARC = 273,
     GREATEROREQUAL = 274,
     GREATER = 275,
     DIFF = 276,
     LESS = 277,
     LESSOREQUAL = 278,
     EQUAL = 279,
     POINT = 280,
     CLASS = 281,
     MAP = 282,
     ARROBA = 283,
     RARROW = 284,
     BREAK = 285,
     RETRY = 286,
     WHILE = 287,
     DECLASSIGN = 288,
     COMMA = 289,
     DOUBLEQUOTE = 290,
     SKIP = 291,
     ENDOFSTM = 292,
     RETURN = 293,
     ELSE = 294,
     COND = 295,
     NEG = 296,
     NOT = 297,
     OR = 298,
     AND = 299,
     MOD = 300,
     DIV = 301,
     MUL = 302,
     ADD = 303,
     SUB = 304
   };
#endif
/* Tokens.  */
#define INT_LIT 258
#define BOOL_LIT 259
#define REAL_LIT 260
#define ID 261
#define OP 262
#define NL 263
#define INT 264
#define REAL 265
#define BOOL 266
#define VOID 267
#define LPAR 268
#define RPAR 269
#define LPARR 270
#define RPARR 271
#define LPARC 272
#define RPARC 273
#define GREATEROREQUAL 274
#define GREATER 275
#define DIFF 276
#define LESS 277
#define LESSOREQUAL 278
#define EQUAL 279
#define POINT 280
#define CLASS 281
#define MAP 282
#define ARROBA 283
#define RARROW 284
#define BREAK 285
#define RETRY 286
#define WHILE 287
#define DECLASSIGN 288
#define COMMA 289
#define DOUBLEQUOTE 290
#define SKIP 291
#define ENDOFSTM 292
#define RETURN 293
#define ELSE 294
#define COND 295
#define NEG 296
#define NOT 297
#define OR 298
#define AND 299
#define MOD 300
#define DIV 301
#define MUL 302
#define ADD 303
#define SUB 304



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2053 of yacc.c  */
#line 12 "vspl.y"

	char *chr;
	int inteiro;
    float real;
    double val;
    
    struct Id *id;
    struct Ids *ids;
    struct Exp *exp;
    struct SExp *sexp;
    struct Formals *formals;
    struct Formal_decl *formal_decl;
    struct Statements *statements;
    struct Statement *statement;
    struct Type *type;
    struct Single_Type *single_type;
    struct Decl *decl;
    struct Decls *decls;
    struct Prim *prim;
    struct Clauses *clauses;
    struct Op *op;
    


/* Line 2053 of yacc.c  */
#line 180 "parser.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_PARSER_H_INCLUDED  */
