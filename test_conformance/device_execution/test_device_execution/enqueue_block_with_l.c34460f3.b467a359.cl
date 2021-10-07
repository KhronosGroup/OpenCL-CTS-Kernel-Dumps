
#define LOCAL_MEM_SIZE 10

void block_fn_local_arg1(size_t tid, int mul, __global int* res, __local int* tmp)
{
  for(int i = 0; i < LOCAL_MEM_SIZE; i++)
  {
    tmp[i] = mul * 7 - 21;
    res[tid] += tmp[i];
  }
  res[tid] += 2;
}

kernel void enqueue_block_with_local_arg1(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);

  void (^kernelBlock)(__local void*) = ^(__local void* buf){ block_fn_local_arg1(tid, multiplier, res, (local int*)buf); };

  res[tid] = -2;
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock, (uint)(LOCAL_MEM_SIZE*sizeof(int)));
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
}
