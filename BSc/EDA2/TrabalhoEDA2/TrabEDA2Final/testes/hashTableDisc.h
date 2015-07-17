#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#define TAMMAXPALAVRA 28
#define CAPACIDADE 2400019 // num. primo
#define NUMBLOCOS 18750 // 850021/128 = 6641 aprox
#define SIZEHT (128)  //4096/32 = 128 aproxx
	
struct elemento{
	char palavra[TAMMAXPALAVRA];
	int usado;
};

typedef struct elemento Elemento;

struct hashtable{
	Elemento *ht; 
};

typedef struct hashtable HashTable;

unsigned int hash(char *);
HashTable* new_HT();
void destroy_HT(HashTable*);
void carregar_bloco(HashTable*, FILE *, int);
void escreve_elem(Elemento, FILE *fd);
void criar_dic(char *,int);
bool pesquisa_Elem(char *nomeFicheiro, char *);
void insere_dados(FILE *, int, char *);