
kernel void block_in_while_body(__global int* res)
{
  int multiplier = 3;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  int i = 7;
  res[tid] = 3*(7+6+5+4+3+2+1);
  while(i)
  {
      res[tid]-=kernelBlock(i--);
  }
}
