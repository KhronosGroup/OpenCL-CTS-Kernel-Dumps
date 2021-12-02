
void block_fn(size_t tid, int mul, __global int* res)
{
  res[tid] = mul * 7 - 21;
}

kernel void enqueue_block_get_kernel_work_group_size(__global int* res)
{
    int multiplier = 3;
    size_t tid = get_global_id(0);

    void (^kernelBlock)(void) = ^{ block_fn(tid, multiplier, res); };

    size_t local_work_size = get_kernel_work_group_size(kernelBlock);
    if (local_work_size <= 0){ res[tid] = -1; return; }
    size_t global_work_size = local_work_size * 4;

    res[tid] = -1;
    queue_t q1 = get_default_queue();
    ndrange_t ndrange = ndrange_1D(global_work_size, local_work_size);

    int enq_res = enqueue_kernel(q1, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
}