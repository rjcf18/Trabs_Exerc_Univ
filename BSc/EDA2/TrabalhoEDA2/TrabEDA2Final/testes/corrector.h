#include "list.h"
#include "hashTableDisc.h"
#define TAMMAXPALAVRA 28
#define CAPACIDADE 2400019 // num. primo
#define NUMBLOCOS 18750 // 850021/128 = 6641 aprox
#define SIZEHT (128)  //4096/32 = 128 aproxx
#define MAXERROS 110017

char lowerCs[TAMMAXPALAVRA];

struct erro{
	char palavra[TAMMAXPALAVRA];
	LinkedList *linhas;
	int ocorrencias;
	bool usado;
};

typedef struct erro Erro;

struct listErros{
	Erro *ers;
};

typedef struct listErros listErros;

listErros* new_listErros();
void destroy_listErros(listErros*);
Erro* new_erro(char*, int);
void destroy_erro(Erro*);
int actualiza_erro(char*, int, int, listErros*);
bool find_word(char*, int, HashTable*);
int funcComp(const void *, const void *);
int choose_min(int, int);
bool isAllLower(char*);
void print_erros(int, int, listErros*);
