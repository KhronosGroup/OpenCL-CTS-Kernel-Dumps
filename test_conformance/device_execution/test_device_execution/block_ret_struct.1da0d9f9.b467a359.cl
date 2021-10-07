
kernel void block_ret_struct(__global int* res)
{
  struct A {
      int a;
  };      
  struct A (^kernelBlock)(struct A) = ^struct A(struct A a)
  {        
    a.a = 6;
    return a;
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  struct A aa;
  aa.a = 5;
  res[tid] = kernelBlock(aa).a - 6;
}
