
kernel void block_builtin(__global int* res)
{
  int b = 3;
  int (^kernelBlock)(int) = ^(int a)
  {
    return (int)abs(a - b);
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = kernelBlock(2) - 1;
}
