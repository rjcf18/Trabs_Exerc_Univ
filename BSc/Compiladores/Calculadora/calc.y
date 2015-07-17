%{
#include <stdio.h>
#include <math.h>
  int yylex (void);
  void yyerror (char const *);
  double vars[26];
  %}

%union {
  double val;
}

/* Bison declarations.  */
%token <val> NUM
%token <val> VAR

%token NL /* newline */

%right ASSIGN
%left SUB ADD 
%left MUL DIV
%left NEG     /* negation--unary minus */
%right POWER

%token LPAR RPAR

%type <val> line exp
%%


input:   /* empty */
       | input line
;

line:   NL      { $$=0; }
      | exp NL  { $$=$1; printf ("%.2lf\n\n", $$); }
;

exp:      NUM                { $$ = $1; }
        | exp ADD exp        { $$ = $1 + $3; }
        | exp SUB exp        { $$ = $1 - $3; }
        | SUB exp  %prec NEG { $$ = (0 - $2); }
        | LPAR exp RPAR      { $$ = $2; }
	| exp MUL exp        { $$ = $1 * $3; }
	| exp DIV exp	     { $$ = $1 / $3; }
	| exp POWER exp      { $$ = pow($1, $3); }
	| VAR 		     { $$ = vars[(int)$1-'a'];}
	| VAR ASSIGN exp     { $$ = vars[(int)$1-'a'] = $3;}
;
%%

	  /* Called by yyparse on error.  */
void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

int main (void)
{
  return yyparse();
}
