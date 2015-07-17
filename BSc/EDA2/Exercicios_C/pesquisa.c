#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#define TAM 50000

// procura por um elemento n e devolve o indice desse elemento ou se nao estiver no array devolve -1
int pesqLin(int a[], int numero){
	int i;
	
	for (i =0; i < TAM; i++){
		if(a[i] == numero){
			return i;
		}
	}

	return -1;
}

int pesqBinAux(int v [], int inicio, int fim, int numero){
	if(inicio > fim){
        return -1;
    }

    // Encontra o elemento no meio do array e usa-o para partir o array em 2 partes
    int meio = (fim + inicio)/2;
 
    if(v[meio] == numero){
        return meio;
    }
    
    else if(v[meio] > numero){
        return pesqBinAux(v, inicio, meio - 1, numero);
    }

    return pesqBinAux(v, meio + 1, fim, numero);
}
	
int pesqBinRec(int v [], int numero){
    return pesqBinAux(v, 0, TAM-1, numero);
}

int pesqBinIt(int v [], int numero){
	int inicio, fim, meio;
	
	inicio = 0;
	fim = TAM-1;
	meio = (inicio+fim)/2;

	while(inicio <= fim){
		//devolve o indice do elemento que se esta a procurar 
		if(v[meio] == numero)
			return meio;
		
		else if(v[meio] < numero)
			inicio = meio+1;
		
		else
			fim = meio-1;
		
		meio = (inicio+fim)/2;
	}

	if(inicio > fim)
		return -1;	
}

int main(){
	int vector[TAM], i;
	
	for (i = 0; i < TAM;i++)
		vector[i] = i+1;
	
	//pesquisa linear ---> aprox 4.268s tempo real
	for(i = 1; i <= TAM;i++){
		pesqLin(vector, i);
	}

	//pesquisa binaria recursiva ---> aprox 0.028s tempo real
	/*for(i = 1; i <= TAM;i++){
		printf("%d\n",pesqBinRec(vector, i));
		//pesqBinRec(vector, i);
	}*/


	//pesquisa binaria iterativa ---> aprox 0.024s tempo real
	/*for(i = 1; i <= TAM;i++){
		printf("%d\n", pesqBinIt(vector, i));
		//pesqBinIt(vector, i);
	} */

	return 0;
}
