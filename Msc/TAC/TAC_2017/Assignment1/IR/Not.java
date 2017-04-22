package IR;

public class Not extends Expression {
  public Expression e;

  public Not(Expression e){
    this.e = e;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
