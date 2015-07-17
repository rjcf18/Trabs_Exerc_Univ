/*
  ########################################################
 ##### Exercicios EDAII - Listas simplesmente ligadas #####
  ########################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include "list.h"
#define NIL 0            // os nós são 1, 2, 3, ...

/* Cabeçalho de uma lista */

struct header {
  int head;              // cabeça da lista
  int used;              // número de nós já usados
  int free;              // cabeça da lista dos nós livres
};

/* Lista */

struct list {
  int fd;                // descritor do ficheiro onde a lista reside
  struct header header;  // cabeçalho da lista
};

/* Nó */

struct node {
  int element;           // elemento
  int next;              // próximo nó da lista
};

/*int read_header(struct *list, ssize_t bytes){
	read(fd, &, bytes);
}*/

struct list *list_open(char *name) {
	
	struct list *lst = malloc(sizeof(struct list));
	lst->fd = open(name, O_RDWR|O_CREAT, S_IRUSR | S_IWUSR);

	//lê os bytes do header da lista no ficheiro 
	//para o endereço de memória do header da lista
	read(lst->fd, &lst->header, sizeof(lst->header));	
	return lst;

}

int main(){
	struct list *lst = list_open("cena.dat");
	

	return 0;
}























