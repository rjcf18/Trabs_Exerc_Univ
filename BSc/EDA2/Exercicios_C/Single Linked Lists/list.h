/*
  ########################################################
 #####     Exercicios EDAII - linked lists header     #####
  ########################################################
 */

typedef struct Node Node;
typedef struct LinkedList LinkedList;

LinkedList *list_new();
Node *node_new();
bool list_empty(LinkedList *list);
bool list_insert(LinkedList *list, int value);
bool list_remove(LinkedList *list, int value);
int list_length(LinkedList *list);
void list_print(LinkedList *list);
int list_find(LinkedList *list, int value);
void list_destroy(LinkedList *list);
int list_nth(LinkedList *list, int n);
