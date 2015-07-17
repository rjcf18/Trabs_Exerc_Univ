%{
#include <stdio.h>
#include <stdbool.h>
#include "structs.h"
	
  int yylex (void);
  void yyerror (char const *);
  double array[26];
  int line;
%}

%union {
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
    
}

/* Bison declarations.*/
%token <inteiro> INT_LIT BOOL_LIT
%token <real> REAL_LIT
%token <chr> ID OP
%token NL /* newline */
%token INT REAL BOOL VOID

%token LPAR RPAR LPARR RPARR LPARC RPARC 
%left EQUAL LESSOREQUAL LESS DIFF GREATER GREATEROREQUAL

%token POINT
%right ARROBA MAP CLASS
%token RARROW
%token BREAK

%token RETRY
%token WHILE

%left SUB ADD MUL DIV MOD AND OR NOT NEG COND ELSE RETURN ENDOFSTM SKIP DOUBLEQUOTE COMMA DECLASSIGN

%type <exp> exp
%type <sexp> sexp
%type <formal_decl> formal_decl
%type <formals> formals
%type <type> type
%type <single_type> single_type
%type <decl> decl
%type <decls> decls
%type <statements> stats
%type <statement> stat
%type <prim> prim
%type <clauses> clauses
%type <id> id
%type <ids> ids
%type <inteiro> op


//%type <boolval>  boolexp

%%

input:   /* empty */
        | input decls		{print_($2);printf("Producao: program\n");}
;

/* Lista de declaracoes*/
decls:
                    {$$ = NULL;}
    |   NL          {$$ = NULL;}
    |	decl decls 	{$$ = new_decls($1, $2);printf("Producao: decls\n");}
;

/* Declaracao de um nome:*/
decl:
		ids EQUAL type ENDOFSTM
            {
                $$ = new_decl($1, $3, NULL, DECL_1);
                printf("Producao: decl : ids = type ;\n");
            }
	|	ids DOUBLEQUOTE type ENDOFSTM
            {
                $$ = new_decl($1, $3, NULL, DECL_2);
                printf("Producao: decl : ids : type ;\n");
            }			/* Variavel, tipo explicito*/
	|	ids DOUBLEQUOTE type DECLASSIGN exp ENDOFSTM
            {
                $$ = new_decl($1, $3, $5, DECL_3);
                printf("Producao: decl : ids : type := exp ;\n");
            }
	|	ids DOUBLEQUOTE type EQUAL exp ENDOFSTM
            {
                $$ = new_decl($1, $3, $5, DECL_4);
                printf("Producao: decl : ids : type = exp ;\n");
            }
	|	ids EQUAL exp ENDOFSTM
            {
                $$ = new_decl($1, NULL, $3, DECL_5);
                printf("Producao: decl : ids = exp ;\n");
            }
;

formals:
                                    {$$ = NULL;}
	|	formal_decl formals         {$$ = new_formals($1, $2);printf("Producao: formals\n");}
;

formal_decl:
		ids ENDOFSTM
            {
                $$ = new_formal_decl($1, NULL, FORMAL_DECL_1);
                printf("Producao: formal_decl : ids ;\n");
            }
	|	ids DOUBLEQUOTE type ENDOFSTM
            {
                $$ = new_formal_decl($1, $3, FORMAL_DECL_2);
                printf("Producao: formal_decl : ids : type ;\n");
            }
;

ids:	id                  {$$= new_ids($1, NULL, IDS_1);}
	|	id COMMA ids        {$$= new_ids($1, $3, IDS_2);}
;

id:		ID
            {
                $$ = new_id($1);
                printf("Producao: id : %s\n", $1);
            }
	|	OP op
            {
                $$ = new_id_op($1, $2);
                printf("Producao: id : OP op\n");
            }
;

op:	
        ADD             {$$ = ADD_;}
	|	SUB             {$$ = SUB_;}
	| 	DIV             {$$ = DIV_;}
	| 	MUL             {$$ = MUL_;}
	| 	MOD             {$$ = MOD_;}
	|	AND             {$$ = AND_;}
	| 	OR              {$$ = OR_;}
	|	NOT             {$$ = NOT_;}
	|	LESS            {$$ = LESS_;}
	| 	LESSOREQUAL     {$$ = LESSOREQUAL_;}
	|	DIFF            {$$ = DIFF_;}
	|	GREATER         {$$ = GREATER_;}
	| 	GREATEROREQUAL  {$$ = GREATEROREQUAL_;}
;

type: 
		single_type
            {
                $$ = new_type($1, NULL, TYPE_1);
                printf("Producao: type\n");
            }
	|	LPAR type RPAR
            {
                $$ = new_type(NULL, $2, TYPE_2);
                printf("Producao: type\n");
            }
	|	single_type COMMA type
            {
                $$ = new_type($1, $3, TYPE_3);
                printf("Producao: type\n");
            }
;


single_type: 
		INT
            {
                $$ = new_single_type(NULL, NULL, NULL,NULL, INT_);
                printf("Producao: single_type : INT\n");
            }

	|	REAL
            {
                $$ = new_single_type(NULL, NULL, NULL,NULL, REAL_);
                printf("Producao: single_type : REAL\n");
            }
	|	BOOL
            {
                $$ = new_single_type(NULL, NULL, NULL,NULL, BOOL_);
                printf("Producao: single_type : BOOL\n");
            }
	| 	VOID
            {
                $$ = new_single_type(NULL, NULL, NULL,NULL, VOID_);
                printf("Producao: single_type : VOID\n");
            }
	| 	type RARROW type
            {
                $$ = new_single_type($1, $3, NULL, NULL, FUNCTIONAL_TYPE_);
                printf("Producao: single_type : type -> type\n");
            } // tipo funcional
	| 	LPARR exp RPARR type
            {
                $$ = new_single_type($4, NULL, $2, NULL, ARRAY_);
                printf("Producao: single_type : [ exp ] type\n");
            } // ARRAY
	| 	LPARC formals RPARC
            {
                $$ = new_single_type(NULL, NULL, NULL, $2, AGREGADO_);
                printf("Producao: single_type : { formals } \n");
            }
;


exp:
                        {$$ = NULL;}
    |	sexp			{$$ = new_exp($1, NULL, STRUCT_EXP_1);printf("Producao: exp : sexp\n");}
	|	sexp COMMA exp	{$$ = new_exp($1, $3, STRUCT_EXP_2);printf("Producao: exp : sexp , exp\n");}
	|	LPAR exp RPAR	{$$ = new_exp(NULL, $2, STRUCT_EXP_3);printf("Producao: exp : ( exp )\n");}
;


// Continuar a criar a arvore a partir daqui
sexp: 
        sexp OR sexp
            {
                $$ = new_sexp_binop($1, OP_OR, $3);
                printf("Producao: sexp : sexp OR sexp\n");
            }
	|	sexp AND sexp
            {
                $$ = new_sexp_binop($1, OP_AND, $3);
                printf("Producao: sexp: sexp AND sexp\n");
            }
	|	NOT sexp
            {
                $$ = new_sexp_sinop(OP_NOT, $2);
                printf("Producao: sexp: NOT sexp\n");
            }
	
	|	sexp LESS sexp
            {
                $$ = new_sexp_binop($1, OP_LESS, $3);
                printf("Producao: sexp : sexp LESS sexp\n");
            }
	|	sexp LESSOREQUAL sexp
            {
                $$ = new_sexp_binop($1, OP_LESSOREQUAL, $3);
                printf("Producao: sexp : sexp =< sexp\n");
            }
	|	sexp EQUAL sexp
            {
                $$ = new_sexp_binop($1, OP_EQUAL, $3);
                printf("Producao: sexp : sexp = sexp\n");
            }
	|	sexp DIFF sexp
            {
                $$ = new_sexp_binop($1, OP_DIFF, $3);
                printf("Producao: sexp : sexp != sexp\n");
            }
	|	sexp GREATEROREQUAL sexp
            {
                $$ = new_sexp_binop($1, OP_GREATEROREQUAL, $3);
                printf("Producao: sexp : sexp >= sexp\n");
            }
	|	sexp GREATER sexp
            {
                $$ = new_sexp_binop($1, OP_GREATER, $3);
                printf("Producao: sexp : sexpt > sexp\n");
            }
	
	|	sexp ADD sexp
            {
                $$ = new_sexp_binop($1, OP_ADD, $3);
                printf("Producao: sexp : sexp + sexp\n");
            }
	|	sexp SUB sexp
            {
                $$ = new_sexp_binop($1, OP_SUB, $3);
                printf("Producao: sexp : sexp - sexp\n");
            }
	|	sexp MUL sexp
            {
                $$ = new_sexp_binop($1, OP_MUL, $3);
                printf("Producao: sexp : sexp * sexp\n");
            }
	|	sexp DIV sexp
            {
                $$ = new_sexp_binop($1, OP_DIV, $3);
                printf("Producao: sexp : sexp / sexp\n");
            }
	|	sexp MOD sexp
            {
                $$ = new_sexp_binop($1, OP_MOD, $3);
                printf("Producao: sexp : sexp mod sexp\n");
            }
	|	SUB sexp
            {
                $$ = new_sexp_sinop(OP_SUB, $2);
                printf("Producao: sexp : -sexp\n");
            }
	
	|	sexp POINT ID          // Nomes qualificados
            {
                $$ = new_sexp_qualified_name($1, $3);
                printf("Producao: sexp : sexp.ID\n");
            }
	|	sexp LPARR exp RPARR   // Referencias a arrays
            {
                $$ = new_sexp_sexp_2($1, $3, STRUCT_ARRAY_REF);
                printf("Producao: sexp : sexp [ exp ]\n");
            } //referencias a arrays
	|	sexp LPAR exp RPAR    // Aplicacao funcional
            {
                $$ = new_sexp_sexp_2($1, $3, STRUCT_APLICACAO_FUNCIONAL);
                printf("Producao: sexp : sexp ( exp ) aplicacao funcional\n");
            }
	|	ARROBA LPAR exp RPAR  // Aplicacao recursiva directa
            {
                $$ = new_sexp_recursive_call($3);
                printf("Producao: sexp : @ [ exp ]\n");
            }
	|	ID
            {
                $$ = new_sexp_id($1);
                char *a = $1;printf("Producao: sexp : ID = %s\n", a);
            }
	
	|	INT_LIT
            {
                $$ = new_sexp_literal($1, LITERAL_INT);
                printf("Producao: sexp : INT_LIT\n");
            }
	|	REAL_LIT
            {
                $$ = new_sexp_literal($1, LITERAL_REAL);
                printf("Producao: sexp : REAL_LIT\n");
            }
	|	BOOL_LIT
            {
                $$ = new_sexp_literal($1, LITERAL_BOOL);
                printf("Producao: sexp : BOOL_LIT\n");
            }
	|	LPARR exp RPARR         // Literal de Array
            {
                $$ = new_sexp_literal_array($2);
                printf("Producao: sexp : [ exp ]\n");
            }
	|	MAP LPAR formals RPAR LPARR stats RPARR
            {
                $$ = new_sexp_map($3, NULL, $6, STRUCT_MAP);
                printf("Producao: sexp : MAP ( formals ) [ stats ] \n");
            } /* Literal funcional */
	|	MAP LPAR formals RPAR RARROW type LPARR stats RPARR
            {
                $$ = new_sexp_map($3, $6, $8, STRUCT_MAP_TYPE);
                printf("Producao: sexp : MAP ( formals ) -> type [ stats ]\n");
            }/*Idem,com tipo expl ́ıcito*/
	//|	CLASS LPAR formals RPAR LPARR stats RPARR				{printf("Producao: sexp : CLASS LPAR formals RPAR LPARR stats RPARR\n");} /* Literal de classe */
	//|	MAP	LPAR formals RPAR LPARR stats RPARR
	//|	MAP LPAR formals RPAR RARROW type	
;

prim: 
        ID
            {
                $$ = new_prim($1, NULL, NULL, PRIM_1);
            }
    |	prim POINT ID
            {
                $$ = new_prim($3, $1, NULL, PRIM_2);
            }
    |	prim LPARR exp RPARR
            {
                $$ = new_prim(NULL, $1, $3, PRIM_3);
            }
;

stats:
        {$$=NULL;}
	|	stat stats
        {
            //$$ = new_stats($1, $2);
            printf("Producao: stats\n");
        }
;

stat:
        NL
            {
                $$=NULL;line++;
                printf("\nline: %d\n\n", line);
            }
	|	decl
            {
                $$ = new_stat($1, NULL, NULL, NULL, NULL, DECL_);
                printf("Producao: stat : decl\n");
            }
	|	prim DECLASSIGN exp ENDOFSTM
            {
                $$ = new_stat(NULL, $1, $3, NULL, NULL, AFECTACAO_);
                printf("Producao: stat : prim := exp ;\n");
            }
	|	prim LPAR exp RPAR ENDOFSTM
            {
                $$ = new_stat(NULL, $1, $3, NULL, NULL, CALL_);
                printf("Producao: stat : prim ( exp ) ;\n");
            }
	|	RETURN exp ENDOFSTM
            {
                $$= new_stat(NULL, NULL, $2, NULL, NULL, RETURN_);
                printf("Producao: stat : ^ exp ;\n");
            }
	|	BREAK ENDOFSTM
            {
                $$= new_stat(NULL, NULL, NULL, NULL, NULL, BREAK_);
                printf("Producao: stat : break;\n");
            }
	|	SKIP ENDOFSTM
            {
                $$= new_stat(NULL, NULL, NULL, NULL, NULL, SKIP_);
                printf("Producao: stat : skip;\n");
            }
	|	RETRY ENDOFSTM
            {
                $$= new_stat(NULL, NULL, NULL, NULL, NULL, RETRY_);
                printf("Producao: stat : retry;\n");
            }
	|	COND LPARR clauses RPARR
            {
                $$= new_stat(NULL, NULL, NULL, $3, NULL, COND_);
                printf("Producao: stat : ? [ clauses ]\n");
            }
	|	WHILE LPARR clauses RPARR
            {
                $$= new_stat(NULL, NULL, NULL, $3, NULL, WHILE_);
                printf("Producao: stat : while [ clauses ]\n");
            }
	|	LPARR stats RPARR
            {
                $$= new_stat(NULL, NULL, NULL, NULL, NULL, AGRUPAMENTO_);
                printf("Producao: stat : [ stats ]\n");
            }
	//|	boolexp { $$=$1; if($$ == 1){printf("true\n");}else{printf("false\n");}}
;

clauses: 
		exp RARROW stats
            {
                $$ = new_clauses($1, $3, NULL, NULL, CLAUSES_1);
                printf("Producao: clauses : exp -> stats\n");
            }
	|	exp RARROW stats OR clauses
            {
                $$ = new_clauses($1, $3, NULL, $5, CLAUSES_2);
                printf("Producao: clauses : exp -> stats | clauses \n");
            }
	|	exp RARROW stats OR ELSE RARROW stats
            {
                $$ = new_clauses($1, $3, $7, NULL, CLAUSES_3);
                printf("Producao: clauses : exp -> stats | ELSE -> stats \n");
            }
;



/*
boolop: 	
		BOOL_LIT 				{ $$= $1;}
	|	NOT boolop 			{ $$ = $2==1?0:1;}	
	|	boolop AND BOOL_LIT     	{$$= $1&&$3;}
	|	boolop OR BOOL_LIT		{$$= $1||$3;}
	|	LPAR boolop RPAR		{$$ = $2;}
	|	boolexp				{$$ = $1;}
;

boolexp:
                            {$$ = NULL;}
	|	exp LESS exp 		{$$= $1 <$3?1:0;}
;
*/
//------------------------------- OLD --------------------------------------
/*
line:		NL      { $$=0; }
		|	exp NL  { $$=$1; printf ("%.2lf\n", $$); }
		|	boolop  { $$=$1; if($$ == 1){printf("true\n");}else{printf("false\n");}}
		|	decls	{}
		|	stat		{}
;
*/

/*
exp: 
		INT_VAL             { $$ = $1; }
	|	ID                { $$ = array[(int)$1]; }
	|	ID EQUAL exp     {array[(int)$1] = $3; $$ = $3;}
	|	DOUBLE_VAL          { $$  = $1; }
	|	exp ADD exp        { $$ = $1 + $3; }
	|	exp SUB exp        { $$ = $1 - $3; }
	|	exp DIV exp        { $$ = $1 / $3; }
    | 	exp MUL exp        { $$ = $1 * $3; }
    |	INT_VAL MOD INT_VAL  { $$ = (int)$1 % (int)$3; }
    |	SUB exp  %prec NEG { $$ = (0 - $2); }
    |	LPAR exp RPAR      { $$ = $2; }
;
*/
%%
/* Called by yyparse on error.  */
void print_(Decls *decls)
{
    printf("NICE!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
}

void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

int main (void)
{
    line = 1;
    return yyparse();
}
