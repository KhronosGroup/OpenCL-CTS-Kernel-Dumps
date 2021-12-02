
        __kernel void test_pipe_convenience_write_ushort(__global ushort *src, __write_only pipe ushort out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ushort(__read_only pipe ushort in_pipe, __global ushort *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        