package IR;

public class AST{
  public GlobalDecls g;


  public AST(GlobalDecls g) {
      this.g = g;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }

}
