
        __kernel void test_pipe_convenience_write_uchar4(__global uchar4 *src, __write_only pipe uchar4 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_uchar4(__read_only pipe uchar4 in_pipe, __global uchar4 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        