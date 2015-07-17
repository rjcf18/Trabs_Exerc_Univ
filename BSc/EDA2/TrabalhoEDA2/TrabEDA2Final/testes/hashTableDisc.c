#include "hashTableDisc.h"

//devolve o valor de hash duma string


/*calcula o hash de uma string
  Algoritmo de hashing usado -> djb2

  http://www.cse.yorku.ca/~oz/hash.html  */
unsigned int hash(char *string){
	
	unsigned int hash = 5381;
    int c;

    while ((c = *string++))
        hash = ((hash << 5) + hash) + c; 
		
	hash %= CAPACIDADE;
	
	return hash;
}

/*carrega um bloco do dicionario em disco 
  para a hashtable em memória*/
void carregar_bloco(HashTable* ht, FILE *fd, int pos)
{

	fseek(fd, pos*SIZEHT*sizeof(Elemento), SEEK_SET);
	fread(ht->ht, SIZEHT*sizeof(Elemento), 1, fd);
}

/*aloca memoria necessaria para uma hashtable (bloco)*/
HashTable* new_HT()
{
	HashTable *ht = malloc(sizeof(HashTable));
	ht->ht = malloc(sizeof(Elemento)*SIZEHT);
	memset(ht->ht,0,sizeof(Elemento)*SIZEHT);

	return ht;
}

/*liberta a mem ocupada pela hashtable (bloco)*/
void destroy_HT(HashTable *ht)
{
	if(ht == NULL) return;
	free(ht->ht);
	free(ht);
}

/* cria um novo dicionario com um nome e 
   um tamanho (numero de elementos)*/
void criar_dic(char *nomeFicheiro,int tamanho)
{

	FILE *fd;
	Elemento elem;
	
	memset(&elem,0,sizeof(Elemento)); //inicializar elemento da hashtable a 0
	
	fd = fopen(nomeFicheiro,"w");
	
	if(fd == NULL)
	{
		perror("Erro: criar_tabela - fopen.");
		exit(0);
	}
	
	for(int i=0;i<tamanho;i++)
	{
		fwrite(&elem,sizeof(Elemento),1,fd);
	}
	fclose(fd);
}

/*pesquisa um elemento em disco*/
bool pesquisa_Elem(char *nomeFicheiro, char *string)
{
	FILE *fd = fopen(nomeFicheiro, "r+");
	Elemento tmp;
	int pos = hash(string);
	
	while(1){
		fseek(fd, pos*sizeof(Elemento), SEEK_SET);
		fread(&tmp, sizeof(Elemento), 1, fd);
		
		if (tmp.usado == 0)
			fclose(fd);
			return false;		

		if (tmp.usado == 1 && strcmp(tmp.palavra, string) == 0)
			fclose(fd);
			return true;
		
		//printf("Colisao!\n");
		pos++;
		pos = pos%CAPACIDADE;
	}

	fclose(fd);

	return false;

}

/*insere um elemento na hashtable criada em disco*/
void insere_elemento(FILE *fd, int chave, char *string)
{
	/* elemento a inserir (elem) e temporario(tmp) para 
		pesquisar o ficheiro e verificar se o ficheiro 
		a inserir ja existe na hash table*/
	Elemento elem, tmp;
	int pos = chave;	

	elem.usado = 1;
	strcpy(elem.palavra, string);

	
	if(fd == NULL)
	{
		perror("Erro: insere_dados - fopen.");
		exit(0);
	}

	//procura por uma posição não usada para inserir
	while(1)
	{
		fseek(fd, pos*sizeof(Elemento), SEEK_SET);
		fread(&tmp, sizeof(Elemento), 1, fd);	
		if (tmp.usado == 0)
			break;
		//printf("Colisao!\n");
		pos++;
		pos %= CAPACIDADE;
	}

	//printf("pos = %d\n", pos);
	fseek(fd, pos*sizeof(Elemento), SEEK_SET);
	fwrite(&elem, sizeof(Elemento),1,fd);
	
}
