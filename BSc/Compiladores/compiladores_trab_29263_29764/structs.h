
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

#define STRUCT_BINOP 0
#define STRUCT_SINOP 1
#define STRUCT_MAP 2
#define STRUCT_MAP_TYPE 3

#define STRUCT_ID 4
#define STRUCT_IDS 5

#define STRUCT_LITERAL 6
#define STRUCT_EXP_1 7
#define STRUCT_QUALIFIED_NAME 8
#define STRUCT_ARRAY_REF 9
#define STRUCT_APLICACAO_FUNCIONAL 10
#define STRUCT_RECURSIVE_CALL 11

enum stat_kind {DECL_, AFECTACAO_, CALL_, RETURN_, BREAK_, SKIP_, RETRY_, COND_, WHILE_, AGRUPAMENTO_};
enum stats_kind {STAT_, STATS_};
enum clauses_kind {CLAUSES_1, CLAUSES_2, CLAUSES_3};
enum sexp_kind {binop_, sinop_, qualified_name_, ref_array_, aplicacao_funcional_, chamada_recursiva_, id_, lit_int_, lit_real_, lit_bool_, lit_array_, lit_funcional_, lit_funcional_type_};
enum prim_kind {PRIM_1, PRIM_2, PRIM_3};
enum single_type_kind {INT_, REAL_, BOOL_, VOID_, FUNCTIONAL_TYPE_, ARRAY_, AGREGADO_};
enum type_kind {TYPE_1, TYPE_2, TYPE_3};

enum id_kind {ID_1, ID_2};
enum ids_kind {IDS_1, IDS_2};
enum op_kind {ADD_, SUB_, DIV_, MUL_, MOD_, AND_,OR_, NOT_, LESS_, LESSOREQUAL_, DIFF_, GREATER_, GREATEROREQUAL_};
enum formals_kind {FORMALS_, NONE_FORMALS};
enum formal_decl_kind {FORMAL_DECL_1, FORMAL_DECL_2};
enum decl_kind {DECL_1, DECL_2, DECL_3, DECL_4, DECL_5};
enum decls_kind {DECLS_, NONE_DECLS};

#define STRUCT_STAT 12
#define STRUCT_STATS 13
#define STRUCT_STATS_PR_E 14
#define STRUCT_STAT_AFECTACAO 15
#define STRUCT_STAT_CHAMADA 16
#define STRUCT_STAT_RETORNO 17
#define STRUCT_STAT_BREAK 18
#define STRUCT_STAT_SKIP 19
#define STRUCT_STAT_RETRY 20
#define STRUCT_STAT_COND 21
#define STRUCT_STAT_WHILE 22
#define STRUCT_STAT_AGRUPAMENTO 23

#define STRUCT_FORMALS 24
#define STRUCT_FORMAL_DECL 25
#define STRUCT_FORMAL_IDS 26
#define STRUCT_FORMAL_TYPE 27

#define STRUCT_TYPE 28
#define STRUCT_STYPE 29

#define STRUCT_EXP_2 30
#define STRUCT_EXP_3 31
#define STRUCT_SEXP_2 32
#define STRUCT_ARRAY 33
#define STRUCT_POSICAO 34
#define STRUCT_VAR 35

#define STRUCT_PRIM 36
#define STRUCT_PRIM_ID 37
#define STRUCT_PRIM_P_ID 38
#define STRUCT_PRIM_P_EXP 39

#define STRUCT_CLAUSES 40
#define STRUCT_CLAUSES_E_S 41
#define STRUCT_CLAUSES_E_S_CL 42
#define STRUCT_CLAUSES_E_S_S 43

#define LITERAL_INT 44
#define LITERAL_REAL 45
#define LITERAL_BOOL 46
#define LITERAL_ARRAY 47

#define OP_ADD 48
#define OP_SUB 49
#define OP_MUL 50
#define OP_DIV 51
#define OP_MOD 52
#define OP_AND 53
#define OP_OR 54
#define OP_NOT 55

#define OP_LESS 56
#define OP_LESSOREQUAL 457
#define OP_EQUAL 58
#define OP_GREATER 59
#define OP_GREATEROREQUAL 60
#define OP_DIFF 61

#define STRUCT_DECL 62
#define STRUCT_DECL_I_T 63
#define STRUCT_DECL_I_T_E 64
#define STRUCT_DECL_I_E 65


// ------------------------ STRUCTS DECLARATIONS ------------------------------

typedef struct SExp SExp;
typedef struct Exp Exp;
typedef struct SExp_Coma_Exp SExp_Coma_Exp;

typedef struct Binop Binop;
typedef struct Sinop Sinop;
typedef struct Id Id;
typedef struct Ids Ids;
typedef struct Array Array;

typedef struct Decl Decl;
typedef struct Decls Decls;
typedef struct Decl_I_T Decl_I_T; // Ids e Type
typedef struct Decl_I_T_E Decl_I_T_E; // Ids, Type e Exp
typedef struct Decl_I_E Decl_I_E; // Ids e Exp

typedef struct Formals Formals;
typedef struct Formal_decl Formal_decl;
typedef struct Form_ids Form_ids; // tipo implícito
typedef struct Form_ids_type Form_ids_type; // tipo explícito

typedef struct Literal Literal;
typedef struct Literal_Array Literal_Array;
typedef struct Map Map;

typedef struct Type Type;
typedef struct Single_Type Single_Type;
typedef struct Type_tuple Type_tuple;
typedef struct Functional_Type Functional_Type;

typedef struct Statement Statement;
typedef struct Statement_PR_E Statement_PR_E;
typedef struct Statements Statements;

typedef struct Prim Prim;
typedef struct Prim_ID Prim_ID;
typedef struct Prim_P_ID Prim_P_ID;
typedef struct Prim_P_Exp Prim_P_Exp;

typedef struct Clauses Clauses;
typedef struct Clauses_E_S Clauses_E_S;
typedef struct Clauses_E_S_CL Clauses_E_S_CL;
typedef struct Clauses_E_S_S Clauses_E_S_S;

typedef struct Qualified_Name Qualified_Name;
typedef struct SExp_2 SExp_2;
typedef struct Recursive_call Recursive_call;
typedef struct Op Op;


// -------------------------------- AUX FUNCTIONS -------------------

void print_(Decls *decls);



// ---------------------------------- STRUCTS -----------------------------------

// DONE
struct Literal
{
    enum {INT_, REAL_, BOOL_}kind;
    float value;
};

// DONE
struct Literal_Array
{
    Exp *exp;
};

// DONE
struct Map
{
    enum {FORMAL_, FORMAL_TYPE} kind;
    
    Formals *formals;
    Statements *stats;
    Type *return_type;
};

// DONE
struct Exp
{
    enum { EXP_, EXP_COMA_EXP, LPAR_EXP_RPAR }kind;
    
    struct Exp *exp;
    struct SExp *sexp;
};

// DONE
struct SExp_Coma_Exp
{
    SExp *sexp;
    Exp *exp;
};

// DONE
struct SExp
{
    enum {BINOP_, SINOP_, MAP_, ID_, LITERAL_, QUAL_NAME, ARRAY_REFERENCE, APP_FUNCIONAL, RECURSIVE_CALL} kind;
    union{
        struct Sinop *sinop;
        struct Binop *binop;
        struct Map *map;
        struct Id *id_;
        struct Literal *lit;
        struct Literal_Array *lit_array;
        struct Qualified_Name *q_name;
        struct SExp_2 *sexp2;
        struct Recursive_call *r_call;
    }u;
};

//  DONE
struct Sinop
{
    Exp *op1;
    int op;
};

//  DONE
struct Binop
{
    SExp *op1;
    SExp *op2;
    int op;
};

//  DONE
struct Id
{
    enum id_kind kind;
    char *nome;
    Op *op;
};

struct Op
{
    char *op;
    enum op_kind kind;
};

// Utilizada na producao sexp : sexp.ID
struct Qualified_Name
{
    SExp *sexp;
    Id *id_;
};


struct SExp_2
{
    enum {ARRAY_REF, APLICACAO_FUNCIONAL}kind;
    
    SExp *sexp;
    Exp *exp;
};

struct Recursive_call
{
    Exp *exp;
};

// DONE
struct Ids{
    enum ids_kind kind;
    Id *id_;
    Ids *ids;
};

struct Decl{
    enum decl_kind kind;
    
    Ids *ids;
    Type *type;
    Exp *exp;
    /*
    union{
        Decl_I_T *decl_i_t;
        Decl_I_T_E *decl_i_t_e;
        Decl_I_E *decl_i_e;
    }u;*/
};

struct Decls{
	enum decls_kind kind;
    
    Decl  *decl;
    Decls *decls;
    /*
     union
     {
     Formal_decl *formal;
     Formals *formals;
     }u;*/
	
};

//tem um Ids e um Type
struct Decl_I_T{
	Ids *ids;
    Type *type;
};

//tem um Ids, um Type e um Exp
struct Decl_I_T_E{
    Ids *ids;
    Type *type;
    Exp *exp;
};

//ou tem um Ids e um Exp
struct Decl_I_E{
    Ids *ids;
    Exp *exp;
};

struct Statement{
	enum stat_kind kind;

	union{
		Decl *decl;
		Statement_PR_E *stat_pr_e;
		Exp *exp;
		Clauses *clauses;
		Statements *stmts;
    }u;
};

struct Statement_PR_E{
	Prim *pr;
	Exp *exp;
};

struct Statements{
	enum{STAT, STATS} kind;

	Statement *st;
    Statements *stats;
};

struct Formals{
	enum formals_kind kind;
    
    Formal_decl *formal;
    Formals *formals;
    /*
    union
    {
        Formal_decl *formal;
        Formals *formals;
    }u;*/
	
};

struct Formal_decl{
    enum formal_decl_kind kind;
    
    Ids *ids;
    Type *type;
};
/*
//formal_decl com 1 Ids - tipo implícito
struct Form_ids{
	Ids *ids;
};

//formal_decl com 1 Ids e 1 Type - tipo explícito
struct Form_ids_type{
	Ids *ids;
	Type *type;
};
*/
struct Type{
    enum type_kind kind;

    struct Single_Type *stype;
    struct Type *type;
};

// Utilizado na producao single_type
struct Functional_Type
{
    struct Type *type1;
    struct Type *type2;
};

struct Var{
	char name[26];
	Literal *l;
};

struct Array
{
    int size;
    struct Posicao *p1[500];
		
};

struct Posicao{
	Literal *l[100]; 
	int size;
};

struct Single_Type{
    
    enum single_type_kind kind;
    
    Type *type1;
    Type *type2;
    Exp *exp;
    Formals *formals;
    
};

struct Prim{
    enum prim_kind kind;
    
    Id *id_;
    Prim *prim;
    Exp *exp;
};
/*
struct Prim_ID{
	Id *id;
};

struct Prim_P_ID{
	Id *id;
	Prim *pr;
};

struct Prim_P_Exp{
	Exp *exp;
	Prim *pr;
};*/

struct Clauses{
	enum clauses_kind kind;
    
    Exp *exp;
	Statements *stats1;
	Statements *stats2;
    Clauses *clauses;
};
/*
//instrução com guarda
struct Clauses_E_S{
	Exp *exp;
	Statements *stmts;
};

struct Clauses_E_S_CL{
	Exp *exp;
	Statements *stmts;
	Clauses *cl;
};

struct Clauses_E_S_S{
	Exp *exp;
	Statements *stmts1;
	Statements *stmts2;
};*/

// ----------------------- EXP/SEXP FUNCTIONS ------------------------
Binop *new_binop(SExp *op1, SExp *op2, int op)
{
    Binop *binop = malloc(sizeof(Binop));
    
    binop->op1 = op1;
    binop->op2 = op2;
    binop->op = op;
    
    return binop;
}

Sinop *new_sinop(Exp *exp, int op)
{
    Sinop *sinop = malloc(sizeof(Sinop));
    sinop->op1 = exp;
    sinop->op = op;
    
    return sinop;
}

Op *new_op(char *nome, enum op_kind kind_op)
{
    Op *op = malloc(sizeof(Op));
    
    op->kind = kind_op;
    op->op = nome;
    
    return op;
}

Id *new_id(char *nome)
{
    Id *new_id = malloc(sizeof(Id));
    
    new_id->nome = strdup(nome);
    new_id->kind = ID_1;
    
    return new_id;
}

Ids *new_ids(Id *id_, Ids *ids, enum ids_kind kind)
{
    Ids *n_ids = malloc(sizeof(Ids));
    
    n_ids->kind = kind;
    n_ids->id_ = id_;
    n_ids->ids = ids;
    
    return n_ids;
}

Id *new_id_op(char *nome, enum op_kind kind_op)
{
    Id *new_id = malloc(sizeof(Id));
    
    new_id->nome = strdup(nome);
    new_id->op = new_op(nome, kind_op);
    new_id->kind = ID_2;
    return new_id;
}

Literal *new_literal(int value, int kind)
{
    Literal *lit = malloc(sizeof(Literal));
    lit->value = value;
    lit->kind = kind;
    
    return lit;
}

Literal_Array *new_literal_array(Exp *exp)
{
    Literal_Array *new_lit_array = malloc(sizeof(Literal_Array));
    new_lit_array->exp = exp;
    return new_lit_array;
}

Map *new_map(Formals *formals, Statements *stats, Type *type, int kind)
{
    Map *new_map = malloc(sizeof(Map));
    new_map->formals = formals;
    new_map->stats = stats;
    new_map->return_type = type;
    new_map->kind = kind;
    
    return new_map;
}


SExp *new_sexp_binop(SExp *sexp1, int op, SExp *sexp2)
{
    Binop *n_binop = new_binop(sexp1, sexp2, op);
    
    SExp *new_sexp = malloc(sizeof(SExp));
    new_sexp->kind = STRUCT_BINOP;
    new_sexp->u.binop = n_binop;
    
    return new_sexp;
}

SExp *new_sexp_sinop(int op, SExp *sexp)
{
    SExp *n_sexp = malloc(sizeof(SExp));
    
    return n_sexp;
}

SExp *new_sexp_literal(float value, int kind)
{
    Literal *new_lit = malloc(sizeof(Literal));
    SExp *new_sexp = malloc(sizeof(SExp));
    
    new_lit->kind = kind;
    new_lit->value = value;
    
    new_sexp->kind = STRUCT_LITERAL;
    new_sexp->u.lit = new_lit;
    
    return new_sexp;
}

SExp *new_sexp_id(char *nome)
{
    
    SExp *new_sexp = malloc(sizeof(SExp));
    
    new_sexp->kind = STRUCT_ID;
    new_sexp->u.id_ = new_id(nome);
    
    return new_sexp;
}

SExp *new_sexp_literal_array(Exp *exp)
{
    SExp *new_sexp_lit_array = malloc(sizeof(SExp));
    
    new_sexp_lit_array->kind = LITERAL_ARRAY;
    new_sexp_lit_array->u.lit_array = new_literal_array(exp);
    
    return new_sexp_lit_array;
}

SExp *new_sexp_map(Formals *formals, Type *type, Statements *stats, int kind)
{
    SExp *new_sexp_map = malloc(sizeof(SExp));
    
    new_sexp_map->kind = kind;
    
    if (kind == STRUCT_MAP)
    {
        new_sexp_map->u.map = new_map(formals, stats, type, STRUCT_MAP);
    }
    else
    {
        new_sexp_map->u.map = new_map(formals, stats, type, STRUCT_MAP_TYPE);
    }
    
    return new_sexp_map;
}

SExp_Coma_Exp *new_exp_sexp_comma_exp(SExp *sexp, Exp *exp)
{
    SExp_Coma_Exp *new_sce = malloc(sizeof(SExp_Coma_Exp));
    new_sce->sexp = sexp;
    new_sce->exp = exp;
    
    return new_sce;
}

Qualified_Name *new_qualified_name(SExp *sexp, char *nome)
{
    Id *id_ = new_id(nome);
    
    Qualified_Name *new_qn = malloc(sizeof(Qualified_Name));
    new_qn->sexp = sexp;
    new_qn->id_ = id_;
    
    return new_qn;
}

SExp_2 *new_sexp_2(SExp *sexp, Exp *exp, int kind)
{
    SExp_2 *sexp_2 = malloc(sizeof(SExp_2));
    
    sexp_2->kind = kind;
    sexp_2->sexp = sexp;
    sexp_2->exp = exp;
    
    return sexp_2;
}

Recursive_call *new_recursive_call(Exp *exp)
{
    Recursive_call *recusive_call = malloc(sizeof(Recursive_call));
    recusive_call->exp = exp;
    
    return recusive_call;
}

SExp *new_sexp_qualified_name(SExp *sexp, char *id_)
{
    SExp *n_sexp = malloc(sizeof(SExp));
    
    n_sexp->kind = STRUCT_QUALIFIED_NAME;
    n_sexp->u.q_name = new_qualified_name(sexp, id_);
    
    return n_sexp;
}

SExp *new_sexp_sexp_2(SExp *sexp, Exp *exp, int kind)
{
    SExp *n_sexp = malloc(sizeof(SExp));
    n_sexp->kind = STRUCT_SEXP_2;
    n_sexp->u.sexp2 = new_sexp_2(sexp, exp, kind);
    
    return sexp;
}

SExp *new_sexp_recursive_call(Exp *exp)
{
    SExp *sexp = malloc(sizeof(SExp));
    sexp->kind = STRUCT_RECURSIVE_CALL;
    sexp->u.r_call = new_recursive_call(exp);
    
    return sexp;
}

Exp *new_exp(SExp *sexp, Exp *exp, int kind)
{
    Exp *new_exp_ = malloc(sizeof(Exp));
    
    new_exp_->kind = kind;
    new_exp_->sexp = sexp;
    new_exp_->exp = exp;
    
    return new_exp_;
}

// ---------------------- DECL --------------------------

Decl *new_decl(Ids *ids, Type *type, Exp *exp, enum decl_kind kind)
{
    Decl *n_decl =malloc(sizeof(Decl));
    
    n_decl->kind = kind;
    n_decl->ids = ids;
    n_decl->type = type;
    n_decl->exp = exp;
    
    return n_decl;
}

Decls *new_decls(Decl *decl, Decls *decls)
{
    
    Decls *n_decls = malloc(sizeof(Decls));
    
    if (decls == NULL) {
        n_decls->kind = NONE_DECLS;
    }
    else
    {
        n_decls->kind = DECLS_;
    }
    
    n_decls->decl = decl;
    n_decls->decls = decls;
    
    //n_formals->u.
    
    return  n_decls;
}
/*
Decl_I_T *new_decl_i_t(Ids *ids, Type *type)
{
    Decl_I_T * new_decl = malloc(sizeof(Decl_I_T));
    
    new_decl->ids = ids;
    new_decl->type = type;
    
    return new_decl;
}

Decl_I_E *new_decl_i_e(Ids *ids, Exp *exp)
{
    Decl_I_E * new_decl = malloc(sizeof(Decl_I_E));
    
    new_decl->ids = ids;
    new_decl->exp = exp;
    
    return new_decl;
}

Decl_I_T_E *new_decl_i_t_e(Ids *ids, Type *type, Exp *exp)
{
    Decl_I_T_E * new_decl = malloc(sizeof(Decl_I_T_E));
    
    new_decl->ids = ids;
    new_decl->type = type;
    new_decl->exp = exp;
    
    return new_decl;
}

Decl *new_decl_decl_i_t(Ids *ids, Type *type, Exp *exp, int kind)
{
    Decl *decl = malloc(sizeof(Decl));
    decl->kind = kind;
    switch (kind) {
        case STRUCT_DECL_I_E:
            decl->u.decl_i_e = new_decl_i_e(ids, exp);
            break;
        case STRUCT_DECL_I_T:
            decl->u.decl_i_t = new_decl_i_t(ids, type);
            break;
        case STRUCT_DECL_I_T_E:
            decl->u.decl_i_t_e = new_decl_i_t_e(ids, type, exp);
            break;
        default:
            break;
    }
    
    return decl;
}*/

// ---------------------- STATEMENT/STATEMENTS --------------------------

Statements *new_stats(Statement *stat, Statements *stats)
{
    Statements *n_stats = malloc(sizeof(Statements));
    n_stats->st = stat;
    if (stats == NULL)
    {
        n_stats->kind = STAT_;
    }
    else
    {
        n_stats->kind = STATS_;
        n_stats->stats = stats;
    }
    
    return n_stats;
}

Statement_PR_E *new_stat_pr_e(Prim *pr, Exp *exp)
{
    Statement_PR_E *stat = malloc(sizeof(Statement_PR_E));
    stat->pr = pr;
    stat->exp = exp;
    
    return stat;
}

Statement *new_stat(Decl *decl, Prim *prim, Exp *exp, Clauses *clauses, Statements *stmts, enum stat_kind kind)
{
    Statement *n_stat = malloc(sizeof(Statement));
    
    n_stat->kind = kind;
    
    switch (kind) {
        case DECL_:
            n_stat->u.decl = decl;
            break;
        case AFECTACAO_ :
            n_stat->u.stat_pr_e = new_stat_pr_e(prim, exp);
            break;
        case CALL_ :
            n_stat->u.stat_pr_e = new_stat_pr_e(prim, exp);
            break;
        case COND_ :
            n_stat->u.clauses = clauses;
            break;
        case WHILE_:
            n_stat->u.clauses = clauses;
            break;
        case AGRUPAMENTO_:
            n_stat->u.stmts = stmts;
            break;
        default:
            break;
    }
    
    return n_stat;
}

// ---------------------- CLAUSES --------------------------

Clauses *new_clauses(Exp *exp, Statements *stats1,Statements *stats2, Clauses *clauses, enum clauses_kind kind)
{
    Clauses *n_clauses = malloc(sizeof(Clauses));
    
    n_clauses->kind = kind;
    n_clauses->exp = exp;
    n_clauses->stats1 = stats1;
    n_clauses->stats2 = stats2;
    n_clauses->clauses = clauses;
    
    return n_clauses;
}

// ---------------------- PRIM --------------------------


Prim *new_prim(char *id_, Prim *prim, Exp *exp, enum prim_kind kind)
{
    Id *n_id = new_id(id_);
    
    Prim *n_prim = malloc(sizeof(Prim));
    
    n_prim->kind = kind;
    n_prim->id_ = n_id;
    n_prim->prim =prim;
    n_prim->exp = exp;
    
    
    return n_prim;
}

// ---------------------- TYPE/SINGLE_TYPE --------------------------



Single_Type *new_single_type(Type *type1, Type *type2, Exp *exp, Formals *formals, enum single_type_kind kind)
{
    Single_Type *n_stype = malloc(sizeof(Single_Type));
    
    n_stype->kind = kind;
    n_stype->type1 = type1;
    n_stype->type2 = type2;
    n_stype->exp = exp;
    n_stype->formals = formals;
    
    return n_stype;
}

Type *new_type(Single_Type *stype, Type *type, enum type_kind kind)
{
    Type *n_type = malloc(sizeof(Type));
    
    n_type->kind = kind;
    n_type->stype = stype;
    n_type->type = type;
    
    return n_type;
}

// ---------------------- FORMAL/FORMAL_DECL --------------------------

Formal_decl *new_formal_decl(Ids *ids, Type *type, enum formal_decl_kind kind)
{
    Formal_decl *fd = malloc(sizeof(Formal_decl));
    
    fd->kind = kind;
    fd->ids = ids;
    fd->type = type;
    
    return fd;
}

Formals *new_formals( Formal_decl *fd, Formals *formals)
{
    
    Formals *n_formals = malloc(sizeof(Formals));
    
    if (formals == NULL) {
        n_formals->kind = NONE_FORMALS;
    }
    else
    {
        n_formals->kind = FORMALS_;
    }
    
    n_formals->formal = fd;
    n_formals->formals = formals;
    
    //n_formals->u.
    
    return  n_formals;
}






















