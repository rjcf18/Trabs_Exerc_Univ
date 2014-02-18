#include <sys/types.h>
#include <stdio.h>

void forkTest() {
        puts("TESTE FORK:\n");
    
    pid_t pid;
    
    pid = fork(); //cria processo
    
    if(pid > 0) {
        printf(" Processo Pai PID: %d ", pid);
    }
    else {
        printf(" Processo Filho PID: %d ", pid);
    }
    puts("FIM");
}

main() {
    forkTest();
}
