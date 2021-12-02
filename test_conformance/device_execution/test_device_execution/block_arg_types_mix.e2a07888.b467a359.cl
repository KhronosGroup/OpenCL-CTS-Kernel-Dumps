
union number {
    long l;
    float f;
};
enum color {
    RED = 0,
    GREEN,
    BLUE
};
typedef int _INT ;
typedef char _ACHAR[3] ;
kernel void block_arg_types_mix(__global int* res)
{
  int (^kernelBlock)(_INT, _ACHAR, union number, enum color, int, int, int, int, int, int, int, int, int, int, int, int, int) =
    ^int(_INT bi, _ACHAR bch, union number bn, enum color bc, int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8,
      int i9, int i10, int i11, int i12, int i13)
  {
    return bi * bch[0] * bch[1] * bch[2] * bn.l * bc - i1 - i2 - i3 - i4 - i5 - i6 - i7 - i8 - i9 - i10 - i11 - i12 - i13;
  };
  size_t tid = get_global_id(0);
  res[tid] = -1;
  _INT x = -5;
  _ACHAR char_arr = { 1, 2, 3 };
  union number n;
  n.l = 4;
  enum color c = BLUE;
  res[tid] = kernelBlock(x,char_arr,n,c,1,2,3,4,5,6,7,8,9,10,11,12,13) + 331;
}
