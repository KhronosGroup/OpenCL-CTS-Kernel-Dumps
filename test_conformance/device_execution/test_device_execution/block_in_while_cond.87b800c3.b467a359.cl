
kernel void block_in_while_cond(__global int* res)
{
  int (^kernelBlock)(int) = ^(int num)
  {
    return res[num];
  };
  size_t tid = get_global_id(0);
  res[tid] = 27*(tid+1);
  while(kernelBlock(tid))
  {
      res[tid]--;
  }
}
