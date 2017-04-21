package IR;

import java.util.Vector;

public class GlobalDecls {
   private Vector<GlobalDecl> list;

   public GlobalDecls() {
      list = new Vector<GlobalDecl>();
   }

   public void addElement(GlobalDecl n) {
      list.addElement(n);
   }

   public GlobalDecl elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
