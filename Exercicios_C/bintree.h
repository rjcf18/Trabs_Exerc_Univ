/*
  ########################################################
 #####     Exercicios EDAII - binary trees header     #####
  ########################################################
 */

struct BinTree *tree_new();
struct TNode *node_new();
bool tree_empty(struct BinTree *tree);
bool tree_insert(struct BinTree *tree, int value);
bool tree_remove(struct BinTree *tree, int value);
void tree_print(struct BinTree *tree);
bool tree_find(struct BinTree *tree, int value);
void tree_destroy(struct BinTree *tree);
int tree_size(struct BinTree *tree);
int tree_height(struct BinTree* tree);