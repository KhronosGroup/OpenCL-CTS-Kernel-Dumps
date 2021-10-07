
        __kernel void test_pipe_convenience_write_ulong16(__global ulong16 *src, __write_only pipe ulong16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ulong16(__read_only pipe ulong16 in_pipe, __global ulong16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        