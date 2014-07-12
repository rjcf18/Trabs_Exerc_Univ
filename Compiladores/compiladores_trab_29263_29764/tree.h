



typedef struct Type_ *Type;
struct Type_
{
  enum { Int_LIT, Double_LIT, Bool_LIT} kind;
  Type type;
  union {
      struct 
      {
      	int number;
      } Int;
	
      struct 
      {
      	float number;
      } Double_lit;
	  
      struct 
      {
      	int number;
      } Bool_lit;
  }type_;
};


typedef struct Operation *Op;
struct Operation
{
  enum {OP, BIN_OP, BOOL_OP} kind;
  
  Op op;
  
  union {
	
   	struct 
    {
		
    } Op;
		
 	struct 
  	{
    	Op operand1;
   		Op operand2;
		Op bin_operation;
  	} binop;
	
  	struct 
  	{
    	Op operand1;
   		Op operand2;
		Op bool_operation;
	} boolop;
  } u; 
};
