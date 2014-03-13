CC = gcc
CFLAGS = -g
OUTFILE = calc
LIBS = -lm


all: parser.c lexer.c
	$(CC) $(CFLAGS) parser.c lexer.c -o $(OUTFILE) $(LIBS)

parser.c: calc.y
	bison -y -d calc.y -o parser.c

lexer.c: calc.lex
	flex -o lexer.c calc.lex

clean: 
	rm -rf parser.c lexer.c parser.h
	rm -f *~
	rm -f *.o
	rm -f calc