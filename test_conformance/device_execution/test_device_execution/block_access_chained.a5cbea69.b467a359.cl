
kernel void block_access_chained_data(__global int* res)
{
    int (^ kernelBlock)(int) = ^int(int num)
    {
        int var1 = 7;
        int var2 = 11;
        int var3 = 13;
        int (^ nestedBlock1)(int) = ^int (int num)
        {
            int (^ nestedBlock2) (int) = ^int (int num)
            {
                return var2 * ^(int num){ return var3*num; }(num);
            };
            return var1 * nestedBlock2(num);
        };
        return nestedBlock1(num);
    };
    size_t tid = get_global_id(0);
    res[tid] = tid + 1;
    res[tid] = kernelBlock(res[tid]) - (7*11*13)*(tid + 1);
}
