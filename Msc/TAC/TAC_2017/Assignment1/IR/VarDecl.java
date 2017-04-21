package IR;

public class VarDecl extends GlobalDecl{
  public ID id;
  public Expression exp;

  public VarDecl(ID id, Expression exp) {
      this.id = id;
      this.exp = exp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
