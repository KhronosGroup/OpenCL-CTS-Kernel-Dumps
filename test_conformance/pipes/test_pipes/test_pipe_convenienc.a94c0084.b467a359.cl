
        __kernel void test_pipe_convenience_write_ushort2(__global ushort2 *src, __write_only pipe ushort2 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ushort2(__read_only pipe ushort2 in_pipe, __global ushort2 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        