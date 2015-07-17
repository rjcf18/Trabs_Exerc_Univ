#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct No {
	int v; // vertice currente da lista de adjacencia
	short color;
	int dist;
	struct No *next; // proximo no na lista de adjacencia
}; 

struct Grafo {
	int numV; // num vertices
	int numA; // num arestas
	struct No **adj; // lista de adjacencia com V nos
}; 

typedef struct No No;
typedef struct Grafo Grafo;

No* New_No(int, No*);
Grafo *New_Grafo(int);
void Grafo_destroy(Grafo*);
void Grafo_insere_A(Grafo*, int, int);
void Grafo_remove_A(Grafo*, int, int); 

