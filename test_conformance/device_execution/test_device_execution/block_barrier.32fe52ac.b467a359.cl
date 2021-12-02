
kernel void block_barrier(__global int* res)
{
  int b = 3;
  size_t tid = get_global_id(0);
  size_t lsz = get_local_size(0);
  size_t gid = get_group_id(0);
  size_t idx = gid*lsz;

  res[tid]=lsz;
  barrier(CLK_GLOBAL_MEM_FENCE);
  int (^kernelBlock)(int) = ^(int a)
  {
    atomic_dec(res+idx);
    barrier(CLK_GLOBAL_MEM_FENCE);
    return (int)abs(a - b) - (res[idx] != 0 ? 0 : 1);
  };

  int d = kernelBlock(2);
  res[tid] = d;
}
