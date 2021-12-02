
#define BLOCK_COMPLETED 1
#define BLOCK_SUBMITTED 2
#define CHECK_SUCCESS   0

kernel void enqueue_marker_with_user_event(__global int* res)
{
  size_t tid = get_global_id(0);
  uint multiplier = 7;

  clk_event_t user_evt = create_user_event();

  res[tid] = BLOCK_SUBMITTED;
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);

  clk_event_t marker_evt;
  clk_event_t block_evt;

  int enq_res = enqueue_marker(def_q, 1, &user_evt, &marker_evt);
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

  retain_event(marker_evt);
  release_event(marker_evt);

  enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &marker_evt, &block_evt, 
  ^{
     if(res[tid] == BLOCK_SUBMITTED) res[tid] = CHECK_SUCCESS;
   });

  //check block is not started
  if(res[tid] != BLOCK_SUBMITTED)  { res[tid] = -2; return; }

  set_user_event_status(user_evt, CL_COMPLETE);

  release_event(block_evt);
  release_event(marker_evt);
  release_event(user_evt);
}
