package IR;

import java.util.Vector;

public class FormalArgs {
   private Vector<FormalArg> list;

   public FormalArgs() {
      list = new Vector<FormalArg>();
   }

   public void addElement(FormalArg n) {
      list.addElement(n);
   }

   public FormalArg elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
