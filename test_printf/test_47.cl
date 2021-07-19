// Options: -cl-std=CL3.0
__kernel void test8(void) {
  float4 tmp = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
  printf("%2.2v4hlf\n", tmp);
}
