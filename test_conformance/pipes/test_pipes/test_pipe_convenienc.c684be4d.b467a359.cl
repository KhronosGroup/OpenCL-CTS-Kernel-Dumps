
        __kernel void test_pipe_convenience_write_int16(__global int16 *src, __write_only pipe int16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_int16(__read_only pipe int16 in_pipe, __global int16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        