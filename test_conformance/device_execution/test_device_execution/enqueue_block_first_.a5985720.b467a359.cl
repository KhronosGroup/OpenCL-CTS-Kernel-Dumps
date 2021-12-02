
void block_fn(uint num, __global int* res)
{
    size_t tid = get_global_id(0);

    for(int i = 1 ; i < tid ; i++)
    {
      for(int j = 0 ; j < num ; j++)
        atomic_add(res+tid, 1);
    }
}

kernel void enqueue_block_first_kernel(uint num, __global int* res)
{
  void (^kernelBlock)(void) = ^{ block_fn(num, res); };

  ndrange_t ndrange = ndrange_1D(num, 1);

  int enq_res = enqueue_kernel(get_default_queue(), CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[0] = -1; return; }

}
