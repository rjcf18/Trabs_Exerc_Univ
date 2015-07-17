
// exemplo do professor
// incompleto
typedef struct Exp
{
	enum {KID, KINT, KREAL, KBIN, KFUNC} kind; //(...)
	union {
		char *id;
		int ival;
		double rval;
		
		struct {
			Exp *e1;
			Exp *e2;
			enum{SUM, DIV, MUL, SUB} BINOP;
		} Binop;
		
		struct {
			char *func;
			struct Args *args;
		} Func;
		
		// (...)
	}u;
}*Exp;

Exp exp_binop_new(Exp e1, Exp e2, int op);



