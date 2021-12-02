
kernel void block_in_for_init(__global int* res)
{
  int multiplier = 3;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 27;
  for(int i=kernelBlock(9); i>0; i--)
  {
       res[tid]--;
  }
}
