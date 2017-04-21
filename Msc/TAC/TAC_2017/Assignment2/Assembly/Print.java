package Assembly;

public class Print extends Instruction{
  public String print; /* print type */
  public String temp;

  public Print(String print, String temp) {
      this.print = print;
      this.temp = temp;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
