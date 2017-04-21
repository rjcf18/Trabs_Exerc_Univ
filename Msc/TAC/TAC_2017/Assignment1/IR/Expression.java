package IR;

public abstract class Expression {
  public String t; //return type
  public abstract String accept(Visitor v);
}
