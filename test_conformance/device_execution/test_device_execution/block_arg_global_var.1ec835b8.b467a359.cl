
constant int gi = 8;
kernel void block_arg_global_var(__global int* res)
{
  int (^kernelBlock)(int) = ^(int bgi)
  {
    return bgi - 8;
  };
  size_t tid = get_global_id(0);
  res[tid] = kernelBlock(gi);
}
