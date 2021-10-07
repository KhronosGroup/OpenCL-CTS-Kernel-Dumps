
        __kernel void test_pipe_convenience_write_double4(__global double4 *src, __write_only pipe double4 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_double4(__read_only pipe double4 in_pipe, __global double4 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        