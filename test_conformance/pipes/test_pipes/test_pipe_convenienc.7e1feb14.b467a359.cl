
        __kernel void test_pipe_convenience_write_double(__global double *src, __write_only pipe double out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_double(__read_only pipe double in_pipe, __global double *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        