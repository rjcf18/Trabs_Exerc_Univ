#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "grafo.h"
 
// aloca o espaco necessario para a matriz de adjacencia
bool **matriz_alloc(int linhas, int colunas, bool valor)
{
    int i, j, q;
    bool **matriz =  malloc((linhas+1) * sizeof(bool*));

    for(i = 1; i<=linhas; i++)
    {
        matriz[i] = malloc((colunas+1) * sizeof(bool));
    }

    for(q = 1; q<=linhas; q++)
    {
        for(j=1; j<=colunas;j++)
        {
            matriz[q][j] = valor;
        }
    }

    return matriz;
}

void destroy_grafo(grafo* g){
    int i;
    
    for(i = 1; i<=g->numV; i++)
    {
        free(g->adj[i]);
		free(g->verts[i]);
    }

    free(g->adj);
    free(g->verts);
    free(g);
}

//cria um novo grafo alocando o espaco necessario para tal
grafo* new_grafo(int v)
{
    grafo* g = malloc(sizeof(grafo));
    g->numV = v;
    g->numA = 0;
    g->adj = matriz_alloc(v,v,false);
    g->verts = malloc((v+1) * sizeof(vertice));
    
    return g;
}

vertice new_vertice(int v)
{
    vertice vert = malloc(sizeof(vertice));
    vert->v = v;
    vert->cor = WHITE;
    
    return vert;
}
 
//insere uma aresta no grafo
void grafo_insert_a(grafo* g, int v, int w)
{
    if(g->adj[v][w] == false && g->adj[w][v] == false){
    	g->numA++;
    	g->adj[v][w]=true;
    	g->adj[w][v]=true;	
    }
}

//remove uma aresta no grafo
void grafo_delete_a(grafo* g, int v, int w)
{
    if(g->adj[v][w] == true && g->adj[w][v] == true){
    	g->numA--;
    	g->adj[v][w]=false;
    	g->adj[w][v]=false;	
    }
}
 
//print do grafo
void print_grafo(grafo* g)
{
	int i, j;

    printf("\n %d vertices, %d arestas\n",g->numV,g->numA);
    
    for(i=1;i<=g->numV;i++)
    {
        for(j=1;j<=g->numV;j++)
            printf("%2d",g->adj[i][j]);
        
        printf("\n");
    }
}
