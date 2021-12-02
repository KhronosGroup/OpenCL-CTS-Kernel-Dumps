
        __kernel void test_pipe_convenience_write_ulong(__global ulong *src, __write_only pipe ulong out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_ulong(__read_only pipe ulong in_pipe, __global ulong *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        