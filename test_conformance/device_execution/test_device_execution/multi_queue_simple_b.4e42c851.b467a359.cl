
void block_fn(size_t tid, int mul, __global int* res)
{
  res[tid] = mul * 7 - 21;
}

kernel void multi_queue_simple_block2(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);

  void (^kernelBlock)(void) = ^{ block_fn(tid, multiplier, res); };

  res[tid] = -1;
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
}
