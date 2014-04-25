default: 
	gcc -std=gnu99 -Wall grafo_search.c grafo.c queue.c

valgrind:
	valgrind ./a.out < estradas.txt --track-origins=yes --leak-check=full --show-leak-kinds=all --tool=memcheck

gdb:
	gdb ./a.out

execute:
	./a.out < $(F)

clean:	
	rm -rf *~
