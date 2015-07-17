/*
 ###################################################################################
 #############  		     Exercicios EDAII - Pratica1              ##############
 ###################################################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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
