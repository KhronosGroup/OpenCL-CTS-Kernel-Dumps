
        __kernel void test_pipe_convenience_write_float2(__global float2 *src, __write_only pipe float2 out_pipe)
        {
            int gid = get_global_id(0);
            write_pipe(out_pipe, &src[gid]);
        }

        __kernel void test_pipe_convenience_read_float2(__read_only pipe float2 in_pipe, __global float2 *dst)
        {
            int gid = get_global_id(0);
            read_pipe(in_pipe, &dst[gid]);
        }
        