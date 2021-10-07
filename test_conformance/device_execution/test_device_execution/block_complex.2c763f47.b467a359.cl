
kernel void block_complex(__global int* res)
{
  int (^kernelBlock)(int) = ^(int num)
  {
    int result = 1;
    for (int i = 0; i < num; i++)
    {
      switch(i)
      {
      case 0:
      case 1:
      case 2:
        result += i;
        break;
      case 3:
        if (result < num)
          result += i;
        else
          result += i * 2;
        break;
      case 4:
        while (1)
        {
          result++;
          if (result)
            goto ret;
        }
        break;
      default:
        return 777;
      }
    }
    ret: ;
    while (num) {
      num--;
      if (num % 2 == 0)
        continue;
      result++;
    }
    return result;
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  res[tid] = kernelBlock(7) - 11;
}
