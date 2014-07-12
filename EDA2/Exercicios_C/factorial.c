long factorialRec(int n){
    if (n < 1){
    	return 1;
    }
    else{
    	return n * factorialRec(n - 1);
    }
}

long factorialIt(int n){
	long c, fact = 1;

	for (c = 1; c <= n; c++)
		fact = fact * c;

	return fact;
}

int main(){
	//factoriais de 10 e de 20 iterativamente
	printf("#########Calc. factoriais iterativamente##########\n");
	printf("Factorial de 10 = %ld\n", factorialIt(10));

	//factorial de 20 dá overflow pois excede os 32 bits do int
	printf("Factorial de 20 = %ld\n", factorialIt(20));

	//factoriais de 10 e de 20 recursivamente
	printf("\n#########Calc. factoriais recursivamente##########\n");
	printf("Factorial de 10 = %ld\n", factorialRec(10));

	// overflow pois vai dar um numero com 62 bits > 32 bits
	printf("Factorial de 20 = %ld\n", factorialRec(20));
	
	return 0;	
}
