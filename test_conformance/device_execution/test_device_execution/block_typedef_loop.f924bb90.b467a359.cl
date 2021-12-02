
kernel void block_typedef_loop(__global int* res)
{      
  int sum = -1;
  for (int i = 0; i < 3; i++) {
    typedef int (^block_t)(void);
    const block_t kernelBlock = ^()
    {
      return i + 1;
    };
    sum += kernelBlock();
  }
  size_t tid = get_global_id(0);
  res[tid] = sum - 5;
}
