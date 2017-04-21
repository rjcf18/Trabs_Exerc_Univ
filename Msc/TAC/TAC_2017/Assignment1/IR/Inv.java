package IR;

public class Inv extends Expression {
  public Expression e;

  public Inv(Expression e){
    this.e = e;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
