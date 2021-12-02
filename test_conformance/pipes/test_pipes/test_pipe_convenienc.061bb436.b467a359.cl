
        __kernel void test_pipe_convenience_write_uint8(__global uint8 *src, __write_only pipe uint8 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_uint8(__read_only pipe uint8 in_pipe, __global uint8 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        