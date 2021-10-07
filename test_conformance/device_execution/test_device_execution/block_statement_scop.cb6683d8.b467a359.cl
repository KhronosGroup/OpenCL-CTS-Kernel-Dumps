
kernel void block_statement_scope(__global int* res)
{
  int multiplier = 0;
  size_t tid = get_global_id(0);
  res[tid] = -1;
  multiplier = 9;
  res[tid] = ^int(int num) { return multiplier * num; } (11) - 99;
}
