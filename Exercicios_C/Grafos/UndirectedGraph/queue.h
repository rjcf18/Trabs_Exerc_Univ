#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define TAMQMAX 100

struct queue{
    int *q;             // conteudo da queue
    int primeiro;       // posicao do primeiro elemento 
    int ultimo;         // posicao do ultimo elemento 
    int numElem;        // numero de elementos da queue 
};

typedef struct queue queue;

queue* new_queue();
void queue_destroy(queue*);
void enqueue(queue*, int);
int dequeue(queue*);
bool isEmpty(queue*);
