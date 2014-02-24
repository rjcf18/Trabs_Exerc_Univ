/*
  ########################################################
 ##### Exercicios EDAII - Listas simplesmente ligadas #####
  ########################################################
 */

#include "listS.h"
#define TAM 50000

LinkedList *list_new(){    //aloca e inicializa a lista com NULL's 
	
	LinkedList *list = malloc(sizeof(LinkedList)); //aloca o espaco necessario para a lista 
	
	// inicializa a lista com tamanho 0 e null na cabeca
	list -> head = NULL;
	list -> size = 0;
	
	return list;
}


bool list_empty(LinkedList *list){
	int size;
	size =  list -> size;  
	if(size == 0)
		return true;
	else
		return false;
}

bool list_insert(LinkedList *list, int value){
	Node *node;

	node = malloc(sizeof(struct Node));
	node -> elem = value;  

	if(list -> head == NULL){
		// se a lista estiver vazia a cabeca passa a ser o elemento que se prentende inserir
		list -> head = node;
		list -> head -> next = NULL;  
		list -> size++;
		
		return true;
	}
	else{

		// insere no inicio da lista, a cabeça passa a ser o novo no
		node -> next = list -> head;
		list -> head = node;
		list -> size++;
		return true;
	}	
	return false;
}

bool list_remove(LinkedList *list, int value){
	Node *previous, *current;
	current = list -> head;
	
	while(current != NULL){

		if(current -> elem == value){
			// se o valor se encontrar na posicao 0, ou seja, se estiver à cabeca
			// é removido e a cabeca passa a ser o elemento a seguir 
			if(current == list -> head){
				list -> head = current -> next;
				list -> size--;
				free(current);
				return true;
			}
			
			//caso o valor se encontrar no elemento actual e este nao seja a cabeca
			// o elemento anterior ao actual passa a estar ligado ao seguinte e o actual e removido  
			else{
				previous -> next = current -> next;
				list -> size--;
				free(current);
				return true;
			}
		}

		//enquanto nao for encontrado o elemento continua-se a procurar o seguinte 
		else{
			previous = current;
			current = current -> next;
		}
	}
	return false;
}

int list_length(LinkedList *list){
	// devolve o tamanho da lista
	int size = list -> size;
    return size;
}

void list_print(LinkedList *list){
	Node *current = list -> head;

	if(current == NULL){
		// se a cabeca for NULL significa que a lista esta vazia
		printf("\nA lista esta vazia.");
	}
	
	else{
		printf("\n[");
		//percorre a lista ate ao fim para imprimindo o elemento actual e passando para o proximo
		while(current!=NULL){
			printf(" %d ", current -> elem);
			current = current -> next;
		}
		
		printf("]\n");
	}
}

int list_find(LinkedList *list, int value){
	Node *current = list -> head;
	int i = 0; // indice

	if(current == NULL){
		// se a cabeca for NULL significa que a lista esta vazia
		return -1;
	}	

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
	// se tiver percorrido a lista e nao tiver encontrado o elemento
	// é porque nao o contem logo devolve -1
	return -1;
}

void list_destroy(LinkedList *list){
	free(list);	
}

int list_nth(LinkedList *list, int n){
	Node *current = list -> head;
	int i = 0; // indice

	if (n < 0 || n > (list -> size)-1 || current == NULL){
		printf("\nIndice invalido!!\n");
		return -1;
	}

	while(current != NULL){
		//se encontrar o valor no nó actual devolve a sua posicao
		// caso contrario continua a percorrer a lista
		if (i == n)
			return current -> elem;
		current = current -> next;
		i++;
	}	
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
	list_print(list);
}

int main(){
	//teste();
	LinkedList *list = list_new();
	int i;
	for (i = 0; i < TAM; i++)
		list_insert(list, i+1);

	//demora aprox 5 segundos a pesquisar todos os elementos da lista 
	for (i = 0; i < TAM; i++)
		list_nth(list, i);
	list_destroy(list);
	//list_print(list);
	return 0;
}
