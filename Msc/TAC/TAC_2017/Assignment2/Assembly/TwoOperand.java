package Assembly;

public class TwoOperand extends Instruction{
  public String inst; /* two operand instruction*/
  public String temp1;
  public String temp2;
  public String temp3;

  public TwoOperand(String inst, String temp1, String temp2, String temp3) {
      this.inst = inst;
      this.temp1 = temp1;
      this.temp2 = temp2;
      this.temp3 = temp3;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
