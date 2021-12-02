
        __kernel void test_pipe_convenience_write_float(__global float *src, __write_only pipe float out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_float(__read_only pipe float in_pipe, __global float *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        