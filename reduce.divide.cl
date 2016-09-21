#define DIVIDE_N 8
__kernel void reduce(
            __global int* buffer,
            __const int length,
            __global int* result) 
{
	int acc = 0;
	int scratch[ DIVIDE_N ];
	#pragma unroll
	for( int d = 0 ; d < DIVIDE_N ; d ++ ) {
		scratch[d] = 0; 
		int from = (length / DIVIDE_N)*( d );
		int to = (length / DIVIDE_N)*( d + 1);
		if( to > length ) to = length;
		for( int idx = from; idx < to; idx ++ ) { 
			scratch[d] += buffer[idx];
		} 
	}
	for( int d = 0 ; d < DIVIDE_N ; d ++ ) {
		acc += scratch[d];
	}

	result[0] = acc;
}
