package IR;

public class RealLit extends Expression {
  public Double r;

  public RealLit(Double r){
    this.r = r;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
