package Assembly;

public class OneOperand extends Instruction{
  public String inst; /* one operand instruction*/
  public String temp1;
  public String temp2;

  public OneOperand(String inst, String temp1, String temp2) {
      this.inst = inst;
      this.temp1 = temp1;
      this.temp2 = temp2;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
