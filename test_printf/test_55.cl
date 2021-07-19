// Options: -cl-std=CL3.0
__kernel void test9(void) {
  private int x;
  x = (int)-1;
  printf("%i\n", x);
}
