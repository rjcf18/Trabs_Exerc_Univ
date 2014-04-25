/*
 ###################################################################################
 #############  		     Exercicios EDAII - Pratica2              ##############
 ###################################################################################
 */

// -std = gnu99

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#define TAM 50000

//preenche um array com numeros aleatoriamente
void fillArray(int a[]){
	int i;

	for (i = 0; i< TAM; i++)
		a[i] = rand() % (TAM+1);

}

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

void exc9(){
	int vector[TAM], i;
	
	for (i = 0; i < TAM;i++)
		vector[i] = i+1;
	
	//pesquisa linear ---> aprox 4.268s tempo real
	/*for(i = 1; i <= TAM;i++){
		pesqLin(vector, i);
	}*/

	//pesquisa binaria recursiva ---> aprox 0.028s tempo real
	/*for(i = 1; i <= TAM;i++){
		printf("%d\n",pesqBinRec(vector, i));
		//pesqBinRec(vector, i);
	}*/


	//pesquisa binaria iterativa ---> aprox 0.024s tempo real
	for(i = 1; i <= TAM;i++){
		printf("%d\n", pesqBinIt(vector, i));
		//pesqBinIt(vector, i);
	}

}

int my_strlen(char s[]){
	//devolve o tamanho da string que recebe como argumento
	int soma = 0,i = 0;
	
	while(s[i] != '\0'){
		//enquanto nao encontrar o fim da string - \0 continua a incrementar
		soma++;
		i++;
	}

	return soma;
}

void exc10(){
	char str [50] = "uma string com \"outra string\" la\' dentro";
	printf("\nComprimento: %d\n\n", my_strlen(0));
}

long escreveFibonacci(long n){
	//faz a sucessao fibonacci recursivamente ate um numero de termos n
	long temp1,temp2;
	static long vector[1000];
	temp1 = 0;
	temp2 = 1;
	
	if (n == 0)
		return temp1;
	else if(n == 1)
		return temp2;

	if (vector[n] == 0)
		return vector[n] = escreveFibonacci(n-1) + escreveFibonacci(n-2);	

	return vector[n];
}

void exc11(){
	long i;
	for (i = 0; i < 60; i++)
		escreveFibonacci(i);
		//printf("%ld\n", escreveFibonacci(i));
}

void selectionSort(int a[]){
    int i, j, elActual;
 
    for(i = 1; i < TAM; i++){
    	//pega no primeiro elemento que não está ordenado (o primeiro ja esta ordenado)
        elActual = a[i];

        for (j = i - 1; j >= 0 && a[j] > elActual; j--){
        	//se o elemento actual for menor que o anterior troca-os
            a[j + 1] = a[j];
        }
        
        a[j+1] = elActual;
    }
}

void bubbleSort(int a[]){
    int i, j, temp;
    for (i = 0; i < TAM-1; ++i){
 
 		for (j = 0; j < TAM-1 - i; ++j){
 	    	if (a[j] > a[j+1]){
 	    		//se o elemento actual for maior que o seguinte troca-os
 				temp = a[j];
 				a[j] = a[j+1];
 				a[j+1] = temp;
 	    	}
 		}
    }
}

void merge(int a[], int limInf, int meio, int limSup){
    int b[TAM];
    int i = limInf, j = meio + 1, k = 0;
  	
  	//enquanto o lim inferior for menor ou igual ao do meio e o 
  	//elemento seguinte ao do meio for menor/igual que o lim superior 
    while (i <= meio && j <= limSup) {
        if (a[i] <= a[j])
            b[k++] = a[i++];
        else
            b[k++] = a[j++];
    }

    while (i <= meio)
        b[k++] = a[i++];
  
    while (j <= limSup)
        b[k++] = a[j++];
  
    k--;
    while (k >= 0) {
        a[limInf + k] = b[k];
        k--;
    }
}

void mergesortAux(int a[], int limInf, int limSup){
	int m;
	if (limInf < limSup) {
		//vai buscar o elemento ao meio particao
    	m = (limSup + limInf)/2;

    	//vai particionando em 2 recursivamente
        mergesortAux(a, limInf, m);
        mergesortAux(a, m + 1, limSup);

        //combina os elementos no mesmo array
        merge(a, limInf, m, limSup);
    }
}
  
void mergesort(int a[]){
    mergesortAux(a, 0, TAM-1);
}

void quicksortAux(int a[], int limInf, int limSup){
    int pivot,j,temp,i;

    if(limInf<limSup){
    	pivot = limInf;
    	i = limInf;
    	j = limSup;

		while(i<j){
			while((a[i] <= a[pivot]) && (i<limSup)){
				i++;
			}

			while(a[j]>a[pivot]){
				j--;
			}

			if(i<j){
				temp = a[i];
				a[i] = a[j];
				a[j] = temp;
			}
		}

		temp = a[pivot];
		a[pivot] = a[j];
		a[j] = temp;
		quicksortAux(a, limInf, j-1);
		quicksortAux(a, j+1, limSup);
	}
}

void quicksort(int a[]){
	quicksortAux(a, 0, TAM-1);
}

void exc12(){

	int a[TAM], i;
	fillArray(a);
	//for (i = 0; i < TAM; i++)
	//	printf("%d\n", a[i]);
	
	//SelectionSort 
	//demora 2.220 segundos para 50mil elementos
	//demora 8.864 segundos para 100mil elementos
	
	//selectionSort(a);

	
	//Bubblesort 
	//demora 8.820 segundos para 50mil elementos
	//demora 36.132 segundos para 100mil elementos
	
	//bubbleSort(a);

	
	//Mergesort
	//demora 0.024 segundos para 50mil elementos
	//demora 0.032 segundos para 100mil elementos
	
	//mergesort(a);
	

	//Quicksort
	//demora 0.020 segundos para 50mil elementos
	//demora 0.024 segundos para 100mil elementos

	quicksort(a);

}

// ve se a primeira string esta contida na segunda
bool isSubString(char s1[], char s2[]){
	int i, j, c1 = my_strlen(s1), c2 = my_strlen(s2); 
	bool isSubstr;

	for(i=0; i <= c1-c2; i++){
		
		for(j = i; j < i+c2; j++){
			
			isSubstr = true;
			
			// se nao houver letras iguais não e substring
			if (s2[j] != s1[j-i]){
				isSubstr = false;
				break;
			}
		}
		
		if (isSubstr == true)
			break;

	}
	
	return isSubstr;
}

int my_strcmp(char s1[], char s2[]){
	int i = 0, tmp1, tmp2;
	
	//continua a verificar os arrays enquanto os elementos no mesmo indice forem iguais
	while(s1[i] == s2[i]){
		
		if (s1[i] == '\0')
			return 0;
		
		i++;
	}

	if (s1[i] == '\0' || s1[i] < s2[i])
		return -1;
	
	return 1;
	
}

void exc14(){
	char str1 [50] = "abcde";
	char str2 [50] = "abc";
	printf("\n%d\n\n", my_strcmp(str1, str2));
}

bool streq(char s1[], char s2[]){
	return my_strcmp(s1, s2) == 0;
}

void exc15(){
	char str1 [50] = "uma string com \"outra string\" la\' dentro";
	char str2 [50] = "uma stringg com \"outra string\" la\' dentro";
	printf("\n%d\n", streq(str1, str2));
}

int main() {
	//exc12();
	exc11();
	
	//printf("%c %c %c\n", s[0], s[1], s[2]);
	//printf("%d %d %d\n", s[0], s[1], s[2]);
	return 0;
}

