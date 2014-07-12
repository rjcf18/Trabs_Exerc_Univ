#include <stdio.h>
#include <stdlib.h>

#define SIZE 107

typedef struct Node
{
  char *key;
  int value;
}Node;

typedef struct Hash 
{
  int size;
  Node *tab[SIZE];
}Hash;


