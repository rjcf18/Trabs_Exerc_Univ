package Assembly;

import java.util.Vector;

public class LocalVars {
   public Vector<String> list;

   public LocalVars() {
      list = new Vector<String>();
   }

   public void addElement(String n) {
      list.addElement(n);
   }

   public String elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
