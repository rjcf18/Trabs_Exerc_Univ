/*
  ########################################################
 ##### Exercicios EDAII - Listas simplesmente ligadas #####
  ########################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "listD.h"
#define TAM 50000

//double linked lists

typedef struct Node{                 // nó de uma lista ligada para qualquer tipo de dados

  int elem;         //um elemento inteiro
  struct Node *next;       //O proximo nó na lista
  struct Node *prev;       //O nó anterior na lista

} Node;

typedef struct LinkedList{                    //uma lista simplesmente ligada de nós

  Node *head;
  Node *tail;
  int size;

} LinkedList;

//cria e inicializa uma nova lista duplamente ligada 
LinkedList *list_new(){    //aloca e inicializa a lista com NULL's 
	
	LinkedList *list = malloc(sizeof(LinkedList)); //aloca o espaco necessario para a lista 
	
	// inicializa a lista com tamanho 0 e null na cabeca
	list -> head = NULL;
	list -> tail = NULL;
	list -> size = 0;
	
	return list;
}

//cria e inicializa um novo nó
Node *node_new(){
	Node *node = malloc(sizeof(Node));
	node -> next = NULL;
	node -> prev = NULL;
	return node;
}

//verifica se a lista esta vazia
bool list_empty(LinkedList *list){
	return list -> size == 0;  
}

//insere um elemento à cabeça da lista
bool list_insert(LinkedList *list, int value){
	Node *node;

	node = node_new();
	node -> elem = value;

	if(list -> head == NULL){
		// se a lista estiver vazia a cabeca e a cauda passam a ser
		// o nó com o elemento que se prentende inserir
		list -> head = node;
		list -> tail = node; 
		list -> size++;
		
		return true;
	}
	else{
		// insere no inicio da lista, a cabeça passa a ser o novo no
		list -> head -> prev = node;
		node -> next = list -> head;
		list -> head = node;
		list -> size++;
		return true;
	}	
	return false;
}

// remove um elemento da lista
bool list_remove(LinkedList *list, int value){
	Node *current;
	

	//começa a verificar 
	if (value < (list -> size) /2 -1){
		current = list -> head;
		//percorre a lista ate encontrar o elemento 
		while(current != NULL && current -> elem != value)
			current = current -> next;
	}
	else{
		current = list -> tail;
		//percorre a lista ate encontrar o elemento 
		while(current != NULL && current -> elem != value)
			current = current -> prev;	
	}

	if (list -> size != 0 && current != NULL){
		/* se o valor se encontrar na posicao 0, ou seja,
		 se estiver à cabeca é removido*/
		if(current == list -> head){
			current = list -> head;
			// o elemento que esta a cabeca passa a ser o proximo da cabeca
			list -> head = current -> next;
			current -> next -> prev = NULL; // o elemento a seguir a cabeca passa a ter como anterior NULL
		}
		
		/*se o valor estiver no fim da lista, ou seja,
		 se estiver na cauda é removido*/
		else if(current == list -> tail){
			current = list -> tail;
			// o elemento anterior da cauda passa a ter como proximo NULL
			current -> prev -> next = NULL;
			list -> tail = list -> tail -> prev; // a cauda passa a ser o elemento anterior a antiga cauda
		}		

		/*caso o valor se encontrar entre a cabeça e a cauda*/
		else{
			//coloca o nó anterior ao actual como anterior do proximo do actual
			current -> next -> prev = current -> prev;
				
			//coloca o nó seguinte ao actual como o seguinte do anterior do nó actual
			current -> prev -> next = current -> next;
		}	
		list -> size--;
		free(current);
		return true;
	}
	
	return false;
}

// verifica se encontra o valor na lista
int list_find(LinkedList *list, int value){
	Node *current = list -> head;
	int i = 0; // indice

	while(current != NULL){
		//se encontrar o valor no nó actual devolve a sua posicao
		// caso contrario continua a percorrer a lista
		if(current -> elem == value)
			return i;
		else{
			current = current -> next;
			i++;
		}
	}
	return -1;
}

// devolve o tamanho da lista
int list_length(LinkedList *list){
    return list -> size;
}

// imprime uma representação da lista para a consola
void list_print(LinkedList *list){
	Node *current = list -> head;

	printf("[");
	
	//percorre a lista ate ao fim imprimindo cada elemento
	while(current!=NULL){
		
		printf("%d", current -> elem);
		
		if (current -> next != NULL){
			printf(" ");	
		}
		
		current = current -> next;
	}
	
	printf("]");
}

// liberta todo o espaço em memória ocupado pela lista 
void list_destroy(LinkedList *list){
	Node *current = list -> head;
	//liberta a memoria de cada no da lista
	while(current -> next != NULL){
		free(current);
		current = current -> next;
	}
	free(current);

	//liberta a memoria da lista
	free(list);
}

// pesquisa o n-ésimo elemento da lista
int list_nth(LinkedList *list, int n){
	Node *current = list -> head;
	int i = 0; // indice

	/*comeca a verificar a partir da cabeça
	  ou da cauda de acordo com o n*/
	if (n < (list -> size) /2 -1){
		current = list -> head;

		//percorre a lista ate encontrar o elemento 
		for(i=0; i<n; i++)
			current = current -> next;
		
	}
	else{
		current = list -> tail;

		//percorre a lista ate encontrar o elemento 
		for(i=n-1; i>=0; i--)
			current = current -> prev;
	}

	return current -> elem;	
}

// testes para verificar se faz tudo bem
void teste(){
	LinkedList *list = list_new();
	printf("%d\n", list_empty(list));
	
	list_insert(list, 5);
	list_insert(list, 2);
	list_insert(list, 4);
	list_insert(list, 7);
	list_remove(list, 4);
	
	list_print(list);
	printf("Cabeca: %d\n", list -> head -> elem);
	
	printf("Tamanho: %d\n\n", list_length(list));
	printf("%d\n", list_empty(list));

	printf("Valor: %d Posicao: %d \n\n", 2, list_find(list, 2));
	printf("%d\n", list_nth(list, 2));

	list_destroy(list);
	//list_print(list);
}

int main(){
	//teste();
	LinkedList *list = list_new();
	int i;
	for (i = 0; i < TAM; i++)
		list_insert(list, i+1);

	//demora aprox 4.8 segundos a pesquisar todos os elementos da lista 
	for (i = 0; i < TAM; i++)
		list_nth(list, i);
	list_destroy(list);
	//list_print(list);
	return 0;
}
