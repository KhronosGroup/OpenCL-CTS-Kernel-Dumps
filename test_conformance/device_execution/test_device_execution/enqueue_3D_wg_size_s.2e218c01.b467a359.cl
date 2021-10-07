
void block_fn(int level, int maxGlobalWorkSize, __global int* rnd, __global int* res)
{
  size_t tidX = get_global_id(0);
  size_t tidY = get_global_id(1);
  size_t tidZ = get_global_id(2);
  size_t linearId = get_global_linear_id();
  queue_t def_q = get_default_queue();
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(level, maxGlobalWorkSize, rnd, res); };
  uint wg = get_kernel_work_group_size(kernelBlock);

  const size_t gs[] = { 4, 4, 4 };
  size_t ls[] = { 1, 1, rnd[tidZ % maxGlobalWorkSize] % wg % gs[2] };
  ls[2] = ls[2]? ls[2]: 1;
  
  ndrange_t ndrange = ndrange_3D(gs, ls);

  // Some work-items enqueues nested blocks with the same level
  if((tidX < (get_global_size(0) >> 1)) && 
    ((tidY < (get_global_size(1) >> 1)) || get_global_size(1) == 1) &&
    ((tidZ < (get_global_size(2) >> 1)) || get_global_size(2) == 1))
  {
    atomic_inc(&res[linearId % maxGlobalWorkSize]);
    int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[linearId % maxGlobalWorkSize] = -1; return; }
  }
}

kernel void enqueue_3D_wg_size_some_eq(__global int* res, int level, int maxGlobalWorkSize, __global int* rnd)
{
  block_fn(level, maxGlobalWorkSize, rnd, res);
}
