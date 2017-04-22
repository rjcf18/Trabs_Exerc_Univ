package Assembly;

public class VarDecl extends GlobalDecl{
  public String id;
  public String type;
  public Integer value;

  public VarDecl(String id, String type, Integer value) {
      this.id = id;
      this.type = type;
      this.value = value;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
