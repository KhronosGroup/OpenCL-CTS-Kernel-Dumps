
kernel void block_in_if_cond(__global int* res)
{
  int multiplier = 2;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 7;
  if (kernelBlock(5))
  {
      res[tid]-= 3;
  }
  if (kernelBlock(0))
  {
      res[tid]-= 2;
  }
  else
  {
      res[tid]-= 4;
  }
}
