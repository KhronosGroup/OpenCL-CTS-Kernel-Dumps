
struct two_ints {
    short x;
    long y;
};
kernel void block_arg_pointer(__global int* res)
{
  int (^kernelBlock)(struct two_ints*, struct two_ints*, int*, int*) = 
    ^int(struct two_ints* bs1, struct two_ints* bs2, int* bi1, int* bi2)
  {
    return (*bs1).x * (*bs1).y * (*bs2).x * (*bs2).y * (*bi1) * (*bi2);
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  struct two_ints s[2];
  s[0].x = 4;
  s[0].y = 5;
  struct two_ints* ps = s + 1;
  (*ps).x = 6;
  (*ps).y = 7;
  int i = 2;
  int * pi = &i;
  res[tid] = kernelBlock(s,ps,&i,pi) - 3360;
}
