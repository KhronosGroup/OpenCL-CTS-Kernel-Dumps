// Options: -cl-std=CL3.0
__kernel void test8(void) {
  ushort2 tmp = (ushort2)(0x1234, 0x8765);
  printf("%#v2hx\n", tmp);
}
