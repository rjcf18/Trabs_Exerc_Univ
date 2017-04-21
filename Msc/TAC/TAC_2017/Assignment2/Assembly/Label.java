package Assembly;

public class Label extends Instruction{
  public String label;

  public Label(String label) {
      this.label = label;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
