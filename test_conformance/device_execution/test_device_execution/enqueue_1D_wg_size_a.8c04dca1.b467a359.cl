
void block_fn(int level, int maxGlobalWorkSize, __global int* rnd, __global int* res)
{
  size_t tidX = get_global_id(0);
  queue_t def_q = get_default_queue();
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(level, maxGlobalWorkSize, rnd, res); };
  uint wg = get_kernel_work_group_size(kernelBlock);

  const size_t gs = 8;
  size_t ls = rnd[tidX % maxGlobalWorkSize] % wg % gs;
  ls = ls? ls: 1;

  ndrange_t ndrange = ndrange_1D(gs, ls);

  // All work-items enqueues nested blocks with the same level
  atomic_inc(&res[tidX % maxGlobalWorkSize]);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[tidX % maxGlobalWorkSize] = -1; return; }
}

kernel void enqueue_1D_wg_size_all_eq(__global int* res, int level, int maxGlobalWorkSize, __global int* rnd)
{
  block_fn(level, maxGlobalWorkSize, rnd, res);
}
