
        __kernel void test_pipe_convenience_write_int(__global int *src, __write_only pipe int out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_int(__read_only pipe int in_pipe, __global int *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        