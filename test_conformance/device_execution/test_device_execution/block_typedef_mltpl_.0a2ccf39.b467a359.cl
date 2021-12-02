
kernel void block_typedef_mltpl_stmnt(__global int* res)
{
  size_t tid = get_global_id(0);
  res[tid] = -1;
  int a;
  do
  {
    typedef float (^blockf_t)(float);
    typedef int (^blocki_t)(int);
    const blockf_t blockF = ^(float bi) { return (float)(bi + 3.3); };
    const blocki_t blockI = ^(int bi) { return bi + 2; };
    if ((blockF(.0)-blockI(0)) > 0)
    {
      typedef uint (^block_t)(uint);
      const block_t nestedBlock = ^(uint bi) { return (uint)(bi + 4); };
      a = nestedBlock(1) + nestedBlock(2);
      break;
    }
  } while(1);  
  res[tid] = a - 11;
}
