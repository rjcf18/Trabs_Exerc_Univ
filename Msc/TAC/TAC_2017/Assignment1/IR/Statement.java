package IR;

public abstract class Statement {
  public abstract void accept(Visitor v);
}
