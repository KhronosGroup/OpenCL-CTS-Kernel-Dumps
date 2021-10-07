
        __kernel void test_pipe_convenience_write_double16(__global double16 *src, __write_only pipe double16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_double16(__read_only pipe double16 in_pipe, __global double16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        