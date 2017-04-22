package IR;

public class Conditional extends Statement{
  public Expression exp;
  public Statement stmt1;
  public Statement stmt2;

  public Conditional(Expression exp, Statement stmt1, Statement stmt2){
    this.exp = exp;
    this.stmt1 = stmt1;
    this.stmt2 = stmt2;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
