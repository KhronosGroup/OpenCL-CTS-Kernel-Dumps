
        __kernel void test_pipe_convenience_write_uchar16(__global uchar16 *src, __write_only pipe uchar16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_uchar16(__read_only pipe uchar16 in_pipe, __global uchar16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        