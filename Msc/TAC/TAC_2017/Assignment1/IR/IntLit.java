package IR;

public class IntLit extends Expression {
  public Integer i;

  public IntLit(Integer i){
    this.i = i;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
