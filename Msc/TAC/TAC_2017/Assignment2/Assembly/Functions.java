package Assembly;

import java.util.Vector;

public class Functions {
   private Vector<Function> list;

   public Functions() {
      list = new Vector<Function>();
   }

   public void addElement(Function n) {
      list.addElement(n);
   }

   public Function elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
