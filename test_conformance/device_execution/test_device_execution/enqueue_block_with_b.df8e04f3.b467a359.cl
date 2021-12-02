
void block_fn(size_t tid, int mul, __global int* res)
{
  if(mul > 0) barrier(CLK_GLOBAL_MEM_FENCE);
  res[tid] = mul * 7 -21;
}

void loop_fn(size_t tid, int n, __global int* res)
{
  while(n > 0)
  {
    barrier(CLK_GLOBAL_MEM_FENCE);
    res[tid] = 0;
    --n;
  }
}

kernel void enqueue_block_with_barrier(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);
  queue_t def_q = get_default_queue();
  res[tid] = -1;
  size_t n = 256;

  void (^kernelBlock)(void) = ^{ block_fn(tid, multiplier, res); };

  ndrange_t ndrange = ndrange_1D(n);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

  void (^loopBlock)(void) = ^{ loop_fn(tid, n, res); };

  enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, loopBlock);
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
}
