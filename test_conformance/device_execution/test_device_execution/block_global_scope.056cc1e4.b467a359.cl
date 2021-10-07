
int __constant globalVar = 7;
int (^__constant globalBlock)(int) = ^int(int num)
{
   return globalVar * num * (1+ get_global_id(0));
};
kernel void block_global_scope(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = globalBlock(3) - 21*(tid + 1);
}
