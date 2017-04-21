package Assembly;

public class DataTransfer extends Instruction{
  public String inst; /* data transfer instruction*/
  public String temp;
  public String id;
  public Integer value;

  // loads and stores instructions constructor
  public DataTransfer(String inst, String temp, String id) {
      this.inst = inst;
      this.temp = temp;
      this.id = id;
  }

  // i_value instruction constructor
  public DataTransfer(String inst, String temp, Integer value) {
      this.inst = inst;
      this.temp = temp;
      this.value = value;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
