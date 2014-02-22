/*
 ##############################################################
 ########  	  Exercicios EDAII - Pratica2 - exc14     #########
 ##############################################################
 */

#include <stdio.h>
#include <stdlib.h>

int my_strcmp(char s1[], char s2[]){
	int i = 0;
	
	//continua a verificar os arrays enquanto os elementos no mesmo indice forem iguais
	while(s1[i] == s2[i]){
		
		if (s1[i] == '\0')
			return 0;
		
		i++;
	}

	//se a primeira string nao tiver nada nesse indice, e menor
	// ou se o caracter nesse indice da primeira string for menor que o da segunda  
	if (s1[i] == "\0" || s1[i] < s2[i])
		return -1;
	
	return 1;
	
}

void exc14(){
	char str1 [50] = "abc";
	char str2 [50] = "abcde";
	
	printf("\n%d\n\n", my_strcmp(str1, str2));
}

int main() {
	exc14();
	
	return 0;
}
