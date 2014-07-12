#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#define TAMQUEUE 100
#define maxVert 100000
#define WHITE -1
#define GREY 0
#define BLACK 1

static int antecessores[maxVert];	// relacoes dos vertices encontrados 

void init_pesquisa(grafo *g)
{
    int i;                          

   	for (i = 1; i <= g->numV; i++){
		g->verts[i] = new_vertice(i);
		antecessores[i] = -1;
    }
}

void vertice_processado(int v)
{
	printf("vertice processado: %d\n",v);
}

void bfs(grafo *g, int start)
{
	queue* q = new_queue();		// fila de vertices a visitar
	int v;				// vertice actual
	int i;				// inc
	
	enqueue(q,start);
	g->verts[start]->cor = GREY;

	while (isEmpty(q) == false) {
		v = dequeue(q);
		//vertice_processado(v);
		g->verts[v]->cor = BLACK; //black
		
		for (i=1; i<=g->numV; i++){
			if (g->adj[v][i] == true){
				
				if (g->verts[i]->cor == WHITE) {
					g->verts[i]->cor = GREY; //grey
					antecessores[i] = v;
					enqueue(q,i);			
				}
			}
		}

	}
	queue_destroy(q);
}

void mostra_caminho(int start, int end, int antecessores[])
{
	if ((start == end) || (end == -1))
		printf("\n%d",start);
	else {
		mostra_caminho(start,antecessores[end],antecessores);
		printf(" %d",end);
	}
}

int main(void)
{
	
	int i, numVert, numArestas, origem, destino;

	int sc = 0;
	int sc2 = 0;
	
	sc = fscanf(stdin, "%d\n",&numVert);
	sc2 = fscanf(stdin, "%d\n", &numArestas);
	
	if(numArestas > 300000 || numArestas < 0 || numVert > 100000 || numVert < 1 || sc == EOF || sc2 == EOF){
		return 0;	
	}

	grafo* g = new_grafo(numVert);
	
	//print_grafo(g);
	for(i = 0; i < numArestas; i++)
	{
		sc = fscanf(stdin, "%d %d\n", &origem, &destino);
		if(sc == EOF || origem > g->numV || origem < 1 || destino > g->numV || destino < 1 || origem == destino){
			destroy_grafo(g);
			return 0;	
		}	
		grafo_insert_a(g, origem, destino);
	}

	int start, end;
	sc = fscanf(stdin, "%d %d", &start, &end);
	if(sc == EOF){
		destroy_grafo(g);
		return 0;		
	}
	
	if(start > g->numV || start < 1 || end > g->numV || end < 1 ){
		destroy_grafo(g);
		return 0;		
	}	

	//print_grafo(g);
	init_pesquisa(g);
	bfs(g,start);
	
	int inc = 0;
	int tmp = end;	
	while(tmp != start){
		inc++;
		tmp = antecessores[tmp];
	}
	
	printf("%d\n", inc);

    destroy_grafo(g);

	return 0;
}


