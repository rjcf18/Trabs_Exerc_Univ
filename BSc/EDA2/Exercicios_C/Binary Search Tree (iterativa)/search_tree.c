/*
  ###############################################
 ##### Exercicios EDAII - Arvores binarias   #####
  ###############################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "bintree.h"
#define TAM 60000

int main() {
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
	printf("%d\n", tree_insert(tree, 4));
	printf("%d\n", tree_remove(tree, 5));
	printf("%d\n", tree_size(tree));
	printf("%d\n", tree_find(tree, 5));
	tree_print(tree);
	tree_destroy(tree);
	*/
	/*int i;
	for (i = 0; i < TAM; i++)
		tree_insert(tree, i+1);

	//demora aprox 11 segundos a pesquisar todos os elementos da lista 
	for (i = TAM; i >= 1; i--)/
		tree_find(tree, i);
	*/
	tree_insert_balanced(tree, 1, 49999);
	tree_print(tree);
	tree_destroy(tree);
	
	return 0;
}
