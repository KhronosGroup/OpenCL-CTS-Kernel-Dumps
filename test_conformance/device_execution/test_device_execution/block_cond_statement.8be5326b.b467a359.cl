
kernel void block_cond_statement(__global int* res)
{
  int multiplier = 2;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 120;
  res[tid] = (kernelBlock(2) == 4) ? res[tid] - 30              : res[tid] - 1;
  res[tid] = (kernelBlock(2) == 5) ? res[tid] - 3               : res[tid] - 30;
  res[tid] = (1)                   ? res[tid] - kernelBlock(15) : res[tid] - 7;
  res[tid] = (0)                   ? res[tid] - 13              : res[tid] - kernelBlock(15);
}
