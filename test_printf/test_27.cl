// Options: -cl-std=CL3.0
__kernel void test2(void) { printf("%f\n", 1.0f / 0.0f); }
