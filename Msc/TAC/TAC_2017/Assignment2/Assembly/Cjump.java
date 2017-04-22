package Assembly;

public class Cjump extends Instruction{
  public String temp;
  public String label1;
  public String label2;

  public Cjump(String temp, String label1, String label2) {
      this.temp = temp;
      this.label1 = label1;
      this.label2 = label2;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
