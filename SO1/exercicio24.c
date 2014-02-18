#include <pthread.h>
#include <stdio.h>

int a = 0;
int b = 0;

/* Prints x’s to stderr. The parameter is unused. Does not return. */
void* print_xs (void* unused){
	while (a < 100){
		fputc ('x', stderr);
		a++;
		}
		return NULL;
}
void* print_ys (void* unused){
	while (b < 100){
		fputc ('y', stderr);
		b++;
		}
		return NULL;
}

/* The main program. */
int main (){
	pthread_t thread_id, thread_id2;

	/* Create a new thread. The new thread will run the print_xs
	function. */
	pthread_create (&thread_id, NULL, &print_xs, NULL);
	pthread_create (&thread_id2, NULL, &print_ys, NULL);
	pthread_join (thread_id, NULL);
	pthread_join (thread_id2, NULL);
	
	return 0;
}
