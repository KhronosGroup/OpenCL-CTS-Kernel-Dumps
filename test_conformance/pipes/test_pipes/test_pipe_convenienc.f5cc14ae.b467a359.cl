
        __kernel void test_pipe_convenience_write_uchar(__global uchar *src, __write_only pipe uchar out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_uchar(__read_only pipe uchar in_pipe, __global uchar *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        