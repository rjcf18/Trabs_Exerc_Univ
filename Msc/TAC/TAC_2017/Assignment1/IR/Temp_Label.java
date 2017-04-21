package IR;

public class Temp_Label {
  private int num;
  private String kind; // t, fp or l

  public Temp_Label(String kind) {
    this.kind = kind;
    num = 0;
  }

  public void reset(){
    num = 0;
  }

  public void inc(){
    num++;
  }

  public int getN(){
    return num;
  }

  public String toString() {
    return kind + num;
  }
}
