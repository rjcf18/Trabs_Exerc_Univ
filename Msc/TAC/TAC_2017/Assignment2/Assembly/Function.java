package Assembly;

public class Function{
  public String id;
  public Instructions insts;

  public Function(String id, Instructions insts) {
      this.id = id;
      this.insts = insts;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
