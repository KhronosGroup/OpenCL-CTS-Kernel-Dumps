// Options: -cl-std=CL3.0
__kernel void test9(void) {
  local int x;
  x = (int)3;
  printf("%+d\n", x);
}
