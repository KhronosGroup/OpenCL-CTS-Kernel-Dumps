
kernel void block_access_volatile_data(__global int* res)
{
    int var1 = 7;
    int var2 = 11;
    volatile int var3 = 13;

    int (^ kernelBlock)(int) = ^int(int num)
    {
        int (^ nestedBlock)(int) = ^int (int num)
        {
            return var1 * num;
        };
        return var2 * nestedBlock(num);
    };
    size_t tid = get_global_id(0);
    res[tid] = tid + 1;
    res[tid] = kernelBlock(res[tid]);
    res[tid] = ^(int num){ return var3*num; }(res[tid]) - (7*11*13)*(tid + 1);
}
