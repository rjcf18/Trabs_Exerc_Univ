package IR;

import java.util.Vector;

public class IR_Gen implements Visitor{
  //Temporaries and labels
  public Temp_Label t = new Temp_Label("t"); // int temps
  public Temp_Label fp = new Temp_Label("fp"); // real temps
  public Temp_Label l = new Temp_Label("l"); // labels
  public String tmp = ""; // temporary where last result was stored

  // AST node visitor
  // Visits all the global declarations
  public void visit(AST n) {
    try{
      for (int i = 0; i < n.g.size(); i++ ) {
        if (!(n.g.elementAt(i) instanceof VarDecl)) {
          n.g.elementAt(i).accept(this);
          System.out.println("");
        }
      }
    }catch(NullPointerException e){
      e.printStackTrace();
    }
  }

  // Function/Procedure Definition node visitor
  public void visit(FunDef n){
    System.out.println("function @"+n.id.replace("\"", ""));
    n.b.accept(this);
    t.reset();
    fp.reset();
    l.reset();
  }

  //Function/Procedure body node visitor
  public void visit(Body n){

    if(n.exp == null){ //procedure body
      if(n.decls.size()!=0){// procedure with variable decls
        for(int i = 0; i < n.decls.size(); i++){
          n.decls.elementAt(i).accept(this);
        }
      }


      if(n.stmts != null){//procedure with statements

        n.stmts.accept(this);

      }
      System.out.println("\treturn");
    }
    else{ //function body
      if(n.decls.size() == 0){//body with no variable decls
        if(n.stmts != null){ //body with no variable decls and with statements
          n.stmts.accept(this);
        }
      }
      else{ //body with variable decls

        for(int i = 0; i < n.decls.size(); i++){
          n.decls.elementAt(i).accept(this);
        }

        //body with variable decls and with statements
        if(n.stmts != null){
          n.stmts.accept(this);
        }

      }

      // visit return expression node
      tmp = n.exp.accept(this);
      switch(n.exp.t){
        case "real":
          System.out.println("\tr_return "+tmp);
          break;
        default:
          System.out.println("\ti_return "+tmp);
          break;
      }
    }
  }

  //Variable declaration node visitor
  public void visit(VarDecl n){
    if(n.exp != null){
      tmp = n.exp.accept(this);
      String ir = "\t@"+n.id.id.replace("\"", "")+" <- ";

      switch(n.id.type){ // checks the variable's type
        case "real":
          ir += "r_";
          break;
        default:
          ir += "i_";
          break;
      }

      switch(n.id.kind){ //checks the variable kind
        case "var":
          ir += "gstore";
          break;
        case "local":
          ir += "lstore";
          break;
        case "arg":
          ir += "astore";
          break;
      }

      ir += " "+tmp;

      System.out.println(ir);
    }

  }

  // assignment node visitor
  public void visit(Assign n){
    String ir = "\t@"+n.id.id.replace("\"", "") + " <- ";
    String temp;

    // generates IR for assignment expression
    tmp = n.exp.accept(this);

    switch(n.id.type){ //checks the variable's type
      case "real":
        ir += "r_";
        //fp.inc();
        break;
      default:
        ir += "i_";
        //t.inc();
        break;
    }

    switch(n.id.kind){ // checks the variable's kind
      case "var":
        ir += "gstore";
        break;
      case "local":
        ir += "lstore";
        break;
      case "arg":
        ir += "astore";
        break;
    }

    ir += " "+tmp;

    System.out.println(ir);

  }

  // boolean node visitor
  public String visit(Bool n){
    tmp = t.toString();

    String ir = "\t"+tmp+ " <- "+ "i_value ";

    switch(n.bool){//checks the boolean value
      case "true":
        ir += 1;
      case "false":
        ir += 0;
    }

    t.inc();

    System.out.println(ir);

    return tmp;
  }

  // function call node visitor
  public String visit(CallFunc n){
    String ir = "call @"+n.id.replace("\"", "")+", [";
    Vector<String> tmps = new Vector<String>();


    if(n.exps.size() > 0){ // Function call with 1 or more parameters
      for (int i = 0; i < n.exps.size(); i++ ) {
        tmp = n.exps.elementAt(i).accept(this);

        if(i < n.exps.size()-1){ // construct the call node's parameters
          ir += tmp+", ";
        }
        else{ // last parameter
          ir += tmp + "]";
        }
      }
    }
    else{ // function call with no parameters
      ir += "]";
    }

    switch(n.t){ // checks type of the value returned
      case "real":
        tmp = fp.toString();
        fp.inc();
        ir = "\t"+tmp + " <- r_"+ir;
        //fp.inc();
        break;
      default:
        tmp = t.toString();
        t.inc();
        ir = "\t"+tmp + " <- i_"+ir;
        //t.inc();
        break;
    }

    System.out.println(ir);

    return tmp;

  }

  // procedure call node visitor
  public void visit(CallProc n){
    String ir = "\tcall @"+n.id.replace("\"", "")+", [";
    Vector<String> tmps = new Vector<String>();


    if(n.exps.size() > 0){ // Procedure call with 1 or more parameters
      for (int i = 0; i < n.exps.size(); i++ ) {
        tmp = n.exps.elementAt(i).accept(this);


        if(i < n.exps.size()-1){ // construct the call node's parameters
          ir += tmp + ", ";
        }
        else{ // last parameter
          ir += tmp + "]";
        }

      }
    }
    else{ // procedure call with no parameters
      ir += "]";
    }

    System.out.println(ir);

  }

  // compound statement node visitor
  public void visit(CompoundStatement n){
    for (int i = 0; i < n.size(); i++ ) {
        n.elementAt(i).accept(this);
    }
  }

  // conditional statement node visitor
  public void visit(Conditional n){
    String l1 = l.toString();
    l.inc();
    String l2 = l.toString();
    l.inc();
    String l3 = l.toString();
    l.inc();

    //visits expression node
    tmp = n.exp.accept(this);

    System.out.println("\tcjump " + tmp + ", " + l1 + ", " + l2);

    System.out.println(l1+":");

    n.stmt1.accept(this);

    if(n.stmt2 != null){ // if with else: visits else statement(s) node
        /*if(n.exp instanceof Ge){
          System.out.println("\tcjump " + tmp + ", " + l2 + ", " + l1);
        }
        else{
          System.out.println("\tcjump " + tmp + ", " + l1 + ", " + l2);
        }*/

        System.out.println("\tjump "+l3);
        System.out.println(l2+":");

        n.stmt2.accept(this);

        System.out.println(l3+":");

    }
    else{ // if without else

      System.out.println(l2+":");

    }

  }

  // formal arg node visitor
  public void visit(FormalArg n){/* do nothing */};

  // id node visitor
  public String visit(ID n){
    String ir = "\t";

    if(n.t != "none"){ //check type
      switch(n.t){
        case "real":
          tmp = fp.toString();
          ir += tmp + " <- r_";
          fp.inc();
          break;
        default:
          tmp = t.toString();
          ir += tmp + " <- i_";
          t.inc();
          break;
      }

      switch(n.kind){ //check variable kind
        case "arg":
          ir += "aload ";
          break;
        case "local":
          ir += "lload ";
          break;
        case "var":
          ir += "gload ";
          break;
      }

      ir += "@" +n.id.replace("\"", "");
      System.out.println(ir);

    }

    return tmp;

  }

  // integer literal node visitor
  public String visit(IntLit n){
    tmp = t.toString();
    String ir = "\t"+tmp+ " <- "+ "i_value "+n.i;
    t.inc();
    System.out.println(ir);
    return tmp;
  }

  // real node vistor
  public String visit(RealLit n){
    tmp = fp.toString();
    String ir = "\t"+tmp+ " <- "+ "r_value "+n.r;
    fp.inc();
    System.out.println(ir);
    return tmp;
  }

  // while statement node visitor
  public void visit(While n){
    String l1 = l.toString();
    l.inc();
    String l2 = l.toString();
    l.inc();
    String l3 = l.toString();
    l.inc();

    System.out.println(l1+":");

    tmp = n.exp.accept(this);

    /*if(n.exp instanceof Ge){
      System.out.println("\tcjump "+tmp +", " + l3 +", "+ l2);
    }
    else{
      System.out.println("\tcjump "+tmp +", " + l2 +", "+ l3);
    }*/

    System.out.println("\tcjump "+tmp +", " + l2 +", "+ l3);

    System.out.println(l2+":");

    n.stmt.accept(this);

    System.out.println("\tjump "+l1);
    System.out.println(l3+":");

  }

  // print node visitor
  public void visit(Print n){
    String ir = "";

    switch(n.exp.t){ //check type
      case "real":
        ir = "r_print ";
        break;
      case "int":
        ir = "i_print ";
        break;
      case "bool":
        ir = "b_print ";
        break;
    }

    n.exp.accept(this);

    ir = "\t"+ ir + tmp;

    System.out.println(ir);

  }

  // or node visitor
  public String visit(Or n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);
    //System.out.println("Result1 : "+t.toString());
    tmp = n.e2.accept(this);
    //System.out.println("Result2 : "+t.toString());
    tmps.addElement(tmp);
    tmps.addElement(t.toString());
    t.inc();

    ir = " <- i_or ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;

  }

  // and node visitor
  public String visit(And n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());
    t.inc();

    ir = " <- i_and ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;

  }

  // lesser than node visitor
  public String visit(Lt n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());

    t.inc();

    ir = " <- i_lt ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  // lesser and equal than node visitor
  public String visit(Le n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());
    t.inc();
    ir = " <- i_le ";

    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  // greater than node visitor
  public String visit(Gt n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());

    t.inc();

    ir = " <- i_lt ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(1)+", " + tmps.elementAt(0);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  // greater and equal than node visitor
  public String visit(Ge n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());
    t.inc();

    //ir = " <- i_lt ";
    ir = " <- i_ge ";

    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }


  // less and equal than node visitor
  public String visit(Eq n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);

    tmps.addElement(t.toString());
    t.inc();

    ir = " <- i_eq ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  public String visit(Neq n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e1.accept(this);
    tmps.addElement(tmp);

    tmp = n.e2.accept(this);
    tmps.addElement(tmp);


    tmps.addElement(t.toString());
    t.inc();

    ir = " <- i_ne ";


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  public String visit(Plus n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);
        //System.out.println(tmp);
        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- r_add ";

        tmps.addElement(fp.toString());
        fp.inc();
        break;
      default:
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);

        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- i_add ";

        tmps.addElement(t.toString());
        t.inc();
        break;
    }


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  public String visit(Minus n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);
        //System.out.println(tmp);
        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- r_sub ";
        tmps.addElement(fp.toString());
        fp.inc();
        break;
      default:
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);

        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- i_sub ";
        tmps.addElement(t.toString());
        t.inc();
        break;
    }


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  public String visit(Times n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);
        //System.out.println(tmp);
        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- r_mul ";
        tmps.addElement(fp.toString());
        fp.inc();
        break;
      default:
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);

        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- i_mul ";
        tmps.addElement(t.toString());
        t.inc();
        break;
    }


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;

  }

  public String visit(Div n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);
        //System.out.println(tmp);
        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- r_div ";
        tmps.addElement(fp.toString());
        fp.inc();
        break;
      default:
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);

        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- i_div ";
        tmps.addElement(t.toString());
        t.inc();
        break;
    }


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;
  }

  public String visit(Mod n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);
        //System.out.println(tmp);
        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- r_mod ";
        tmps.addElement(fp.toString());
        fp.inc();
        break;
      default:
        tmp = n.e1.accept(this);
        tmps.addElement(tmp);

        tmp = n.e2.accept(this);
        tmps.addElement(tmp);
        ir = " <- i_mod ";
        tmps.addElement(t.toString());
        t.inc();
        break;
    }


    ir = "\t"+ tmps.elementAt(2) + ir + tmps.elementAt(0)+", " + tmps.elementAt(1);

    tmp = tmps.elementAt(2);

    System.out.println(ir);

    return tmp;

  }

  public String visit(Not n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e.accept(this);
        tmps.addElement(tmp);

        tmps.addElement(fp.toString());
        fp.inc();

        ir = " <- r_not ";
        break;
      default:
        tmp = n.e.accept(this);
        tmps.addElement(tmp);
        tmps.addElement(t.toString());
        t.inc();

        ir = " <- i_not ";
        break;
    }

    ir = "\t"+ tmps.elementAt(1)+ ir + tmps.elementAt(0);

    tmp = tmps.elementAt(1);

    System.out.println(ir);

    return tmp;

  }

  public String visit(Inv n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    switch(n.t){ //check type
      case "real":
        tmp = n.e.accept(this);
        tmps.addElement(tmp);
        tmps.addElement(fp.toString());
        fp.inc();

        ir = " <- r_inv ";
        break;
      default:
        tmp = n.e.accept(this);
        tmps.addElement(tmp);
        tmps.addElement(t.toString());
        t.inc();

        ir = " <- i_inv ";
        break;
    }

    ir = "\t"+ tmps.elementAt(1)+ ir + tmps.elementAt(0);

    tmp = tmps.elementAt(1);

    System.out.println(ir);

    return tmp;
  }

  public String visit(ToReal n){
    String ir;
    Vector<String> tmps = new Vector<String>();

    tmp = n.e.accept(this);
    tmps.addElement(tmp);
    tmps.addElement(fp.toString());
    fp.inc();
    ir = " <- itor ";

    //tmp = tmps.elementAt(1);
    ir = "\t"+ tmps.elementAt(1)+ ir + tmps.elementAt(0);

    tmp = tmps.elementAt(1);

    System.out.println(ir);

    return tmp;

  }

}
