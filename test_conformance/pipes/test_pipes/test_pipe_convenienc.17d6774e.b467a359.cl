typedef struct{
char    a;
int    b;
}TestStruct;
__kernel void test_pipe_convenience_write_struct(__global TestStruct *src, __write_only pipe TestStruct out_pipe)
{
    int gid = get_global_id(0);
    write_pipe(out_pipe, &src[gid]);
}

__kernel void test_pipe_convenience_read_struct(__read_only pipe TestStruct in_pipe, __global TestStruct *dst)
{
    int gid = get_global_id(0);
    read_pipe(in_pipe, &dst[gid]);
}
