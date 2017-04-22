package IR;

public class ID extends Expression{
  public String id;
  public String kind;
  public String type;

  public ID(String id, String kind, String type){
      this.id = id;
      this.kind = kind;
      this.type = type;
  }

  public String accept(Visitor v) {
    return v.visit(this);
  }
}
