/*
  ########################################################
 #####     Exercicios EDAII - binary trees header     #####
  ########################################################
 */

typedef struct TNode TNode;
typedef struct BinTree BinTree;

BinTree *tree_new();
TNode *node_new();
bool tree_empty(BinTree *tree);
bool tree_insert(BinTree *tree, int value);
bool tree_remove(BinTree *tree, int value);
void tree_print(BinTree *tree);
bool tree_find(BinTree *tree, int value);
void tree_destroy(BinTree *tree);
int tree_size(BinTree *tree);
int tree_height(BinTree* tree);
