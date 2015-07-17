/*
 ###################################################################################
 #############  		     Exercicios EDAII - Pratica1              ##############
 ###################################################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void exc1(){
	printf("Hello World!!\n"); /* imprime !!!Hello World!!! */
}

void exc2(){
	int i;
	
	for (i = 1; i<=20;i++){
		printf("%d\n", i); /* imprime cada elemento de 1 a 20 */
	}
}

void exc3(){
	int i;
	
	for (i = 1; i<=20;i++){
		printf("%d ", i); /* imprime cada elemento de 1 a 20 */
	}

	printf("\n");
}

long factorialRec(int n){
    if (n < 1){
    	return 1;
    }
    else{
    	return n * factorialRec(n - 1);
    }
}

long factorialIt(int n){
	long c, fact = 1;

	for (c = 1; c <= n; c++)
		fact = fact * c;

	return fact;
}

void exc4(){
	//factoriais de 10 e de 20 iterativamente
	printf("#########Calc. factoriais iterativamente##########\n");
	printf("Factorial de 10 = %ld\n", factorialIt(10));

	//factorial de 20 dá overflow pois excede os 32 bits do int
	printf("Factorial de 20 = %ld\n", factorialIt(20));

	//factoriais de 10 e de 20 recursivamente
	printf("\n#########Calc. factoriais recursivamente##########\n");
	printf("Factorial de 10 = %ld\n", factorialRec(10));

	// overflow pois vai dar um numero com 62 bits > 32 bits
	printf("Factorial de 20 = %ld\n", factorialRec(20));
}

void exc5(){
	int i,j;
	
	for (i = 1; i<=10;i++){
		for (j = 1;j<=10;j++){
			printf("%3d ", j*i); /* imprime cada elemento de 1 a j*i em que j e o numero de colunas e i o numero de linhas */
		}
		printf("\n");
	}

}

void exc6(){
	int i,j;
	
	for (i = 1; i<=10;i++){
		for (j = 1;j<=i;j++){
			printf("%3d ", j*i); /* imprime cada elemento de 1 a j*i em que j e o numero de colunas e i o numero de linhas */
		}
		printf("\n");
	}
}

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
	

void exc7(){
	//iterativa
	int i;
	//for (i = 0;i<20;i++)
	//	printf("%ld ", fibonacciIT(i));
	//printf("\n");

	//recursiva
	for (i = 0;i<45;i++)
		printf("%ld ", fibonacciREC(i));
	printf("\n");
}

void exc8(){
	// devolve os numeros primos de 555 ate 777
	int n,i,conta;
	    for(n = 555;n<=777;n++){
	         conta = 0; // por quantos numeros o numero n pode ser divisivel

	         for(i=2;i<=n/2;i++){
	             if(n%i==0){
	                 conta++;
	                 break;
	             }
	         }
	         if(conta==0 && n!= 1)
	             printf("%d ",n);
	    }
}

int main() {
	exc7();
	return 0;
}
