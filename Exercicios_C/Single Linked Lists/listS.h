/*
  ########################################################
 #####     Exercicios EDAII - linked lists header     #####
  ########################################################
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Node{                 // nó de uma lista ligada para qualquer tipo de dados

  int elem;         //um elemento inteiro
  struct Node *next;       //O proximo nó na lista

} Node;

typedef struct LinkedList{                    //uma lista simplesmente ligada de nós

  struct Node *head;
  int size;

} LinkedList;

LinkedList *list_new();
bool list_empty(LinkedList *list);
bool list_insert(LinkedList *list, int value);
bool list_remove(LinkedList *list, int value);
int list_length(LinkedList *list);
void list_print(LinkedList *list);
int list_find(LinkedList *list, int value);
void list_destroy(LinkedList *list);
int list_nth(LinkedList *list, int n);