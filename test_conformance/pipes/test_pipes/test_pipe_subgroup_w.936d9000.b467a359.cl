
        #pragma OPENCL EXTENSION cl_khr_subgroups : enable
        __kernel void test_pipe_subgroup_write_uint8(__global uint8 *src, __write_only pipe uint8 out_pipe)
        {
            int gid = get_global_id(0);
            reserve_id_t res_id;

            res_id = sub_group_reserve_write_pipe(out_pipe, get_sub_group_size());
            if(is_valid_reserve_id(res_id))
            {
                write_pipe(out_pipe, res_id, get_sub_group_local_id(), &src[gid]);
                sub_group_commit_write_pipe(out_pipe, res_id);
            }
        }

        __kernel void test_pipe_subgroup_read_uint8(__read_only pipe uint8 in_pipe, __global uint8 *dst)
        {
            int gid = get_global_id(0);
            reserve_id_t res_id;

            res_id = sub_group_reserve_read_pipe(in_pipe, get_sub_group_size());
            if(is_valid_reserve_id(res_id))
            {
                read_pipe(in_pipe, res_id, get_sub_group_local_id(), &dst[gid]);
                sub_group_commit_read_pipe(in_pipe, res_id);
            }
        }
        