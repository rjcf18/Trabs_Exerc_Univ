package IR;

public class While extends Statement{
  public Expression exp;
  public Statement stmt;

  public While(Expression exp, Statement stmt){
    this.exp = exp;
    this.stmt = stmt;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
