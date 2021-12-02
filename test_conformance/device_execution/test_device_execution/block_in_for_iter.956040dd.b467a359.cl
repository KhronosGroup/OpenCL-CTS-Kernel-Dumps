
kernel void block_in_for_iter(__global int* res)
{
  int multiplier = 2;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 4;
  for(int i=2; i<17; i=kernelBlock(i))
  {
       res[tid]--;
  }
}
