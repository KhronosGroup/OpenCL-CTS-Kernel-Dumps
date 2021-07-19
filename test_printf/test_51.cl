// Options: -cl-std=CL3.0
__kernel void test8(void) {
  long2 tmp = (long2)(12345678, 98765432);
  printf("%v2ld\n", tmp);
}
