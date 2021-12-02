
void block_fn(int len, __global atomic_uint* val)
{
  atomic_fetch_add_explicit(&val[(get_global_offset(0) + get_global_linear_id()) % len], 1u, memory_order_relaxed, memory_scope_device);
}

kernel void helper_ndrange_1d_ofs(__global int* res, uint n, uint len, __global uint* glob_size_arr, __global uint* loc_size_arr, __global atomic_uint* val,  __global uint* ofs_arr)
{
  size_t tid = get_global_id(0);
  void (^kernelBlock)(void) = ^{ block_fn(len, val); };

  for(int l = 0; l < n; l++)
  {
    for(int k = 0; k < n; k++)
    {
      for(int i = 0; i < n; i++)
      {
        if (glob_size_arr[i] >= loc_size_arr[k])
        {
          ndrange_t ndrange = ndrange_1D(ofs_arr[l], glob_size_arr[i], loc_size_arr[k]);
          int enq_res = enqueue_kernel(get_default_queue(), CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
          if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
        }
      }
    }
  }
}
