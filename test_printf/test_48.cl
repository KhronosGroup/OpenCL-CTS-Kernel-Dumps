// Options: -cl-std=CL3.0
__kernel void test8(void) {
  uchar2 tmp = (uchar2)(0xFA, 0xFB);
  printf("%#v2hhx\n", tmp);
}
