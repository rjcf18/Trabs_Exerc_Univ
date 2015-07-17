#include <stdio.h>
#include <stdlib.h>
#include "structs.h"
int main()
{
    Literal *lit = new_literal(2, LITERAL_INT);
    
    printf("tipo: %d", lit->kind);

}
