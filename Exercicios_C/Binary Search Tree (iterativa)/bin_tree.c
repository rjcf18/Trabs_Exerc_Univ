/*
  ###############################################
 ##### Exercicios EDAII - Arvores binarias   #####
  ###############################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "bintree.h"

typedef struct TNode { // no de uma arvore binaria
	int elem;

	// filhos direito e esquerdo
	struct TNode *right, *left; 
} TNode;

typedef struct BinTree{ // arvore binaria com uma raiz
	TNode *root;
	int size;
} BinTree;

//cria e inicializa um novo nó
TNode *node_new(){
	TNode *node = malloc(sizeof(TNode));
	node -> right = NULL;
	node -> left = NULL;
	return node;
}

//cria e inicializa uma arvore
BinTree *tree_new(){
	BinTree *tree = malloc(sizeof(BinTree));
	tree -> root = NULL;
	tree -> size = 0;
	return tree;
}

//verifica se a arvore esta vazia
bool tree_empty(BinTree *tree){
	return tree -> root == NULL;
}

//insere um elemento na arvore
bool tree_insert(BinTree *tree, int value){
	TNode *tmp, *current; 

	tmp = NULL; 
	current = tree -> root;

	if (!(tree -> root)){
		tree -> root = node_new();
		tree -> root -> elem = value;
		tree -> size++;
		return true;
	}
	
	while(current){
		tmp = current;
		if (value < current -> elem)
			current = current -> left;
		else
			current = current -> right; 
	}

	current = node_new();
	current -> elem = value;

	if (value < tmp -> elem)
		tmp -> left = current;
	
	else if (value > tmp -> elem)
		tmp -> right = current;	
	
	tree -> size++;
	return true;
}

//pesquisa um elemento na arvore
bool tree_find(BinTree *tree, int value){
	TNode *tmp, *current; 

	tmp = NULL; 
	current = tree -> root;

	if (!current){
		return false;
	}
	
	while(current){
		tmp = current;
		if (value < current -> elem)
			current = current -> left;
		else if(value > current -> elem)
			current = current -> right; 
		else
			return true;
	}
}

//remove um elemento na arvore
bool tree_remove(BinTree *tree, int value){

	TNode *node, *prev, *tmp, *tmp2;

	prev = NULL;
	node = tree -> root;

	if (!node){
		return false;
	}

	while((node -> elem != value) && node != NULL){
		
		if(value < node-> elem){
			prev = node;
			node = node -> left;
		}
		
		else if(value > node-> elem){
			prev = node;
			node = node -> left;
		}	
	}

	/* se o no a remover não for uma folha, ha que 
	 garantir que a arvore fique em equilibrio, 
	 ou seja, que o menor elemento na sub arvore direita 
	 passe a estar no sitio onde o no foi removido */

	if((node->left) != NULL && (node->right) != NULL){
		tmp = node->right;
		prev = node;
		while((tmp->left) != NULL)
		{
			prev = tmp;	
			tmp = tmp->left;
		}
		node->elem = tmp->elem;
		node = tmp;
	}
	tmp2 = node->left;

	if(tmp2 == NULL)
		tmp2 = node->right;
	
	if(prev == NULL)
		tree -> root = tmp2;
	
	else if(prev->left == node)
		prev->left = tmp2;
	
	else
		prev->right = tmp2;
	
	tree -> size--;
	free(node);
	return true;	
		
}

void tree_printAux(TNode *node, int level){
	int i;
 
	if (node == NULL) {
		return;
	}
 
	tree_printAux(node->right, level+1);
 
	for (i = 0; i < level; i++)
		printf ("   ");

	printf("%d\n\n", node->elem);
	
	tree_printAux(node->left, level+1);  
}

void tree_print(BinTree *tree){
	tree_printAux(tree -> root, 0);
}

// calcula o numero de nos da arvore
int tree_size(BinTree *tree){
	return tree -> size;
}

//recebe 2 numeros como arg e devolve o maior desses 2
int max(a, b){
	if (a > b)
		return a;
	else
		return b;
}

// calcula a altura da arvore recursivamente
int tree_heightAux(TNode *node) {
	if (node == NULL)
		return 0;
	return 1 + max(tree_heightAux(node-> left), tree_heightAux(node-> right));
}

int tree_height(BinTree *tree){
	tree_heightAux(tree -> root);
}

//liberta todo o espaço ocupado em memoria pela arvore
void tree_destroyAux(TNode *node){
	if (node != NULL){
		tree_destroyAux(node -> left);
		tree_destroyAux(node -> right);
		free(node);
	}
}

void tree_destroy(BinTree *tree){
	tree_destroyAux(tree -> root);
	free(tree);
}
