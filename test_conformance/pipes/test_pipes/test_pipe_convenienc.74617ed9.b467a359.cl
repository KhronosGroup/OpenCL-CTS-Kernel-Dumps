
        __kernel void test_pipe_convenience_write_ushort8(__global ushort8 *src, __write_only pipe ushort8 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ushort8(__read_only pipe ushort8 in_pipe, __global ushort8 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        