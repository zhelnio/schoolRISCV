OUTPUT_ARCH(riscv)

/**** Start point ****/
hwreset = 0x0;
ENTRY(hwreset)

SECTIONS
{
  .text = .;

/*
    /DISCARD/ :
    {
      *(.MIPS.abiflags)
      *(.reginfo)
      *(.gnu.attributes)
    }
*/
}
