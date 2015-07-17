#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "grafo.h"
#include "queue.h"
#define MAXV 100000
#define WHITE -1
#define GREY 0
#define BLACK 1
#define INFINITY -1

//pesquisa em largura - descobre o caminho mais curto 
void bfs(Grafo *G, int s) {
	No* t;
	int v, w;
	queue *q = new_queue(TAMQMAX);

	G->adj[s]->dist = 0;  //dist do vertice inicial ao final
	G->adj[s]->color = GREY;
	enqueue(q, s);

	while (!isEmpty(q)) {
		v = dequeue(q);
		G->adj[v]->color = BLACK; //processado

		for (t = G->adj[v]; t != NULL; t = t->next) {
			w = t->v;
			if (G->adj[w]->color == WHITE) {
				G->adj[w]->color = GREY;  // visitado
				G->adj[w]->dist = G->adj[v]->dist +1;
				enqueue(q, w);
			}
		}
	}
	
	queue_destroy(q);
}


int main(void)
{
	
	int i, numVert, numArestas, origem, destino;
	//FILE *input = fopen("estradas.txt", "r");
	int sc = 0;
	int sc2 = 0;
	
	sc = fscanf(stdin, "%d\n",&numVert);
	sc2 = fscanf(stdin, "%d\n", &numArestas);
	
	if(numArestas > 300000 || numArestas < 0 || numVert > 100000 || numVert < 1 || sc == EOF || sc2 == EOF){
		return 0;	
	}

	Grafo *g = New_Grafo(numVert);

	for(i = 0; i < numArestas; i++)
	{
		sc = fscanf(stdin, "%d %d\n", &origem, &destino);
		if(sc == EOF || origem > g->numV || origem < 1 || destino > g->numV || destino < 1 || origem == destino){
			Grafo_destroy(g);
			return 0;	
		}
		Grafo_insere_A(g, origem, destino);	
	}

	int start, end;
	sc = fscanf(stdin, "%d %d", &start, &end);
	if(sc == EOF){
		Grafo_destroy(g);
		return 0;		
	}
	
	if(start > g->numV || start < 1 || end > g->numV || end < 1 ){
		Grafo_destroy(g);
		return 0;		
	}	

	bfs(g,start);

	int d = g->adj[end]->dist;

	printf("%d\n", d);

    Grafo_destroy(g);

	return 0;
}


