package Assembly;

public class Return extends Instruction{
  public String temp;

  public Return(String temp) {
      this.temp = temp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
