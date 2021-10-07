__kernel void test_pipe_write(__global int *src, __write_only pipe int out_pipe)
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

__kernel void test_pipe_query_functions(__write_only pipe int out_pipe, __global int *num_packets, __global int *max_packets)
{
    *max_packets = get_pipe_max_packets(out_pipe);
    *num_packets = get_pipe_num_packets(out_pipe);
}

__kernel void test_pipe_read(__read_only pipe int in_pipe, __global int *dst)
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
