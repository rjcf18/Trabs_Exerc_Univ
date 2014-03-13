#include <stdio.h>

#include "tries.h"

#define NWORDS (sizeof(words) / sizeof(words[0]))	// n�mero de palavras

#define NWORDS1 (sizeof(words1) / sizeof(words1[0]))	// n�mero de

char *words[] = {
  "acabais",
  "acocora",
  "amuareis",
  "aramada",
  "arpoavam",
  "azoto",
  "barceiro",
  "barco",
  "cabulais",
  "coragem",
  "corasse",
  "cuja",
  "embarace",
  "ensaquem",
  "enxuguem",
  "festeiro",
  "laringes",
  "mar",
  "propugno",
  "remem",
  "salteada",
  "repudiei",
  "reactive",
  "festa",
  "leque",
  "festarola",
  "achar",
  "enteados",
  "marujar",
  "vinte"
};



char *words1[] = {
  "agrado",
  "sorte" ,
  "cal" ,
  "agricultura" ,
  "bata" ,
  "agradece" ,
  "calma" ,
  "massa"
};

/*
   Fazer um programa que:

   1. insere todas as palavras em words[] numa trie

   2. confirma que trie_find() as encontra todas

   3. mostra completa��es poss�veis de "a" "ac" "cor" "fest" "mar"

   4. remove algumas palavras da trie

   5. mostra todo o conte�do da trie, antes e depois de remover
      palavras
*/

int main(int argc, char *argv[])
{
  struct trie *t = trie_new();
  int i;

  for (i = 0; i < NWORDS1; i++)
  {
    trie_insert(t,words1[i]); 
    //printf("%s =  %d\n",words[i], trie_find(t,words[i])); 
  }
 
 // trie_remove(t,"vinte");
  
  //trie_print_completions(t,"rea");

  //printf("\n\nPrint \n");
  trie_print(t);
  trie_destroy(t);

 
   return 1;
}
