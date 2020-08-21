# RISC-V simple counter program
#
# Stanislav Zhelnio, 2020
#

            .text

start:      mv a0, zero              # t0 = 0
counter:    addi a0, a0, 1           # t0 = t0 + 1
            beq zero, zero, counter  # if t0 == t1 then counter
