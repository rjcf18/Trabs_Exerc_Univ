package Assembly;

public class Jump extends Instruction{
  public String label;

  public Jump(String label) {
      this.label = label;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
