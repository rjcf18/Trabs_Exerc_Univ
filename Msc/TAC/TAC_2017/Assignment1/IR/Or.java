package IR;

public class Or extends Expression {
  public Expression e1;
  public Expression e2;

  public Or(Expression e1, Expression e2){
    this.e1 = e1;
    this.e2 = e2;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
