#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#define maxVert 100000
 
struct vertice
{
	int v;
	char cor;
};
 
struct grafo
{
    struct vertice **verts;
    int numV;  // Num vertices
    int numA;  // Num de arestas
    bool **adj; // matriz de adjacencia
};
 
typedef struct vertice *vertice;
typedef struct grafo grafo;
typedef struct grafo grafo;

grafo* new_grafo(int v);
vertice new_vertice(int v);
bool **matriz_alloc(int linhas, int colunas, bool valor);
void grafo_insert_a(grafo* g, int v, int w);
void grafo_delete_a(grafo* g, int v, int w);
void destroy_grafo(grafo* g);
void print_grafo(grafo* g);
