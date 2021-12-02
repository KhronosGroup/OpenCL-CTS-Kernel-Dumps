
        __kernel void test_pipe_write_ulong2(__global ulong2 *src, __write_only pipe ulong2 out_pipe)
        {
            int gid = get_global_id(0);
            reserve_id_t res_id;

            res_id = reserve_write_pipe(out_pipe, 1);
            if(is_valid_reserve_id(res_id))
            {
                write_pipe(out_pipe, res_id, 0, &src[gid]);
                commit_write_pipe(out_pipe, res_id);
            }
        }

        __kernel void test_pipe_read_ulong2(__read_only pipe ulong2 in_pipe, __global ulong2 *dst)
        {
            int gid = get_global_id(0);
            reserve_id_t res_id;

            res_id = reserve_read_pipe(in_pipe, 1);
            if(is_valid_reserve_id(res_id))
            {
                read_pipe(in_pipe, res_id, 0, &dst[gid]);
                commit_read_pipe(in_pipe, res_id);
            }
        }
        