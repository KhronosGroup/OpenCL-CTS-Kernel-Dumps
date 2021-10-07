
kernel void block_in_if_branch(__global int* res)
{
  int multiplier = 2;
  int (^kernelBlock)(int) = ^(int num)
  {
    return num * multiplier;
  };
  size_t tid = get_global_id(0);
  res[tid] = 7;
  if (kernelBlock(5))
  {
      res[tid]-= ^(int num){ return num - 1; }(4);
  }
  if (kernelBlock(0))
  {
      res[tid]-= ^(int num){ return num - 1; }(3);
  }
  else
  {
      int (^ifBlock)(int) = ^(int num)
      {
          return num + 1;
      };
      res[tid]-= ifBlock(3);
  }
}
