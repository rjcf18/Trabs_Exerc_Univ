default: 
	gcc -std=gnu99 -Wall pesquisa_grafo.c grafo.c queue.c

valgrind:
	valgrind ./a.out --track-origins=yes --leak-check=full --show-leak-kinds=all --tool=memcheck

gdb:
	gdb ./a.out

execute:
	./a.out

pesq_grafo:
	gcc -std=gnu99 -Wall pesq_grafo.c

#to execute pesq_grafo redirect file to stdin ->    make exe_pesq F =file
exe_pesq:
	./a.out < $(F)

clean:	
	rm -rf *~


