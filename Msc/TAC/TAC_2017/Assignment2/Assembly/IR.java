package Assembly;

public class IR{
  public GlobalDecls g;
  public Functions fs;


  public IR(GlobalDecls g, Functions fs) {
      this.g = g;
      this.fs = fs;
  }

  public IR(GlobalDecls g) {
      this.g = g;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }

}
