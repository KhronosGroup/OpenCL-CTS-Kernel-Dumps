
        __kernel void test_pipe_convenience_write_long(__global long *src, __write_only pipe long out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_long(__read_only pipe long in_pipe, __global long *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        