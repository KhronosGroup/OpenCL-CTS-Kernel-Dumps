
#define MAX_GWS 256

__global ulong value[MAX_GWS*2] = {0};

void block_fn(size_t tid, __global int* res)
{
    res[tid] = -2;
}

void check_res(size_t tid, const ulong *value, __global int* res)
{
    if (value[tid*2] > 0 && value[tid*2+1] > 0) res[tid] =  0;
    else                                        res[tid] = -4;
}

kernel void enqueue_block_capture_event_profiling_info_before_execution(__global int* res)
{
    int multiplier = 3;
    size_t tid = get_global_id(0);
    clk_event_t user_evt = create_user_event();

    res[tid] = -1;
    queue_t def_q = get_default_queue();
    ndrange_t ndrange = ndrange_1D(1);
    clk_event_t block_evt1;
    clk_event_t block_evt2;

    void (^kernelBlock)(void)  = ^{ block_fn (tid, res);                   };

    int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &user_evt, &block_evt1, kernelBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

    capture_event_profiling_info (block_evt1, CLK_PROFILING_COMMAND_EXEC_TIME, &value[tid*2]);

    set_user_event_status(user_evt, CL_COMPLETE);

    void (^checkBlock) (void)  = ^{ check_res(tid, &value, res);      };

    enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &block_evt1, &block_evt2, checkBlock);
    if(enq_res != CLK_SUCCESS) { res[tid] = -3; return; }

    release_event(user_evt);
    release_event(block_evt1);
    release_event(block_evt2);
}
