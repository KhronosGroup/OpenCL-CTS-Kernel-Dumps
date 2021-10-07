
void block_fn(int level, int maxGlobalWorkSize, __global int* rnd, __global int* res)
{
  size_t tidX = get_global_id(0);
  size_t tidY = get_global_id(1);
  size_t linearId = get_global_linear_id();
  queue_t def_q = get_default_queue();
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(level, maxGlobalWorkSize, rnd, res); };
  uint wg = get_kernel_work_group_size(kernelBlock);

  const size_t gs[] = { 8, 8 };
  size_t ls[] = { 1, rnd[tidY % maxGlobalWorkSize] % wg % gs[1] };
  ls[1] = ls[1]? ls[1]: 1;
  
  ndrange_t ndrange = ndrange_2D(gs, ls);

  // Some work-items enqueues nested blocks with different levels
  if((tidX % 2) == 0 && (tidY % 2) == 0)
  {
    atomic_inc(&res[linearId % maxGlobalWorkSize]);
    if(level >= tidX && level >= tidY)
    {
      int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
      if(enq_res != CLK_SUCCESS) { res[linearId % maxGlobalWorkSize] = -1; return; }
    }
  }
}

kernel void enqueue_2D_wg_size_some_diff(__global int* res, int level, int maxGlobalWorkSize, __global int* rnd)
{
  block_fn(level, maxGlobalWorkSize, rnd, res);
}
