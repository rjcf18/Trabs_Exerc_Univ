package IR;

public class CallFunc extends Expression {
  public String id;
  public Expressions exps;

  public CallFunc(String id, Expressions exps){
    this.id = id;
    this.exps = exps;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
