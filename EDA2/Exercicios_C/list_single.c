/*
  ########################################################
 ##### Exercicios EDAII - Listas simplesmente ligadas #####
  ########################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "list.h"

typedef struct Node{                 // nó de uma lista ligada para qualquer tipo de dados
	
	int elem;         //um elemento inteiro
	struct Node *next;       //O proximo nó na lista

} Node;

typedef struct LinkedList{                    //uma lista simplesmente ligada de nós

	struct Node *head;
	int size;

} LinkedList;

//cria e inicializa uma nova lista ligada 
LinkedList *list_new(){    //aloca e inicializa a lista com NULL's 
	
	LinkedList *list = malloc(sizeof(LinkedList)); //aloca o espaco necessario para a lista 
	
	// inicializa a lista com tamanho 0 e null na cabeca
	list -> head = NULL;
	list -> size = 0;
	
	return list;
}

//cria e inicializa um novo nó
Node *node_new(){
	Node *node = malloc(sizeof(Node));
	node -> next = NULL;
	return node;
}

//verifica se a lista está vazia
bool list_empty(LinkedList *list){
	return (list -> size) == 0;
}

//insere um elemento à cabeça da lista
bool list_insert(LinkedList *list, int value){
	Node *node = node_new();
	node -> elem = value;  
	
	// insere no inicio da lista, a cabeça passa a ser o novo no
	node -> next = list -> head;
	list -> head = node;
	list -> size++;
	return true;
}

// insere no fim da lista
bool list_insertEnd(LinkedList *list, int value){
	Node *node, *tmp;

	node = node_new();
	node -> elem = value;  

	// coloca a cabeca num nó temporario
	tmp = list -> head;

	if(list -> head == NULL){
		// se a lista estiver vazia a cabeca passa a ser o elemento que se prentende inserir
		list -> head = node;
		list -> head -> next = NULL;  
		list -> size++;
		
		return true;
	}
	else{

		// percorre a lista ate ao fim.
    	while(tmp -> next != NULL)
			tmp = tmp -> next;

		// insere no fim da lista
		node -> next = NULL;
		tmp -> next = node;
		list -> size++;
		return true;
	}	
	return false;
}

// remove um elemento da lista
bool list_remove(LinkedList *list, int value){
	Node *previous, *current;
	current = list -> head;
	
	while(current != NULL && current -> elem != value){
		//enquanto nao for encontrado o elemento continua a pesquisa
		previous = current;
		current = current -> next;
	}

	if (list -> size != 0 && current != NULL){
		/* se o valor se encontrar na posicao 0, ou seja,
		 se estiver à cabeca é removido*/
		if(current == list -> head){
			list -> head = current -> next;
		}
				
		/*caso o valor se encontrar no elemento actual e 
		este nao seja a cabeca*/
		else{
			previous -> next = current -> next;	
			/*o elemento anterior ao actual passa a estar 
			ligado ao seguinte e o actual e removido */
		}	
		list -> size--;
		free(current);
		return true;
	}
	
	return false;
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

	for(i=0; i<n; i++){
		current = current -> next;
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
	printf("\nCabeca: %d\n", list -> head -> elem);
	
	printf("Tamanho: %d\n\n", list_length(list));
	printf("%d\n", list_empty(list));

	printf("Valor: %d Posicao: %d \n\n", 6, list_find(list, 6));
	printf("%d\n", list_nth(list, 2));

	list_destroy(list);
}

