
#include <stdio.h>
#include <stdlib.h>

#define DATA_LENGTH 1024
#define MAX_OF_DATA 512

int reduce_sum_cpu(int* input, int length) {
	int accumulator = input[0];
	for(int i = 1; i < length; i++) 
		accumulator += input[i];
	return accumulator;
}

void generate_data( int* input, int length ) {
	for( int idx = 0 ; idx < length ; idx ++ ) {
		input[idx] = rand() % MAX_OF_DATA;	
	} 
} 

int main()
{
	int data[ DATA_LENGTH ] = {0};

	generate_data( data, DATA_LENGTH );

	int result = reduce_sum_cpu( data, DATA_LENGTH );	

	printf(" result = %d\n", result );
}
