 #!/bin/bash

PARSER = IR_Parser

JAVAC = javac -Xdiags:verbose -classpath $(CLASSPATH)
JAVA = java -classpath $(CLASSPATH)
YACC = $(CUP) -parser $(PARSER) -nosummary
LEX = jflex -q
#FILES = $(wildcard ../examples/*.ast)

CUP = cup
# or
# CUP = java -classpath $(CUP_JAR) java_cup.Main
CUP_JAR = /usr/share/java/cup.jar

CLASSPATH = $(CUP_JAR):

$(PARSER).class : $(PARSER).java Yylex.java
	$(JAVAC) $^

$(PARSER).java sym.java : irParser.cup
	@echo "* ignore all messages regarding non used terminals" >&2
	$(YACC) $^

Yylex.java : irLexer.jflex
	$(LEX) $^


run : $(PARSER).class
	@$(JAVA) $(PARSER)

FILES = $(shell ls examples/*.ir2)

run-all : $(PARSER).class
	@echo 'Generating MIPS Assembly code for all examples...'
	@$(foreach file, $(FILES), $(JAVA) $(PARSER) < $(file) > $(basename $(file)).mips;)
	@echo 'MIPS Assembly code generated successfully. Check .mips files in examples folder.'


clean :
	@$(RM) $(PARSER).java $(PARSER).class 'CUP$$$(PARSER)$$actions'.class
	@$(RM) sym.java sym.class */*.class
	@$(RM) Yylex.java{,~} Yylex.class
