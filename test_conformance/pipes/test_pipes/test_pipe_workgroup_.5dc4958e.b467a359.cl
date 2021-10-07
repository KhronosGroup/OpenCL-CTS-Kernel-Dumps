
        __kernel void test_pipe_workgroup_write_float(__global float *src, __write_only pipe float out_pipe)
        {
            int gid = get_global_id(0);
            __local reserve_id_t res_id;

            res_id = work_group_reserve_write_pipe(out_pipe, get_local_size(0));
            if(is_valid_reserve_id(res_id))
            {
                write_pipe(out_pipe, res_id, get_local_id(0), &src[gid]);
                work_group_commit_write_pipe(out_pipe, res_id);
            }
        }

        __kernel void test_pipe_workgroup_read_float(__read_only pipe float in_pipe, __global float *dst)
        {
            int gid = get_global_id(0);
            __local reserve_id_t res_id;

            res_id = work_group_reserve_read_pipe(in_pipe, get_local_size(0));
            if(is_valid_reserve_id(res_id))
            {
                read_pipe(in_pipe, res_id, get_local_id(0), &dst[gid]);
                work_group_commit_read_pipe(in_pipe, res_id);
            }
        }
        