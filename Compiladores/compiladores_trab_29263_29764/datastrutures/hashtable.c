#include "hashtable.h"


int getIndex( int size, char word[size])
{

  int valHash = 0;

  for(int i=0; i < size; i++)
    {
      valHash = 37 * valHash + word[i];
    }

  valHash = valHash % SIZE;

  if (valHash < 0) 
    {
      valHash += SIZE;
    }
  
  return valHash;
}

int hash_funct(int key)
{
  int result = key%SIZE;
  return 0;
}

int hash(Hash *hashtable, int key)
{ 
  int index = hash_funct(key);
  return hashtable->tab[index]->value; 
}

void insert(Hash *hashTable, Node *no)
{
  int index = getIndex(sizeof(no->key), no->key);
  printf("index:%d\n", index);
  printf("valor:%d\n", no->value);
  hashTable->tab[index] = no;
}

void init_hash(Hash *tab)
{
  for(int i = 0; i < SIZE; i++)
    {
      tab->tab[i] = NULL;
    }
}

int main()
{
  Node *no = malloc(sizeof(Node));
  no->key = "hello";
  no->value = 24;

  Hash *table = malloc(sizeof(struct Hash));
  init_hash(table);
  printf("chave:valor %s:%d\n", (no->key), no->value);

  insert(table, no);
  printf("---------------\n");
  int index = getIndex(sizeof("hello"),"hello");
  


  return 0;
}
