public enum KindEnum{
    VAR("var"),
    ARG("arg"),
    LOCAL("local");

    private final String type;

    TypeEnum(String type){
      this.type = type;
    }

    public String type(){
      return this.type;
    }
}
