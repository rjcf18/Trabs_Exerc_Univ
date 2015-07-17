/*
 ###################################################################################
 #############  		     Exercicios EDAII - Pratica1              ##############
 ###################################################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long fibonacciIT(int n){
	//faz a sucessao fibonacci iterativamente ate um numero de termos n
	int i;
	long f1 = 0;
	long f2 = 1;
	long fn;
	if (n == 0)
		return f1;
	else if(n==1){
		return f2;
	}
	for (i = 2; i <= n; i++ ){
		fn = f1 + f2;
		f1 = f2;
		f2 = fn;
	}
	return fn;
}
	
long fibonacciREC(int n){
	//faz a sucessao fibonacci recursivamente ate um numero de termos n
	long temp1,temp2;
	temp1 = 0;
	temp2 = 1;
	if (n == 0)
		return temp1;
	else if(n == 1)
		return temp2;
	return fibonacciREC(n-1) + fibonacciREC(n-2);
}
	

int main(){
	//iterativa
	int i;
	//for (i = 0;i<20;i++)
	//	printf("%ld ", fibonacciIT(i));
	//printf("\n");

	//recursiva
	for (i = 0;i<45;i++)
		printf("%ld ", fibonacciREC(i));
	printf("\n");
	
	return 0;
}
