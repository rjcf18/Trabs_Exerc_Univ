package IR;

public class CallProc extends Statement{
  public String id;
  public Expressions exps;

  public CallProc(String id, Expressions exps){
    this.id = id;
    this.exps = exps;
  }

  public void accept(Visitor v) {
    v.visit(this);
  } 
}
