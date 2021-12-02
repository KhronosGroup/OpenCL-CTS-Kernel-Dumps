
        __kernel void test_pipe_convenience_write_char(__global char *src, __write_only pipe char out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_char(__read_only pipe char in_pipe, __global char *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        