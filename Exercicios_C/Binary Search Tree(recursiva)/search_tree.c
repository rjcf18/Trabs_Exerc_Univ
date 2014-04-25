/*
  ###############################################
 ##### Exercicios EDAII - Arvores binarias   #####
  ###############################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "bintree.h"
#define TAM 50000

int main(){
	BinTree *tree = tree_new();
	/*tree_insert(tree, 5);
	tree_insert(tree, 7);
	tree_insert(tree, 3);
	tree_insert(tree, 8);
	tree_insert(tree, 1);
	tree_insert(tree, 0);
	tree_insert(tree, 2);
	tree_insert(tree, 6);
	tree_insert(tree, 4);
	//tree_remove(tree, 6);
	printf("%d\n", tree_height(tree));
	printf("%d\n", tree_find(tree, 5));
	tree_print(tree);
	*/
	int i;
	for (i = 0; i < TAM; i++)
		tree_insert(tree, i+1);

	//demora aprox 22 segundos a pesquisar todos os elementos da lista 
	for (i = 0; i < TAM; i++)
		tree_find(tree, i);
	
	tree_destroy(tree);
	
	return 0;
}
