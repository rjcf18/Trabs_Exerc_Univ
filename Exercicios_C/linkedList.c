/*
  ########################################################
 #####     Exercicios EDAII - linked lists header     #####
  ########################################################
 */

#include <linkedList.h>

LinkedList list_new(){    //allocate and initialize to NULL values
	struct LinkedList *list;
	list = Malloc(sizeof(struct list)); //aloca o espaco necessario para a lista 
	
	// inicializa a lista com tamanho 0 e nulls na cabeca e na cauda
	list -> head = NULL;  
	list -> tail = NULL;
	list -> size = 0;
	
	return list;
}

int main(){
	return 0;
}