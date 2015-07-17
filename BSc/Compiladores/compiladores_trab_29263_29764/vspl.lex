%{
#include <stdlib.h> 
#include "parser.h"
#include <string.h>
%}

INT  [0-9]+
REAL [0-9]*\.?[0-9]+([Ee][+-]?[0-9]+)?
ID [a-zA-Z][a-zA-Z0-9_]*

%%
true {yylval.inteiro = 1; return BOOL_LIT;}
false {yylval.inteiro = 0; return BOOL_LIT;}

"#"[^\n]*[\n]*		{printf("Comentario\n");}
"*"/[^\n\[\n]*"->"	{ printf("ELSE\n");return ELSE; }
"*"/[^\n]*"["	{ printf("WHILE\n");return WHILE; }

"int"		{printf("\n");return INT; }
"double"	{printf("double\n");return REAL;}
"bool"		{printf("bool\n");return BOOL;}
"void"		{printf("void\n");return VOID;}

{INT}   	{printf("INT_LIT\n");yylval.inteiro = atof(yytext);return INT_LIT;}
{REAL} 		{printf("REAL_LIT\n");yylval.real = atof(yytext);return REAL_LIT;}


"not"		{printf("not\n"); return NOT; }
"and"		{printf("and\n"); return AND; }
"or"		{printf("or\n"); return OR; }

"return"	{printf(""); return RETURN; }
"cond"		{printf(""); return COND; }
"while"		{printf(""); return WHILE; }
"else"		{printf(""); return ELSE; }
"map"		{printf("MAP\n"); return MAP;}
"class"		{printf(""); return CLASS;}
"break"		{printf(""); return BREAK;}
"skip"		{printf(""); return SKIP;}
"retry"		{printf(""); return RETRY;}
"op"		{printf(""); return OP;}

{ID} 		{yylval.chr = yytext;return ID;}

"+"			{ return ADD; }
"-"			{ return SUB; }
"/"			{ return DIV; }
"%"     	{ return MOD; }

"*"			{printf("MUL\n"); return MUL; }
"="     	{ return EQUAL;}
":="  		{return DECLASSIGN;}
":" 		{return DOUBLEQUOTE;}
"("			{ return LPAR; }
")"			{ return RPAR; }
"["			{return LPARR; }
"]"			{return RPARR; }
"{"			{return LPARC; }
"}"			{return RPARC; }
"," 		{return COMMA;}
"."			{return POINT;}


"<=" 		{return LESSOREQUAL;}
"<" 		{return LESS;}
"<>" 		{return DIFF;}
">=" 		{return GREATEROREQUAL;}
">" 		{return GREATER;}

"->" 		{ return RARROW;}
"~"			{ return NOT; }
"&"			{ return AND; }
"|"			{ return OR; }

"^"			{ printf("RETURN \n");return RETURN; }
"?"			{ return COND; }
"@" 		{return ARROBA;}
";" 		{printf("END OF STM (;) \n");return ENDOFSTM;}

\n	{ return NL; }
.	{/*ignorar*/}
%%

int yywrap()  {return 1;}
