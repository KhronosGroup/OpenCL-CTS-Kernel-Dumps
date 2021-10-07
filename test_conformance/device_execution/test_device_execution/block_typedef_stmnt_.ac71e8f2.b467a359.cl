
kernel void block_typedef_stmnt_if(__global int* res)
{      
  int flag = 1;
  int sum = 0;
  if (flag) {
    typedef int (^block_t)(int);
    const block_t kernelBlock = ^(int bi)
    {
      block_t b = ^(int bi)
      {
        return bi + 1;
      };
      return bi + b(1);
    };
    sum = kernelBlock(sum);
  }
  size_t tid = get_global_id(0);
  res[tid] = sum - 2;
}
