#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "list.h"
#define TAM 60000

int main(){
	//teste();
	LinkedList *list = list_new();
	int i;
	for (i = 0; i < TAM; i++)
		list_insert(list, i+1);

	//demora aprox 2.4 segundos a pesquisar todos os elementos da lista 
	for (i = 0; i < TAM; i++)
		list_nth(list, i);
	list_destroy(list);
	
	//list_print(list);
	return 0;
}
