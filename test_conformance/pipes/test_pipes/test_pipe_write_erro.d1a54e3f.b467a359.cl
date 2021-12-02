__kernel void test_pipe_write_error(__global int *src, __write_only pipe int out_pipe, __global int *status)
{
    int gid = get_global_id(0);
    int reserve_idx;
    reserve_id_t res_id;

    res_id = reserve_write_pipe(out_pipe, 1);
    if(is_valid_reserve_id(res_id))
    {
        write_pipe(out_pipe, res_id, 0, &src[gid]);
        commit_write_pipe(out_pipe, res_id);
    }
    else
    {
        *status = -1;
    }
}

__kernel void test_pipe_read_error(__read_only pipe int in_pipe, __global int *dst, __global int *status)
{
    int gid = get_global_id(0);
    int reserve_idx;
    reserve_id_t res_id;

    res_id = reserve_read_pipe(in_pipe, 1);
    if(is_valid_reserve_id(res_id))
    {
        read_pipe(in_pipe, res_id, 0, &dst[gid]);
        commit_read_pipe(in_pipe, res_id);
    }
    else
    {
        *status = -1;
    }
}
