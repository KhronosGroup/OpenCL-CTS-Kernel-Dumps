
kernel void block_switch_cond(__global int* res)
{
  int multiplier = 2;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 12;
  int i = 1;
  while(i <= 3)
  {
      switch (kernelBlock(i))
      {
          case 2:
              res[tid] = res[tid] - 2;
              break;
          case 4:
              res[tid] = res[tid] - 4;
              break;
          case 6:
              res[tid] = res[tid] - 6;
              break;
          default:
              break;
      }
      i++;
  }
}
