
kernel void block_arg_global_p(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  typedef __global int* int_ptr_to_global_t;
  int_ptr_to_global_t (^kernelBlock)(__global int*, int) =^ int_ptr_to_global_t (__global int* bres, int btid)
  {
    bres[tid] = 5;
    return bres;
  };
  res = kernelBlock(res, tid);
  res[tid] -= 5;
}
