
        __kernel void test_pipe_convenience_write_long16(__global long16 *src, __write_only pipe long16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_long16(__read_only pipe long16 in_pipe, __global long16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        