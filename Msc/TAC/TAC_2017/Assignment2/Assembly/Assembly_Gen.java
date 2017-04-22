package Assembly;

import java.util.Vector;

public class Assembly_Gen implements Visitor{
  public Vector<FunDecl> functions; // function declarations

  // IR node visitor
  // Visits all the global symbol declarations and each function's instructions
  public void visit(IR n) {
    try{

      //checks if there are global variables
      for (int i = 0; i < n.g.size(); i++ ) {
        if(n.g.elementAt(i) instanceof VarDecl){
          System.out.println("\t.data");
          break;
        }
      }

      functions = new Vector<FunDecl>();

      //visits all global symbol declarations
      for (int i = 0; i < n.g.size(); i++ ) {
        n.g.elementAt(i).accept(this);
      }

      // visits all functions
      for (int i = 0; i < n.fs.size(); i++ ) {
        n.fs.elementAt(i).accept(this);
        System.out.println("");
      }

    }catch(NullPointerException e){
      e.printStackTrace();
    }
  }

  //Global variable declarations visitor
  public void visit(VarDecl n){
    if(n.value == null){ // uninitialized global variable
      System.out.println(n.id + ":  .space 4");
    }
    else{ // initialized global variable
      System.out.println(n.id + ":  .word "+n.value);
    }
  }

  //Global symbol for function declarations visitor
  public void visit(FunDecl n){
    functions.add(n);//adds the function's data in the functions vector
  }

  // function with instructions list visitor
  public void visit(Function n){
    int offset = 0 ;

    System.out.println("\n\t.text");

    if(n.id.equals("main")){
      System.out.println("\t.globl main");
    }

    System.out.println(n.id +":");

    Vector<String> args = functions.elementAt(0).formals.list;
    Vector<String> locals = functions.elementAt(0).locals.list;

    // starts -4 (locals plus the return address)
    offset = (locals.size()+1)*(-4);

    //function prologue
    System.out.println("\tsw $fp, -4($sp)"); // save caller frame pointer
    System.out.println("\taddiu $fp, $sp, -4"); // set callee frame pointer
    System.out.println("\tsw $ra, -4($fp)"); //save return address
    System.out.println("\taddiu $sp, $fp, " + offset); // allocate space for locals

    for (int i = 0; i < n.insts.size(); i++ ) {
      n.insts.elementAt(i).accept(this);
    }

    //starts 4 (arguments plus the return address)
    offset = (args.size()+1)*4;

    //function epilogue
    System.out.println("\tlw $ra, -4($fp)"); // restore return address
    System.out.println("\taddiu $sp, $fp, "+offset); // restore caller stack pointer
    System.out.println("\tlw $fp, 0($fp)"); // restore caller frame pointer
    System.out.println("\tjr $ra"); // return from function

    functions.remove(0); // remove functions' data from functions decls vector
  }

  //two operand instructions visitor (arithmetic and comparison)
  public void visit(TwoOperand n){
    switch(n.inst){
      case "i_add":
        System.out.println("\taddu " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        break;
      case "i_sub":
        System.out.println("\tsubu " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        break;
      case "i_mul":
        System.out.println("\tmult " + n.temp2 + ", " + n.temp3);
        System.out.println("\tmflo " + n.temp1 );
        break;
      case "i_div":
        System.out.println("\tdiv " + n.temp2 + ", " + n.temp3);
        System.out.println("\tmflo " + n.temp1 );
        break;
      case "mod":
        System.out.println("\tdiv " + n.temp2 + ", " + n.temp3);
        System.out.println("\tmfhi " + n.temp1 );
        break;
      case "i_eq":
        System.out.println("\tsubu " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        System.out.println("\tsltiu " + n.temp1 + ", " + n.temp1+ ", 1");
        break;
      case "i_lt":
        System.out.println("\tslt " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        break;
      case "i_ne":
        System.out.println("\tsubu " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        System.out.println("\tsltu " + n.temp1 + ", "+ "$0, " + n.temp1);
        break;
      case "i_le":
        System.out.println("\tslt " + n.temp1 + ", "+ n.temp2 + ", " + n.temp3);
        System.out.println("\txori " + n.temp1 + ", " + n.temp1+ ", 1");
        break;
    }
  }

  //one operand instructions visitor
  public void visit(OneOperand n){
    switch(n.inst){
      case "i_inv":
        System.out.println("\tsubu " + n.temp1 + ", $0, "+ n.temp2 );
        break;
      case "not":
        System.out.println("\txori " + n.temp1 + ", "+ n.temp2 + ", 1");
        break;
      case "i_copy":
        System.out.println("\taddu " + n.temp1 + ", $0, "+ n.temp2 );
        break;
    }
  }

  //Data transfer instructions visitor
  public void visit(DataTransfer n){
    Vector<String> args = functions.elementAt(0).formals.list;
    Vector<String> locals = functions.elementAt(0).locals.list;
    int offset = 0;

    switch(n.inst){
      case "i_value":
        // immediate field over 16 bits
        if(n.value >= 65536 || n.value < -32768){
          System.out.println("\tlui "+ n.temp + ", " + (n.value >> 16) );
          System.out.println("\tori "+ n.temp + ", " + n.temp + ", "+ (n.value & 65536) );
        }
        else{
          System.out.println("\tori "+ n.temp + ", $0, "+ n.value);
        }

        break;

      case "i_aload":
        offset = (args.size() - args.indexOf(n.id))*4;
        System.out.println("\tlw "+ n.temp + ", "+ offset+"($fp)");
        break;
      case "i_lload":
        offset = (locals.indexOf(n.id)+2)*(-4);
        System.out.println("\tlw "+ n.temp + ", "+ offset+"($fp)");
        break;
      case "i_gload":
        System.out.println("\tla "+ n.temp + ", "+ n.id);
        System.out.println("\tlw "+ n.temp + ", 0("+ n.temp+")");
        break;
      case "i_astore":
        offset = (args.size() - args.indexOf(n.id))*4;
        System.out.println("\tsw "+ n.temp + ", "+ offset+"($fp)");
        break;
      case "i_lstore":
        offset = (locals.indexOf(n.id)+2)*(-4);
        System.out.println("\tsw "+ n.temp + ", "+ offset+"($fp)");
        break;
      case "i_gstore":
        System.out.println("\tla $at, "+ n.id);
        System.out.println("\tsw "+ n.temp + ", 0($at)");
        break;

    }
  }

  // function and procedure call instruction visitor
  public void visit(Call n){
    for(int i = n.call_args.size()-1; i >= 0 ; i--){
      System.out.println("\taddiu $sp, $sp, -4");
      System.out.println("\tsw "+n.call_args.elementAt(i)+", 0($sp)");
    }

    System.out.println("\tjal " + n.id);

    if(n.temp != null){
      System.out.println("\tor "+ n.temp +", $0, $v0");
    }

  }

  // print instruction visitor
  public void visit(Print n){
    System.out.println("\t"+n.print+"$ "+n.temp);
  }

  // jump instruction visitor
  public void visit(Jump n){
    System.out.println("\tj "+n.label);
  }

  // conditional jump instruction visitor
  public void visit(Cjump n){

    System.out.println("\tbeq "+ n.temp + ", $0, "+n.label2);

    System.out.println("\tj "+n.label1);
  }

  // label visitor
  public void visit(Label n){
    System.out.println(n.label+":");
  }

  // return visitor
  public void visit(Return n){
    if(n.temp != null) //just prints if not a procedure
      System.out.println("\tor $v0, $0, " + n.temp);
  }

}
