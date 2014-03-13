%{
#include <stdlib.h> 
#include "parser.h"

%}

INT  [0-9]+
DOUBLE [0-9]*\.[0-9]+
VAR  [a-z]

%%

{INT}   {yylval.val = atof(yytext); return NUM;}
{VAR}   {yylval.val = yytext[0]; return VAR;}

"+"	{ return ADD; }
"-"	{ return SUB; }
"/"	{ return DIV; }
"*"	{ return MUL; }
"**"	{ return POWER;}
"("	{ return LPAR; }
")"	{ return RPAR; }
"="	{ return ASSIGN; }
"quit"	{ exit(0); }
\n	{ return NL; }
.	{/*ignorar*/}

{DOUBLE}   {yylval.val = atof(yytext); return NUM;}

%%

int yywrap()  {return 1;}
