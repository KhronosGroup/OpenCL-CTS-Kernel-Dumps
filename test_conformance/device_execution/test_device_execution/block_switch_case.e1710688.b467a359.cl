
kernel void block_switch_case(__global int* res)
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
              res[tid]-=^(int num){ return num - 1; }(3);
              break;
          case 4:
          {
              int (^caseBlock)(int) = ^(int num)
              {
                  return num + 1;
              };
              res[tid]-=caseBlock(3);
              break;
          }
          case 6:
              res[tid]-=kernelBlock(3);
              break;
          default:
              break;
      }
      i++;
  }
}
