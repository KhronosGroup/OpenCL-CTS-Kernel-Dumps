
typedef int (^block1_t)(float, int); 
constant block1_t b1 = ^(float fi, int ii) { return (int)(ii + fi); };
typedef int (^block2_t)(float, int);
constant block2_t b2 = ^(float fi, int ii) { return (int)(ii + fi); };
typedef float (^block3_t)(int, int);
constant block3_t b3 = ^(int i1, int i2) { return (float)(i1 + i2); };
typedef int (^block4_t)(float, float);
kernel void block_typedef_mltpl_g(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  block4_t b4 = ^(float f1, float f2) { return (int)(f1 + f2); };
  res[tid] = b1(1.1, b2(1.1, 1)) - b4(b3(1,1), 1.1);
}
