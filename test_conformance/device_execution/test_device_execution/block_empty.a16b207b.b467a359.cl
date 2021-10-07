
kernel void block_empty(__global int* res)
{
  void (^kernelBlock)(void) = ^(){};
  size_t tid = get_global_id(0);
  res[tid] = -1;
  kernelBlock();
  res[tid] = 0;
}
