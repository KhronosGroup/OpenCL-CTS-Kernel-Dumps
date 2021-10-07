
int fnTest(int a)
{
  int localVar = 17;
  int (^functionBlock)(int) = ^(int num)
  {
    return localVar * num;
  };
  return 111 - functionBlock(a+1);
}
kernel void block_function_scope(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = fnTest(5) - 9;
}
