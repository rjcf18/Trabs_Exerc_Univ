package Assembly;

//Visitor pattern interface
public interface Visitor {
  public void visit(IR n);
  public void visit(VarDecl n);
  public void visit(FunDecl n);
  public void visit(Function n);
  public void visit(TwoOperand n);
  public void visit(OneOperand n);
  public void visit(DataTransfer n);
  public void visit(Call n);
  public void visit(Print n);
  public void visit(Jump n);
  public void visit(Cjump n);
  public void visit(Label n);
  public void visit(Return n);
}
