 #!/bin/bash

PARSER = LinearAST

JAVAC = javac -classpath $(CLASSPATH)
JAVA = java -classpath $(CLASSPATH)
YACC = $(CUP) -expect 1 -parser $(PARSER) -nosummary
LEX = jflex -q
#FILES = $(wildcard ../examples/*.ast)

CUP = cup
# or
# CUP = java -classpath $(CUP_JAR) java_cup.Main
CUP_JAR = /usr/share/java/cup.jar

CLASSPATH = $(CUP_JAR):

$(PARSER).class : $(PARSER).java Yylex.java
	$(JAVAC) $^

$(PARSER).java sym.java : astParser.cup
	@echo "* ignore all messages regarding non used terminals" >&2
	$(YACC) $^

Yylex.java : astLexer.jflex
	$(LEX) $^


run : $(PARSER).class
	@$(JAVA) $(PARSER)

FILES = $(shell ls examples/*.ast)

run-all : $(PARSER).class
	@echo 'Generating IR for all examples...'
	@$(foreach file,$(FILES), $(JAVA) $(PARSER) < $(file) > $(basename $(file)).ir;)
	@echo 'IR generated successfully. Check .ir files in examples folder.'

run-1 : $(PARSER).class
	@echo '[example1.ast]'
	@$(JAVA) $(PARSER) < examples/example1.ast

run-2 : $(PARSER).class
	@echo '[example2.ast]'
	@$(JAVA) $(PARSER) < examples/example2.ast

run-3 : $(PARSER).class
	@echo '[example3.ast]'
	@$(JAVA) $(PARSER) < examples/example3.ast

run-4 : $(PARSER).class
	@echo '[example4.ast]'
	@$(JAVA) $(PARSER) < examples/example4.ast

run-5 : $(PARSER).class
	@echo '[example5.ast]'
	@$(JAVA) $(PARSER) < examples/example5.ast

run-6 : $(PARSER).class
	@echo '[example6.ast]'
	@$(JAVA) $(PARSER) < examples/example6.ast

run-7 : $(PARSER).class
	@echo '[example7.ast]'
	@$(JAVA) $(PARSER) < examples/example7.ast

run-8 : $(PARSER).class
	@echo '[example8.ast]'
	@$(JAVA) $(PARSER) < examples/example8.ast

run-9 : $(PARSER).class
	@echo '[example9.ast]'
	@$(JAVA) $(PARSER) < examples/example9.ast

run-10 : $(PARSER).class
	@echo '[example10.ast]'
	@$(JAVA) $(PARSER) < examples/example10.ast

clean :
	@$(RM) $(PARSER).java $(PARSER).class 'CUP$$$(PARSER)$$actions'.class
	@$(RM) sym.java sym.class */*.class
	@$(RM) Yylex.java{,~} Yylex.class
