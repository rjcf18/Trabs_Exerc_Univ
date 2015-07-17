#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "queue.h"
#define NUM_LINHAS_MAX 1000
#define TAM_MAX_LINHA 100

int processados[maxVert];	// vertices processados 
int encontrados[maxVert];  // vertices encontrados/visitados
int antecessores[maxVert];	// relacoes dos vertices encontrados 

bool fim = false;	// se for true termina a pesquisa 

void init_pesquisa(grafo *g)
{
        int i;                          

        for (i=1; i<=g->numV; i++) {
                processados[i] = encontrados[i] = 0;
                antecessores[i] = -1;
        }
}

void vertice_processado(int v)
{
	printf("vertice processado: %d\n",v);
}

void bfs(grafo *g, int start)
{
	queue* q = new_queue();			/* queue of vertices to visit */
	int v;				/* current vertex */
	int i;				/* counter */
	enqueue(q,start);
	encontrados[start] = 1;

	while (isEmpty(q) == false) {
		v = dequeue(q);
		//vertice_processado(v);
		processados[v] = 1;
		for (i=1; i<=g->numV; i++){
			if (g->adj[v][i] == 1){
				if (encontrados[i] == 0) {
				
					encontrados[i] = 1;
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




int main(int argc,char *argv[])
{
	FILE *input = fopen("estradas.txt", "r");
	int i, numVert, numArestas, origem, destino;

	if (argc!=2) 
	{
		fprintf(stderr,"\nArgumentos invalidos.");
		return 1;
	}

	if(input == NULL)
	{
		perror("Nao e possivel abrir o ficheiro especificado");
		exit(1);
    	}

	fscanf(input, "%d\n",&numVert);
	fscanf(input, "%d\n", &numArestas);
	if(numArestas > 150 || numArestas < 0 || numVert > 50 || numVert < 1){
		perror("Nao cumpre com as restricoes!!");
		exit(1);	
	}

	grafo* g = new_grafo(numVert);
	
	//print_grafo(g);

	for(i = 0; i < numArestas; i++)
	{
		fscanf(input, "%d %d\n", &origem, &destino);
		if(origem > g->numV || origem < 1 || destino > g->numV || destino < 1 ){
			perror("Nao cumpre com as restricoes!!");
			exit(1);		
		}	
		grafo_insert_a(g, origem, destino);
	}

	int start, end;
	fscanf(input, "%d %d", &start, &end);
	fclose(input);
	
	if(start > g->numV || start < 1 || end > g->numV || end < 1 ){
		perror("Nao cumpre com as restricoes!!");
		exit(1);		
	}	

	//print_grafo(g);
	init_pesquisa(g);
	bfs(g,start);
	/*
	for (i=1; i<=g->numV; i++)
		printf(" %d",antecessores[i]);
	printf("\n");*/
	
	int inc = 0;
	int tmp = end;	
	while(tmp != start){
		inc++;
		tmp = antecessores[tmp];
	}
	
	//mostra_caminho(start,end,antecessores);
	
	printf("%d\n", inc);

    	destroy_grafo(g);

	return 0;
}

