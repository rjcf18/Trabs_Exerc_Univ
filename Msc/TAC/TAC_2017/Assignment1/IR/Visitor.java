package IR;

//Visitor pattern interface
public interface Visitor {
  public void visit(AST n);
  public void visit(Assign n);
  public void visit(Body n);
  public void visit(CallProc n);
  public void visit(CompoundStatement n);
  public void visit(Conditional n);
  public void visit(FormalArg n);
  public void visit(FunDef n);
  public void visit(VarDecl n);
  public void visit(While n);
  public void visit(Print n);

  /*
  * expression visitors return a string which is the temporary where the
  * result is stored in order to keep track of where it was stored
  */
  public String visit(CallFunc n);
  public String visit(ID n);
  public String visit(IntLit n);
  public String visit(RealLit n);
  public String visit(Bool n);
  public String visit(Or n);
  public String visit(And n);
  public String visit(Lt n);
  public String visit(Le n);
  public String visit(Gt n);
  public String visit(Ge n);
  public String visit(Plus n);
  public String visit(Minus n);
  public String visit(Times n);
  public String visit(Div n);
  public String visit(Eq n);
  public String visit(Neq n);
  public String visit(Mod n);
  public String visit(Not n);
  public String visit(Inv n);
  public String visit(ToReal n);
}
