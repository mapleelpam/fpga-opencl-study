#define DIVIDE_N 8
__kernel void reduce(
            __global int* buffer,
            __const int length,
            __global int* result) 
{
	int acc = 0;
	for( int idx = 0 ; idx < length ; idx += DIVIDE_N ) {
		 acc += buffer[idx];
	}

	result[0] = acc;
}
