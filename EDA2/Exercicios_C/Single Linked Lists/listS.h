/*
  ########################################################
 #####     Exercicios EDAII - linked lists header     #####
  ########################################################
 */

struct LinkedList *list_new();
bool list_empty(struct LinkedList *list);
bool list_insert(struct LinkedList *list, int value);
bool list_remove(struct LinkedList *list, int value);
int list_length(struct LinkedList *list);
void list_print(struct LinkedList *list);
int list_find(struct LinkedList *list, int value);
void list_destroy(struct LinkedList *list);
int list_nth(struct LinkedList *list, int n);