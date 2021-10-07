
constant int ci = 8;
kernel void block_arg_const_p(__global int* res)
{
  __constant int* (^kernelBlock)(__constant int*) = ^(__constant int* bpci)
  {
    return bpci;
  };
  constant int* pci = &ci;
  constant int* pci_check;
  pci_check = kernelBlock(pci);
  size_t tid = get_global_id(0);
  res[tid] = pci == pci_check ? 0 : -1;
}
