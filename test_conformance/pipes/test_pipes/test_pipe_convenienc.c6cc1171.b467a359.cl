
        __kernel void test_pipe_convenience_write_ulong4(__global ulong4 *src, __write_only pipe ulong4 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ulong4(__read_only pipe ulong4 in_pipe, __global ulong4 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        