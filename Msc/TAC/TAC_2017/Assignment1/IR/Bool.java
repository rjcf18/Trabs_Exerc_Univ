package IR;

public class Bool extends Expression{
  public String bool;

  public Bool(String bool){
    this.bool = bool;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }

}
