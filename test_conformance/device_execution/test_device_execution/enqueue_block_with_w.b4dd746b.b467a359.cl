
#define LOCAL_MEM_SIZE 10
#define BLOCK_COMPLETED 1
#define BLOCK_SUBMITTED 2
#define BLOCK_STARTED   3
#define CHECK_SUCCESS   0

void block_fn_local_arg(size_t tid, int mul, __global int* res, __local int* tmp)
{
  res[tid] = BLOCK_STARTED;
  for(int i = 0; i < LOCAL_MEM_SIZE; i++)
  {
    tmp[i] = mul * 7 - 21;
    res[tid] += tmp[i];
  }
  if(res[tid] == BLOCK_STARTED) res[tid] = BLOCK_COMPLETED;
}

kernel void enqueue_block_with_wait_list_and_local_arg(__global int* res)
{
  int multiplier = 3;
  size_t tid = get_global_id(0);
  clk_event_t user_evt = create_user_event();

  res[tid] = BLOCK_SUBMITTED;
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);
  clk_event_t block_evt;
  int enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &user_evt, &block_evt, 
    ^(__local void* buf) {
       block_fn_local_arg(tid, multiplier, res, (__local int*)buf);
     }, LOCAL_MEM_SIZE*sizeof(int));
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

  retain_event(block_evt);
  release_event(block_evt);

  //check block is not started
  if(res[tid] == BLOCK_SUBMITTED)
  {
    clk_event_t my_evt;
    enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &block_evt, &my_evt, 
    ^{
       //check block is completed
       if(res[tid] == BLOCK_COMPLETED) res[tid] = CHECK_SUCCESS;
     });
    release_event(my_evt);
  }

  set_user_event_status(user_evt, CL_COMPLETE);

  release_event(user_evt);
  release_event(block_evt);
}
