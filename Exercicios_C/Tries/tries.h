
/* trie interface */

extern struct trie *trie_new(void);
extern void trie_destroy(struct trie *);

extern int trie_empty(struct trie *);
extern int trie_find(struct trie *, char *);
extern void trie_insert(struct trie *, char *);
extern void trie_remove(struct trie *, char *);

extern void trie_print(struct trie *);
extern void trie_print_completions(struct trie *, char *);
