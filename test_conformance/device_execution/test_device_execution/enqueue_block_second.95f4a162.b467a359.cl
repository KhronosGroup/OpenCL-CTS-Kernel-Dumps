
void block_fn(uint num, __global int* res)
{
    for(int i = 2 ; i < num ; i++)
    {
      res[i] = res[i]/num - (i-1);
    }
}

kernel void enqueue_block_second_kernel(uint num, __global int* res)
{
  void (^kernelBlock)(void) = ^{ block_fn(num, res); };

  ndrange_t ndrange = ndrange_1D(1);

  int enq_res = enqueue_kernel(get_default_queue(), CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
  if(enq_res != CLK_SUCCESS) { res[0] = -1; return; }

}
