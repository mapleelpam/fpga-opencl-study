__kernel void reduce(
            __global int* buffer,
            __const int length,
            __global int* result) 
{
	int acc = 0;
	for( int idx = 0 ; idx < length ; idx ++ ) { 
		acc += buffer[idx];
	}

	result[0] = acc;
}
