#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "grafo.h"
#define MAXV 100000
#define WHITE -1
#define INFINITY -1

//cria um novo no
No* New_No(int v, No* next) {
	No* x = malloc(sizeof(No));
	x->v = v;
	x->next = next; 
	x->color = WHITE;
	x->dist = INFINITY;

	return x;
}

// inicializa um novo grafo com v nos
Grafo *New_Grafo(int v) {
	Grafo *g = malloc(sizeof(Grafo));
	g->numV = v; 
	g->numA = 0;
	g->adj = malloc(v * sizeof(No));

	return g;
}

//desaloca a memoria ocupada pelo grafo
void Grafo_destroy(Grafo *g){
	int n;
	No* l;
	No* tmp;

    for(n=1; n<=g->numV; n++){
    	l = g->adj[n];
    	tmp = l->next;
    	while(tmp!=NULL)
	    {
	       	tmp = l->next;
	    	free(l);
	    	l = tmp; 
	    }
	    free(l);	
    }
    
	//free(g->adj[0]);
	free(g->adj);
	free(g);
}

// insere uma aresta de v a w no grafo g
void Grafo_insere_A(Grafo *g, int v, int w) {
	g->adj[v] = New_No(w, g->adj[v]);
	g->adj[w] = New_No(v, g->adj[w]); 
	g->numA++;
}

//remove uma aresta de v a w do grafo g
void Grafo_remove_A(Grafo *g, int v, int w){
	free(g->adj[v]);
	free(g->adj[w]);
	g->numA--;
}
