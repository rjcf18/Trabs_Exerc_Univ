/*
 ##############################################################
 ########  	  Exercicios EDAII - Pratica2 - exc12     #########
 ##############################################################
 */

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

void insertionSort(int a[]){
    int i, j, elActual;
 
    for(i = 1; i < TAM; i++){
    	//pega no primeiro elemento que não está ordenado (o primeiro ja esta ordenado)
        elActual = a[i];

        for (j = i - 1; j >= 0 && a[j] > elActual; j--){
        	//se o elemento actual for maior que o seguinte troca-os
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
	
	//InsertionSort 
	//demora 2.220 segundos para 50mil elementos
	//demora 8.864 segundos para 100mil elementos
	
	//insertionSort(a);

	
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

int main() {
	exc12();
	return 0;
}
