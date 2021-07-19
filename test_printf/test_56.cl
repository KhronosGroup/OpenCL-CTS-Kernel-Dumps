// Options: -cl-std=CL3.0
__kernel void test9(__global void *x, __global intptr_t *xAddr) {
  printf("%p\n", x);
  *xAddr = (intptr_t)x;
}
