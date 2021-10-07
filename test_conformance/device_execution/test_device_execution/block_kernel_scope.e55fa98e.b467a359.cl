
kernel void block_kernel_scope(__global int* res)
{
  int multiplier = 3;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  multiplier = 8;
  res[tid] = kernelBlock(7) - 21;
}
