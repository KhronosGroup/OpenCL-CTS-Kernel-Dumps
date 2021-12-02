#pragma OPENCL EXTENSION cl_khr_fp16 : enable

        __kernel void test_pipe_convenience_write_half2(__global half2 *src, __write_only pipe half2 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_half2(__read_only pipe half2 in_pipe, __global half2 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        