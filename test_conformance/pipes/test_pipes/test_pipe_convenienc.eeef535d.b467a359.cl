
        __kernel void test_pipe_convenience_write_short(__global short *src, __write_only pipe short out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_short(__read_only pipe short in_pipe, __global short *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        