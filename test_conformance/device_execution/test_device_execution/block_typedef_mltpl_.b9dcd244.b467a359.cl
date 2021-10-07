
int func(int fi)
{
  typedef int (^block_t)(int);
  typedef int (^block2_t)(int);
  const block_t funcBlock1 = ^(int bi) { return bi; };
  const block2_t funcBlock2 = ^(int bi)
  {
    typedef short (^block3_t)(short);
    typedef short (^block4_t)(short);
    const block3_t nestedBlock1 = ^(short ni)
    {
      return (short)(ni - 1);
    };
    const block4_t nestedBlock2 = ^(short ni)
    {
      return (short)(ni - 2);
    };
    return bi * nestedBlock1(3) * nestedBlock2(3);
  };
  return funcBlock2(fi * 2) + funcBlock1(1);
}
kernel void block_typedef_mltpl_func(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  typedef int (^block1_t)(int);
  typedef int (^block2_t)(int);
  const block1_t kernelBlock1 = ^(int bi) { return bi + 8; };
  const block2_t kernelBlock2 = ^(int bi) { return bi + 3; };
  res[tid] = func(1) -  kernelBlock1(2) / kernelBlock2(-1);
}
