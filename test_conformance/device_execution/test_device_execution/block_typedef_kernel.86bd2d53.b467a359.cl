
kernel void block_typedef_kernel(__global int* res)
{
  typedef int* (^block_t)(int*);
  size_t tid = get_global_id(0);
  res[tid] = -1;
  int i[4] = { 3, 4, 4, 1 };
  int *temp = i; // workaround clang bug
  block_t kernelBlock = ^(int* pi)
  {
    block_t b = ^(int* n) { return n - 1; };
    return pi + *(b(temp+4));
  };
  switch (*(kernelBlock(i))) {
    case 4:
      res[tid] += *(kernelBlock(i+1));
      break;
    default:
      res[tid] = -100;
      break;
  }
  res[tid] += *(kernelBlock(i)) - 7;
}
