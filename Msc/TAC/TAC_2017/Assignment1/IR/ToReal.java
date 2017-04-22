package IR;

public class ToReal extends Expression {
  public Expression e;

  public ToReal(Expression e){
    this.e = e;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
