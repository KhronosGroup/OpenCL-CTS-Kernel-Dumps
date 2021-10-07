
void block_fn(__global int* res, int level)
{
  size_t tid = get_global_id(0);
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(3);
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(res, level); };

  // Only 1 work-item enqueues block
  if(tid == 1)
  {
    res[tid]++;
    int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
  }
}

kernel void enqueue_nested_blocks_single(__global int* res, int level)
{
  block_fn(res, level);
}
