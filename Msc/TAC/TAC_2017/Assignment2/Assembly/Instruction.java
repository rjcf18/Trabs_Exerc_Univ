package Assembly;

public abstract class Instruction {
  public abstract void accept(Visitor v);
}
