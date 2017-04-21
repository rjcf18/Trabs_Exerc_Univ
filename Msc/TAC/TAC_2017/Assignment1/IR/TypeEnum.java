public enum TypeEnum{
    INT("int"),
    REAL("real"),
    BOOL("bool");

    private final String type;

    TypeEnum(String type){
      this.type = type;
    }

    public String type(){
      return this.type;
    }
}
