package IR;

public class Body{
  public VarDecls decls;
  public Statement stmts;
  public Expression exp;

  public Body(VarDecls decls, Statement stmts, Expression exp){
    this.decls = decls;
    this.stmts = stmts;
    this.exp = exp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
