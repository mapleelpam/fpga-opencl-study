__kernel
void reduce(
            __global int* buffer,
            __const int length,
            __global int* result) {

  int global_index = get_global_id(0);
  int local_index = get_local_id(0);
  __local int scratch[1024];
  // Load data into local memory
  if (global_index < length) {
    scratch[local_index] = buffer[global_index];
  } else {
    // Infinity is the identity element for the min operation
    scratch[local_index] = INFINITY;
  }
  barrier(CLK_LOCAL_MEM_FENCE);
  for(int offset = 1;
      offset < get_local_size(0);
      offset <<= 1) {
    int mask = (offset << 1) - 1;
    if ((local_index & mask) == 0) {
      float other = scratch[local_index + offset];
      float mine = scratch[local_index];
      scratch[local_index] = (mine < other) ? mine : other;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
  }
  if (local_index == 0) {
    result[get_group_id(0)] = scratch[0];
  }
}
