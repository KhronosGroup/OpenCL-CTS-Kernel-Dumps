
#define MAX_GWS 256

__global ulong value[MAX_GWS*2] = {0};

void block_fn(size_t tid, __global int* res)
{
    res[tid] = -2;
}

void check_res(size_t tid, const clk_event_t evt, __global int* res)
{
    capture_event_profiling_info (evt, CLK_PROFILING_COMMAND_EXEC_TIME, &value[tid*2]);

    if (value[tid*2] > 0 && value[tid*2+1] > 0) res[tid] =  0;
    else                                        res[tid] = -4;
    release_event(evt);
}

kernel void enqueue_block_capture_event_profiling_info_after_execution(__global int* res)
{
    size_t tid = get_global_id(0);

    res[tid] = -1;
    queue_t def_q = get_default_queue();
    ndrange_t ndrange = ndrange_1D(1);
    clk_event_t block_evt1;

    void (^kernelBlock)(void)  = ^{ block_fn (tid, res);                   };

    int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 0, NULL, &block_evt1, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

    void (^checkBlock) (void)  = ^{ check_res(tid, block_evt1, res);      };

    enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &block_evt1, NULL, checkBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -3; return; }
}
