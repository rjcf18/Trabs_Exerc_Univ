CC = gcc
CFLAGS = -g 
OUTFILE = vspl
LIBS = -lm


all: parser.c lexer.c
	$(CC) $(CFLAGS) parser.c lexer.c -o $(OUTFILE) $(LIBS)

parser.c: vspl.y
	bison -y -d vspl.y -o parser.c

lexer.c: vspl.lex
	flex -o lexer.c vspl.lex

run: $(OUTFILE)
	./$(OUTFILE)

runtests: $(OUTFILE)
	@echo ——————Correr ficheiros de teste———————
	@echo ——————————————————————sum.vspl————————————————————————
	./$(OUTFILE) < exemplos_vspl_corrigidos/sum.vspl
	@echo ——————————————————————fact.vspl———————————————————————
	./$(OUTFILE) < exemplos_vspl_corrigidos/fact.vspl
	@echo ——————————————————————acker.vspl——————————————————————
	./$(OUTFILE) < exemplos_vspl_corrigidos/acker.vspl
	@echo ————————————————————qsort-rec.vspl————————————————————
	./$(OUTFILE) < exemplos_vspl_corrigidos/qsort-rec.vspl

clean: 
	rm -rf parser.c lexer.c parser.h
	rm -f *~
	rm -f *.o
	rm -f vspl