
        __kernel void test_pipe_convenience_write_ulong2(__global ulong2 *src, __write_only pipe ulong2 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ulong2(__read_only pipe ulong2 in_pipe, __global ulong2 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        