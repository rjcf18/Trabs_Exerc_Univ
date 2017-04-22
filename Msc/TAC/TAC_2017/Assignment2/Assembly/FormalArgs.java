package Assembly;

import java.util.Vector;

public class FormalArgs {
   public Vector<String> list;

   public FormalArgs() {
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
