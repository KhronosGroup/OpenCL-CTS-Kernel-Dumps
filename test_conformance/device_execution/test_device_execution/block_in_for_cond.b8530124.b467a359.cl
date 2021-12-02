
kernel void block_in_for_cond(__global int* res)
{
  int multiplier = 3;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 39;
  for(int i=0; i<kernelBlock(13); i++)
  {
       res[tid]--;
  }
}
