#include <stdio.h>
#include <sys/types.h>

#define MAX_COUNT 200

int ChildProcess(); /* child process prototype */

int main()
{
 pid_t pid;
 pid = fork();
 if (pid == 0)
   ChildProcess();
}

int ChildProcess()
{
 int n;
 int temp = 1;
 int i;
 for (i = 1; i <= n; i++)
   temp = temp*n;
   n=n-1;
   if (n == 1)
      printf("Resultado é", temp);
      fork();
}
