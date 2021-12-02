
#define LOCAL_MEM_SIZE 10

void block_fn_local_arg1(size_t tid, int mul, __global int* res, __local int* tmp1, __local float4* tmp2)
{
  for(int i = 0; i < LOCAL_MEM_SIZE; i++)
  {
    tmp1[i]   = mul * 7 - 21;
    tmp2[i].x = (float)(mul * 7 - 21);
    tmp2[i].y = (float)(mul * 7 - 21);
    tmp2[i].z = (float)(mul * 7 - 21);
    tmp2[i].w = (float)(mul * 7 - 21);

    res[tid] += tmp1[i];
    res[tid] += (int)(tmp2[i].x+tmp2[i].y+tmp2[i].z+tmp2[i].w);
  }
  res[tid] += 2;
}

kernel void enqueue_block_with_local_arg2(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);

  void (^kernelBlock)(__local void*, __local void*) = ^(__local void* buf1, __local void* buf2)
    { block_fn_local_arg1(tid, multiplier, res, (local int*)buf1, (local float4*)buf2); };

  res[tid] = -2;
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock, (uint)(LOCAL_MEM_SIZE*sizeof(int)), (uint)(LOCAL_MEM_SIZE*sizeof(float4)));
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }
}
