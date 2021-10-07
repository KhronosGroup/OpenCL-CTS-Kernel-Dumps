
void block_fn(int level, int maxGlobalWorkSize, __global int* rnd, __global int* res)
{
  queue_t def_q = get_default_queue();
  size_t tidX = get_global_id(0);
  size_t tidY = get_global_id(1);
  size_t tidZ = get_global_id(2);
  size_t linearId = get_global_linear_id();
  if(--level < 0) return;

  void (^kernelBlock)(void) = ^{ block_fn(level, maxGlobalWorkSize, rnd, res); };
  uint wg = get_kernel_work_group_size(kernelBlock);

  ndrange_t ndrange;
  switch((linearId + level) % 3)
  {
    case 0:
      {
        const size_t gs = 2 * 2 * 2;
        size_t ls = rnd[tidX % maxGlobalWorkSize] % wg % gs;
        ls = ls? ls: 1;
        ndrange = ndrange_1D(gs, ls);
      }
      break;
    case 1:
      {
        const size_t gs[] = { 2, 2 * 2 };
        size_t ls[] = { 1, rnd[tidY % maxGlobalWorkSize] % wg % gs[1] };
        ls[1] = ls[1]? ls[1]: 1;
        ndrange = ndrange_2D(gs, ls);
      }
      break;
    case 2:
      {
        const size_t gs[] = { 2, 2, 2 };
        size_t ls[] = { 1, 1, rnd[tidZ % maxGlobalWorkSize] % wg % gs[2] };
        ls[2] = ls[2]? ls[2]: 1;
        ndrange = ndrange_3D(gs, ls);
      }
      break;
    default:
      break;
  }

  // All work-items enqueues nested blocks with the same level
  atomic_inc(&res[linearId % maxGlobalWorkSize]);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[linearId % maxGlobalWorkSize] = -1; return; }
}

kernel void enqueue_mix_wg_size_all_eq(__global int* res, int level, int maxGlobalWorkSize, __global int* rnd)
{
  block_fn(level, maxGlobalWorkSize, rnd, res);
}
