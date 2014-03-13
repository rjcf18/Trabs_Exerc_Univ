#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "tries.h"

#define ALPH_MIN 'a'
#define ALPH_MAX 'z'
#define ALPH_SIZE (ALPH_MAX - ALPH_MIN + 1)

#define POS(c)  ((c) - ALPH_MIN)		// character position
#define CHAR(p) ((p) + ALPH_MIN)		// character from position

/* trie node */
struct node {
  struct node *child[ALPH_SIZE];
  bool	      word;
};

/* trie */
struct trie {
  struct node *root;
};


/* allocates and returns a new trie node */
static struct node *node_new()
{
  struct node *node = malloc(sizeof(*node));
  int i;

  node->word = false;
  for (i = 0; i < ALPH_SIZE; ++i)
    node->child[i] = NULL;

  return node;
}


/* frees a trie NODE */
static void node_free(struct node *node)
{
  free(node);
}


/* destroys the sub-trie with root NODE */
static void node_destroy(struct node *node)
{
  int i;

  if (node == NULL)
    return;

  for (i = 0; i < ALPH_SIZE; ++i)
    node_destroy(node->child[i]);

  node_free(node);
}


/* creates a new, empty trie */
struct trie *trie_new()
{
  struct trie *trie = malloc(sizeof(struct trie));

  if (trie)
    trie->root = NULL;

  return trie;
}


/* destroys trie T, freeing up its space */
void trie_destroy(struct trie *t)
{
  node_destroy(t->root);

  free(t);
}


/* checks whether trie T is empty */
int trie_empty(struct trie *t)
{
  return t->root == NULL;
}


/* inserts word P into trie T */
void trie_insert(struct trie *t, char *p)
{
  struct node *n;

  if (t->root == NULL)
    t->root = node_new();

  n = t->root;

  // follow the word down the trie as long as possible
  while (*p != '\0' && n->child[POS(*p)] != NULL)
    {
      n = n->child[POS(*p)];
      p++;
    }

  // insert the new suffix into the trie
  while (*p != '\0')
    {
      n->child[POS(*p)] = node_new();
      n = n->child[POS(*p)];

      p++;
    }

  n->word = true;
}


/* searches word P in trie T
   returns 1 if it finds it, 0 otherwise */

int trie_find(struct trie *t, char *p)
{
   struct node *n;
   n = t->root;
   while(*p != '\0' && n!=NULL )
   {
       n = n->child[POS(*p)];
       p++;
   }
   
   return (n!=NULL && n->word);
}
//funcao auxiliar
void trie_print_node(struct node *n, char *p, int pi){
  int i;
  if(n == NULL)
    return;

  if(n->word)
    printf("%.*s \n", pi,p);

  for(i=0; i<ALPH_SIZE; i++)
  {
 
    if(n->child[i] != NULL)
    { 
      printf("%s", p);
      p[pi] = CHAR(i);
      trie_print_node(n->child[i], p, pi+1);
    }
  }
}

/* prints all words in trie T with prefix P*/
void trie_print_completions(struct trie *t, char *p)
{
     struct node *n;
     n = t->root;
     char c[32];
     int pi = 0;  

     while(n != NULL && *p != '\0')
     {
       n = n->child[POS(*p)];
       c[pi] = *p;
       p++;
       pi++;
     }
  
     trie_print_node(n, c, pi); 
}

/* removes word P from trie T*/
void trie_remove(struct trie *t, char *p)
{
  struct node *cnode = t->root;
  struct node *cp[32];
  int *cp_index[32];
  int cpi = 0;
  int i = 0;
  
  while(cnode != NULL && *p != '\0')
  {
    cnode = cnode->child[POS(*p)];
    cp[i] = cnode;
    cp_index[i] = POS(*p);
    p++;
    cpi++;
  }
  
  if(cnode != NULL && cnode->word)
  {
    int i;
    cnode->word = false;
    
    bool empty;
    do
    {
      p--;
      empty = true;
      
      for(i=0; i<ALPH_SIZE; i++)
        if(cnode->child[i] != NULL)
          empty = false;
      
      if(empty)
      {
        if(cpi == 0)
          t->root = NULL;
        else 
          cpi--;
      }
    }
    while(cnode == NULL || cnode->word);
  }
}



/* prints the full contents of trie T*/
void trie_print(struct trie *t)
{
     trie_print_completions(t, "");
    
}

