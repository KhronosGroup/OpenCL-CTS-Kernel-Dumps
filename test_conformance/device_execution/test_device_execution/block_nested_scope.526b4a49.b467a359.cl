
kernel void block_nested_scope(__global int* res)
{
  int multiplier = 3;
  int (^kernelBlock)(int) = ^(int num)
  {
    int (^innerBlock)(int) = ^(int n)
    {
      return multiplier * n;
    };
    return num * innerBlock(23);
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  multiplier = 8;
  res[tid] = kernelBlock(13) - 897;
}
