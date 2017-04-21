package IR;

public class FunDef extends GlobalDecl{
  public String id;
  public FormalArgs args;
  public Body b;

  public FunDef(String id, FormalArgs args, Body b) {
      this.id = id;
      this.args = args;
      this.b = b;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
