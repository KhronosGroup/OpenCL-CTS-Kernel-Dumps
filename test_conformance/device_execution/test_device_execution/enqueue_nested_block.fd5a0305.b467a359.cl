
void block_fn(int level, __global int* res)
{
  size_t tid = get_global_id(0);
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(10);
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(level, res); };

  // Some work-items enqueues nested blocks with the same level
  if(tid < (get_global_size(0) >> 1))
  {
    atomic_inc(&res[tid]);
    int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
  }
}

kernel void enqueue_nested_blocks_some_eq(__global int* res, int level)
{
  block_fn(level, res);
}
