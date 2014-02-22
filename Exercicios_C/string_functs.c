#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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


bool streq(char s1[], char s2[]){
	return my_strcmp(s1, s2) == 0;
}

void exc10(){
	char str [50] = "uma string com \"outra string\" la\' dentro";
	printf("\nComprimento: %d\n\n", my_strlen(0));
}

void exc14(){
	char str1 [50] = "abcde";
	char str2 [50] = "abc";
	printf("\n%d\n\n", my_strcmp(str1, str2));
}

void exc15(){
	char str1 [50] = "uma string com \"outra string\" la\' dentro";
	char str2 [50] = "uma stringg com \"outra string\" la\' dentro";
	printf("\n%d\n", streq(str1, str2));
}

int main() {
	//exc10();
	exc14();
	
	return 0;
}
