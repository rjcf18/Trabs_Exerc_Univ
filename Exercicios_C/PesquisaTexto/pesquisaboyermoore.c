#include "pesquisaingenua.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
 
#define MAXLINHA 2000

int compute_last(char *P)
{
	int i;
	int last;
	int psize = strlen(P);
	for (i = 0; i < d; i++)
		last = 0;
	for (i = 0; i < psize; i++)
		last = i;
	return last;
}

//recebe 2 numeros como arg e devolve o menor desses 2
int min(int a, int b) {
	if (a < b)
		return a;
	else
		return b;
}

int pesquisa_BoyerMoore(char *P, char *T)
{
	int i,j;
	int psize = strlen(P);
	int tsize = strlen(T);
	int m = psize;
	int last = compute_last(P);
	i = m;
	j = m;

	while (i <= tsize)
	{
		if (T[i] == P[j]
		{
			if j == 1
			{
				printf("Encontrado: %d", i-1)
				i = i+m;
				 
			}
			else
			{
				i--;
				j--;
			}

		}
		else
		{
			i = i+m-min(j-1, compute_last(T[i]));
			j = m;
		}

	}

	return -1;

}