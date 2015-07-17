#include "pesquisaingenua.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
 
#define MAXLINHA 2000
 
 
int pesquisa_ingenua(char *P, char *T)
{
    int i,j;
    bool match;
     
    int psize = strlen(P);
    int tsize = strlen(T);
     
    for(i=0;i < tsize-psize+1;i++)
    {
        match = true;
        j = 0;
        
        while(match && j < psize)
        {
            if(T[i+j] != P[j])
            {
                match = false;
                break;
            }
            else
                j++;         
        }

        if(match)
        {
            return i+1;
        }
    }
         
    return -1;
}
