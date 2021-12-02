
int func()
{
  return ^(int i) {
    return ^(ushort us)
    {
      return (int)us + i;
    }(3);
  }(7) - 10;
}
kernel void block_literal(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = func();
}
