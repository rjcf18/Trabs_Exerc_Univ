package IR;

import java.util.Vector;

public class CompoundStatement extends Statement {
   private Vector<Statement> list;

   public CompoundStatement() {
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

   public void accept(Visitor v) {
     v.visit(this);
   }
}
