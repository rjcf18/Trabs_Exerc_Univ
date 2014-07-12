#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "pesquisaingenua.h"
#define MAXLINHA 2000
 
int main(int argc,char *argv[]) 
{
 
	if (argc!=2) 
	{
		fprintf(stderr,"\nArgumentos invalidos.");
		return 1;
	}
	
    char buffer[MAXLINHA];
    	
    while (fgets(buffer,MAXLINHA, stdin) != NULL){
    	int pos; 
    	pos = pesquisa_ingenua(argv[1], buffer);
    	
    	if (pos != -1)
    		//mostra a linha onde esta a ocorrencia
    		printf("%s",buffer);
			//printf("Pos: %d %s",pos,buffer);
    }	

    return 0;   
}