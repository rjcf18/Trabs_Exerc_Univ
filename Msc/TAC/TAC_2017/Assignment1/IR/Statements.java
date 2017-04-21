package IR;

import java.util.Vector;

public class Statements {
   private Vector<Statement> list;

   public Statements() {
      list = new Vector<Statement>();
   }

   public void addElement(Statement n) {
      list.addElement(n);
   }

   public Statement elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
