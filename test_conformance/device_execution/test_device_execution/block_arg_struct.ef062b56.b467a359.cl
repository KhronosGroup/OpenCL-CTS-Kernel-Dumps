
struct two_ints {
    short x;
    long y;
};
struct two_structs {
    struct two_ints a;
    struct two_ints b;
};
kernel void block_arg_struct(__global int* res)
{
  int (^kernelBlock)(struct two_ints, struct two_structs) = ^int(struct two_ints ti, struct two_structs ts)
  {
    return ti.x * ti.y * ts.a.x * ts.a.y * ts.b.x * ts.b.y;
  };
  struct two_ints i;
  i.x = 2;
  i.y = 3;
  struct two_structs s;
  s.a.x = 4;
  s.a.y = 5;
  s.b.x = 6;
  s.b.y = 7;
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = kernelBlock(i,s) - 5040;
}
