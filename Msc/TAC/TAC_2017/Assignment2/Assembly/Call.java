package Assembly;

public class Call extends Instruction{
  public String id; /* function or procedure name */
  public String temp;
  public CallArgs call_args;

  public Call(String id, String temp, CallArgs call_args) {
      this.id = id;
      this.temp = temp;
      this.call_args = call_args;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
