
        __kernel void test_pipe_convenience_write_uint(__global uint *src, __write_only pipe uint out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_uint(__read_only pipe uint in_pipe, __global uint *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        