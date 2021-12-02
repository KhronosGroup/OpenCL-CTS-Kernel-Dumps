
    void block_fn(__global int* res, int level)
    {
      queue_t def_q = get_default_queue();
      if(--level < 0) return;
      void (^kernelBlock)(void) = ^{ block_fn(res, level); };
      ndrange_t ndrange = ndrange_1D(1);
      int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange, kernelBlock);
      if(enq_res != CLK_SUCCESS) { (*res) = -1; return; }
      else if(*res != -1) { (*res)++; }
    }
    kernel void enqueue_multi_level(__global int* res, int level)
    {
      *res = 0;
      block_fn(res, level);
    }