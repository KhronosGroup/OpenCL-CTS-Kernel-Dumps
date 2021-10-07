
#define BITS_DEPTH 28

void block_fn(__global int* array, int index, size_t ls, size_t gs, __global int* res)
{
  int val = 0;
  size_t lid = get_local_id(0);
  size_t tid = get_global_id(0);

  if(tid == 0)
  {
    if((index + 1) < BITS_DEPTH)
    {
      enqueue_kernel(get_default_queue(), CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange_1D(gs, ls), 
      ^{
         block_fn(array, index + 1, ls, gs, res);
       });
    }
  }

  array[index * gs + tid] = array[(index - 1) * gs + tid] + 1;

  if((index + 1) == BITS_DEPTH)
  {
    barrier(CLK_GLOBAL_MEM_FENCE);

    if(lid == 0)
    {
      size_t gid = get_group_id(0);
      res[gid] = 1;

      for(int j = 0; j < BITS_DEPTH; j++)
      {
        for(int i = 0; i < ls; i++)
        {
          if(array[j * gs + ls * gid + i] != ((ls * gid + i) + j))
          {
            res[gid] = 2;
            break;
          }
        }
      }
    }
  }
}

kernel void enqueue_flags_wait_kernel_simple(__global int* res, __global int* array)
{
  size_t ls  = get_local_size(0);
  size_t gs  = get_global_size(0);
  size_t tid  = get_global_id(0);

  res[tid] = 0;
  array[tid] = tid;

  if(tid == 0)
  {
    enqueue_kernel(get_default_queue(), CLK_ENQUEUE_FLAGS_WAIT_KERNEL, ndrange_1D(gs, ls), 
    ^{
       block_fn(array, 1, ls, gs, res);
     });
  }
}
