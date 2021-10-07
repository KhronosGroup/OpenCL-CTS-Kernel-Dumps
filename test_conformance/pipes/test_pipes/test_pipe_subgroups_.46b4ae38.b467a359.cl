#pragma OPENCL EXTENSION cl_khr_subgroups : enable
__kernel void test_pipe_subgroups_divergence_write(__global int *src, __write_only pipe int out_pipe, __global int *active_work_item_buffer)
{
    int gid = get_global_id(0);
    reserve_id_t res_id; 

    if(get_sub_group_id() % 2 == 0)
    {
        active_work_item_buffer[gid] = 1;
        res_id = sub_group_reserve_write_pipe(out_pipe, get_sub_group_size());
        if(is_valid_reserve_id(res_id))
        {
            write_pipe(out_pipe, res_id, get_sub_group_local_id(), &src[gid]);
            sub_group_commit_write_pipe(out_pipe, res_id);
        }
    }
}

__kernel void test_pipe_subgroups_divergence_read(__read_only pipe int in_pipe, __global int *dst)
{
    int gid = get_global_id(0);
    reserve_id_t res_id; 

    if(get_sub_group_id() % 2 == 0)
    {
        res_id = sub_group_reserve_read_pipe(in_pipe, get_sub_group_size());
        if(is_valid_reserve_id(res_id))
        {
            read_pipe(in_pipe, res_id, get_sub_group_local_id(), &dst[gid]);
            sub_group_commit_read_pipe(in_pipe, res_id);
        }
    }
}
