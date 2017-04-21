package IR;

public class Print extends Statement{
  public Expression exp;

  public Print(Expression exp){
    this.exp = exp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
