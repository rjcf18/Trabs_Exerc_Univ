#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include "hashTableDisc.h"
#define TAMMAXPALAVRA 28
#define CAPACIDADE 2400019 // num. primo
#define NUMBLOCOS 18750 // 2400019/128 = 18750 aprox
#define SIZEHT (128)  //4096/32 = 128 aproxx

/*############## Criacao dicionario ########################*/

int main(void){
	int chave = 0;
	
	criar_dic("dic.data",CAPACIDADE);

	char string[TAMMAXPALAVRA];
	
	FILE* fd = fopen("dic.data","r+");
 	int scanVal = 0;
	while(scanVal != EOF)
	{
		
		for(int i=0;i<TAMMAXPALAVRA;i++)
			string[i]=0;

		scanVal = fscanf(stdin, "%s",string);
		chave = hash(string);
		insere_elemento(fd, chave, string);		
	}

	fclose(fd);
	return 0;
	
}
