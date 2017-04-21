package Assembly;

import java.util.Vector;

public class CallArgs {
   private Vector<String> list;

   public CallArgs() {
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
