search:
	gcc -std=gnu99 -Wall hash.c

criar_dic: 
	gcc -std=gnu99 -Wall criacao.c

valgrind_criar:
	valgrind ./a.out < $(T) --track-origins=yes --leak-check=full --show-leak-kinds=all --tool=memcheck

valgrind_search:
	valgrind ./a.out < $(T) --track-origins=yes --leak-check=full --show-leak-kinds=all --tool=memcheck

run:
	./a.out < $(F)

clean:	
	rm -rf *~
