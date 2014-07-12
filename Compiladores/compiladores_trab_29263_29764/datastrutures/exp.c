#include "exp.h"


Exp exp_binop_new(Exp e1, Exp e2, int op)
{
	Exp exp = (Exp) malloc(sizeof(Exp));
	exp->kind = KBIN;
	exp->u.Binop.e1 = e1;
	exp->u.Binop.e2 = e2;
	exp->u.Binop.op = op;
	
	return exp;
}

