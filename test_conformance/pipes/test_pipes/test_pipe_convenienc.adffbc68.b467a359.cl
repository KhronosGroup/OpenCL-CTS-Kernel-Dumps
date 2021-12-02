#pragma OPENCL EXTENSION cl_khr_fp16 : enable

        __kernel void test_pipe_convenience_write_half(__global half *src, __write_only pipe half out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_half(__read_only pipe half in_pipe, __global half *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        