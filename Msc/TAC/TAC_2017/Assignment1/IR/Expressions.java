package IR;

import java.util.Vector;

public class Expressions {
   private Vector<Expression> list;

   public Expressions() {
      list = new Vector<Expression>();
   }

   public void addElement(Expression n) {
      list.addElement(n);
   }

   public Expression elementAt(int i)  {
      return list.elementAt(i);
   }

   public int size() {
      return list.size();
   }
}
