
int func(int fi)
{
  typedef int (^block_t)(int);
  const block_t funcBlock = ^(int bi)
  {
    typedef short (^block2_t)(short);
    block2_t nestedBlock = ^(short ni)
    {
      return (short)(ni - 1);
    };
    return bi * nestedBlock(3);
  };
  return funcBlock(fi * 2);
}
kernel void block_typedef_func(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = func(1) - 4;
}
