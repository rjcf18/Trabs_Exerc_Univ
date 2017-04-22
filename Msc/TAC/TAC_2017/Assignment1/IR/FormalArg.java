package IR;

public class FormalArg{
  public String id;
  public String type;

  public FormalArg(String id, String type) {
      this.id = id;
      this.type = type;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
