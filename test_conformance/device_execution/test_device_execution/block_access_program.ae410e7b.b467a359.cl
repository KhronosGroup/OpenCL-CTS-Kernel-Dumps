
int __constant globalVar1 = 7;
int __constant globalVar2 = 11;
int __constant globalVar3 = 13;
int (^__constant globalBlock)(int) = ^int(int num)
{
    return globalVar1 * num;
};
kernel void block_access_program_data(__global int* res)
{
    int (^ kernelBlock)(int) = ^int(int num)
    {
        return globalVar2 * num;
    };
    size_t tid = get_global_id(0);
    res[tid] = tid + 1;
    res[tid] = globalBlock(res[tid]);
    res[tid] = kernelBlock(res[tid]);
    res[tid] = ^(int num){ return globalVar3*num; }(res[tid]) - (7*11*13)*(tid + 1);
}
