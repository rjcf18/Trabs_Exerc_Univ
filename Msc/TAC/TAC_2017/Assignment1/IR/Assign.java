package IR;

public class Assign extends Statement{
  public ID id;
  public Expression exp;

  public Assign(ID id, Expression exp){
    this.id = id;
    this.exp = exp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  } 
}
