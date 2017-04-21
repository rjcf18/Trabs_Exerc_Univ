package Assembly;

import java.util.Vector;

public class Instructions {
   private Vector<Instruction> list;

   public Instructions() {
      list = new Vector<Instruction>();
   }

   public void addElement(Instruction n) {
      list.addElement(n);
   }

   public Instruction elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
