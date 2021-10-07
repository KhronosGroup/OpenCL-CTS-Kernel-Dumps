
        __kernel void test_pipe_convenience_write_float16(__global float16 *src, __write_only pipe float16 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_float16(__read_only pipe float16 in_pipe, __global float16 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        