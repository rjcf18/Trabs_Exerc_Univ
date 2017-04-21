package Assembly;

public class FunDecl extends GlobalDecl{
  public String id;
  public String type;
  public FormalArgs formals;
  public LocalVars locals;

  public FunDecl(String id, String type, FormalArgs formals, LocalVars locals) {
      this.id = id;
      this.type = type;
      this.formals = formals;
      this.locals = locals;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
