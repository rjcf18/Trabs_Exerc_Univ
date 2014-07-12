#include <stdio.h>
#include <string.h>
#define TamMaxNomes 21
#define NumNomes 8

//o tamanho maximo de cada nome e 20 pois o caracter '\0' nao e contado

void sortStringsAux(int limInf, int limSup, int tamMax, char lista[][tamMax]) {
//Ordena as strings de lista[limInf] a lista[limSup] num array bidimensional por ordem alfabetica 
//o tamanho maximo de cada string é tamMax - 1 (subtrai-se um devido ao caracter de fim de string - \0)
	int i, k;
	char string[tamMax];
	
	for (i = limInf + 1; i <= limSup; i++) {
		strcpy(string, lista[i]);
		k = i - 1; 
		
		while (k >= limInf && strcmp(string, lista[k]) < 0) {
			//compara a string actual com a string anterior
			strcpy(lista[k + 1], lista[k]);
			--k;
		}
	
		strcpy(lista[k + 1], string);
	
	}
}

void sortStrings(char lista[][TamMaxNomes]){
	sortStringsAux(0, NumNomes-1, TamMaxNomes, lista);
} 

int main() {
	int n;
	char nomes[NumNomes][TamMaxNomes] = {"Ricardo", "Joao","Tiago", "Maria", "Joana",
	"Goncalo", "Rafael", "Teresa"};
 
	sortStrings(nomes);
	
	printf("\nOs nomes ordenados sao:\n\n");
	for (n = 0; n < NumNomes; n++)
		printf("%s\n", nomes[n]);

	return 0;
} 

