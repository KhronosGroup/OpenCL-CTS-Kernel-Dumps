
kernel void enqueue_block_with_mixed_events(__global int* res)
{
  int enq_res;
  size_t tid = get_global_id(0);
  clk_event_t mix_ev[3];
  mix_ev[0] = create_user_event();
  queue_t def_q = get_default_queue();
  ndrange_t ndrange = ndrange_1D(1);
  res[tid] = -2;

  enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, 1, &mix_ev[0], &mix_ev[1], ^{ res[tid]++; });
  if(enq_res != CLK_SUCCESS) { res[tid] = -1; return; }

  enq_res = enqueue_marker(def_q, 1, &mix_ev[1], &mix_ev[2]);
  if(enq_res != CLK_SUCCESS) { res[tid] = -3; return; }

  enq_res = enqueue_kernel(def_q, CLK_ENQUEUE_FLAGS_NO_WAIT, ndrange, sizeof(mix_ev)/sizeof(mix_ev[0]), mix_ev, NULL, ^{ res[tid]++; });
  if(enq_res != CLK_SUCCESS) { res[tid] = -4; return; }

  set_user_event_status(mix_ev[0], CL_COMPLETE);

  release_event(mix_ev[0]);
  release_event(mix_ev[1]);
  release_event(mix_ev[2]);
}
