#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include "corrector.h"
#define M 50
#define CACHESIZE 3001

//aloca a memoria necessaria para uma lista de erros
listErros* new_listErros(){
	listErros *le = malloc(sizeof(listErros));
	le->ers = malloc(sizeof(Erro)*MAXERROS);
	memset(le->ers,0,sizeof(Erro)*MAXERROS);

	return le;
}

// liberta a memoria ocupada pela lista de erros
void destroy_listErros(listErros *le){
	free(le->ers);
	free(le);
}

//aloca memoria para um novo erro e inicializa os campos
Erro* new_erro(char *palavra, int linha){
	Erro *e = malloc(sizeof(Erro));
	strcpy(e->palavra, palavra);
	e->ocorrencias = 1;
	e->linhas = list_new();
	e->usado = true;
	list_insert(e->linhas, linha); 

	return e;
}

//liberta a memoria ocupada pelo erro
void destroy_erro(Erro *e){
	list_destroy(e->linhas);
	free(e);
}

/*procura um erro, se o encontrar actualiza-o incrementando o 
  num de ocorrencias e adicionando a linha, caso nao o encontre 
  é necessario adiciona-lo */
int actualiza_erro(char *palavra, int h, int linha, listErros *le){
	int hv = h%MAXERROS;

	while(hv < MAXERROS){
		if(!le->ers[hv].usado)
		{	
			/*caso nesta posicao nao esteja nada
			 e porque o erro nao existe ainda*/
			Erro *e = new_erro(palavra, linha);
			le->ers[hv] = *e;
			le->ers[hv].usado = true;
			break; 
		}

		if(le->ers[hv].usado && strcmp(le->ers[hv].palavra, palavra) == 0)
		{
			
			if(le->ers[hv].ocorrencias < M)
				list_insert(le->ers[hv].linhas, linha);
			le->ers[hv].ocorrencias++;

			return 0; //encontrou o erro
		}
		
		hv++;
		hv %= MAXERROS;
	}

	return 1;
}

/*funcao usada para procurar uma palavra num bloco*/
bool find_word(char *string, int hashVal, HashTable *tbl)
{
	int i = 0;
	int posBloco;

	// verifica se nas posições seguintes
	// do bloco la esta a palavra
	while (i < SIZEHT)
	{
		posBloco = hashVal%SIZEHT;

		if(tbl->ht[posBloco].usado == 1 && strcmp(tbl->ht[posBloco].palavra, string) == 0)
			return true;
		hashVal++;
		i++;
	}

	return false;
}

/*funcao de comparacao usado no qsort que ordena 2 erros 
  consoante o numero de ocorrencias e o valor da string */
int funcComp(const void *p1, const void *p2)
{
    const Erro *elem1 = p1;    
    const Erro *elem2 = p2;

    if ( elem1->ocorrencias == elem2->ocorrencias){
    	if(strcmp(elem1->palavra, elem2->palavra) < 0)
    		return -1;
    	else
    		return 1;
    }

    return (elem2->ocorrencias - elem1->ocorrencias);
}

/*verifica se uma palavra esta toda em minusculas*/
bool isAllLower(char *s){
	for(int i = 0; s[i] != '\0';i++)
		if(isupper(s[i]))
			return false;

	return true;
}

/*Imprime os k erros encontrados e as respectivas ocorrencias*/
void print_erros(int e_enc, int k, listErros *erros)
{
	//int M = 0;
	int l_length = 0;
	int errosImp = 0;

	if(e_enc < k)
		errosImp = e_enc;
	else
		errosImp = k;

	for(int i = 0; i < errosImp; i++)
	{
		printf("%s (%d)", erros->ers[i].palavra, erros->ers[i].ocorrencias);
		
		//M = choose_min(erros->ers[i].ocorrencias, 50);
		l_length = list_length(erros->ers[i].linhas);

		for(int j = 0; j < l_length; j++)
			printf(" %d", list_nth(erros->ers[i].linhas, j));

		//destroy_erro(&erros->ers[i]);

		if(i != e_enc)
			printf("\n");
	}
}

int main(int argc,char *argv[]){
	char string[TAMMAXPALAVRA];
	char *line = NULL;
	int hashVal = 0, linha = 0;
	bool found = false;
	listErros *erros;
	int numBloco = -1, errosEnc = 0, k = 5;
	size_t len = 0;
	
	HashTable *cache[CACHESIZE];
	int cacheBlock[CACHESIZE];

	//inicializa a cache
	for(int i = 0; i < CACHESIZE; i++)
	{
		cache[i] = NULL;
		cacheBlock[i] = -1;
	}
	

	if(argc == 2)
		k = atoi(argv[1]);

	if(k>100000)
		k = 100000;

	erros = new_listErros();

	FILE *fd = fopen("dic.data","r+");

	Elemento ht;
	int hashblock = 0, tablePos = 0, choose = 0,hv = 0,scanVal = 0;
	const char s[2] = " ";
	char *token = NULL;
	int tokenlen = 0;
	
	while(scanVal != -1)
	{	
		if(token == NULL)
		{
			//nova linha lida
			scanVal = getline(&line, &len, stdin);
			if(scanVal == -1) break;
			token = strtok(line, s);
			linha++;
		}

		//processamento da linha
		tokenlen = strlen(token);

		//tratar o \r
		if(tokenlen == 1 && token[tokenlen-1] == 10)
		{
			token = strtok(NULL, s);
			continue;
		}

		if(token[tokenlen-1] == 10)
		{
			memcpy(string, token, tokenlen-1);
			string[tokenlen-1] = '\0';

		}
		else
		{
			memcpy(string, token, tokenlen);
			string[tokenlen] = '\0';
		}

		/*calcular o hash, o bloco onde se espera estar 
		  a palavra e o bloco da cache a procurar*/
		hashVal = hash(string);	
		hashblock = hashVal/SIZEHT;
		choose = (hashblock % CACHESIZE);
		//printf("cache block: %d\n", choose);
		tablePos = hashVal%SIZEHT;
		if(cache[choose] == NULL)
		{
			cache[choose] = new_HT();
		}

		if(hashblock != cacheBlock[choose])
		{
			carregar_bloco(cache[choose], fd, hashblock);
			cacheBlock[choose] = hashblock;
		//	printf("cache block loaded: %d\n", choose);
		}

		ht = cache[choose]->ht[tablePos];

		if(ht.usado == 0 || strcmp(ht.palavra, string) != 0){
			
			found = find_word(string, hashVal, cache[choose]);

			if(!found || tablePos == SIZEHT-1){
				carregar_bloco(cache[choose], fd, hashblock+1);
				cacheBlock[choose] = hashblock+1;
				
				//caso nao tenha sido encontrada tentar as restantes
				//posicoes do bloco
				found = find_word(string, hashVal+1, cache[choose]);
			}

			if(!found){
				//caso nao esteja no bloco tentar em lower case caso
				// a palavra nao esteja toda em lower case
				if(!isAllLower(string)){	
					//e necessario memset para evitar lixo

					memset(lowerCs,0, sizeof(char)*TAMMAXPALAVRA);

					for(int i = 0; string[i]!='\0'; i++){
						lowerCs[i] = tolower(string[i]);
					}
				  
					hv = hash(lowerCs);
					numBloco = hv/SIZEHT;
					choose = (numBloco % CACHESIZE);
			//		printf("cache block: %d\n", choose);
					tablePos = hashVal%SIZEHT;

					if(cache[choose] == NULL)
					{
						cache[choose] = new_HT();
					}

					// recarrega o bloco para a cache caso 
					// nao encontre a palavra na cache
					if(cacheBlock[choose] != numBloco)
					{
						carregar_bloco(cache[choose], fd, numBloco);
						cacheBlock[choose] = numBloco;
			//			printf("cache block loaded: %d\n", choose);
					}

					ht = cache[choose]->ht[tablePos];	
					
					if(ht.usado == 0 || strcmp(ht.palavra, lowerCs) != 0){

						found = find_word(lowerCs, hv, cache[choose]);

						if(!found) {
							//conta quantos erros novos sao inseridos
							errosEnc += actualiza_erro(string, hashVal, linha, erros);
							
						}	
					}
				}
				else
					errosEnc += actualiza_erro(string, hashVal, linha, erros);
			}
			
		}

		token = strtok(NULL, s);
	}

	qsort(erros->ers, MAXERROS, sizeof(Erro), funcComp);
	//quicksort(erros->ers);

	print_erros(errosEnc, k, erros);

	fclose(fd);

	destroy_listErros(erros);

	for(int i = 0; i < CACHESIZE; i++)
	{
		destroy_HT(cache[i]);
	}

	return 0;
}
