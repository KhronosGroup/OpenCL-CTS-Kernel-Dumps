
kernel void block_in_do_while_body(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);
  int i = 100;
  res[tid] = 3*5050;
  do
  {
      int (^kernelBlock)(int) = ^(int num)
      {
          return num * multiplier;
      };
      res[tid]-=kernelBlock(i--);
  } while(i);
}
