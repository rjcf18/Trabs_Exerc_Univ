/*
  ########################################################
 #####     Exercicios EDAII - binary trees header     #####
  ########################################################
 */

typedef struct TNode TNode;
typedef struct BinTree BinTree;

BinTree *tree_new();
TNode *node_new();
bool tree_empty(BinTree *);
bool tree_insert(BinTree *, int);
bool tree_remove(BinTree *, int );
void tree_print(BinTree *);
bool tree_find(BinTree *, int);
void tree_destroy(BinTree *);
int tree_size(BinTree *);
int tree_height(BinTree*);
