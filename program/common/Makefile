
# Makefile example that can be used with common RISC-V toolchain

CROSS_COMPILE ?= riscv64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
OD = $(CROSS_COMPILE)objdump
OC = $(CROSS_COMPILE)objcopy

COMMON = $(CURDIR)/../common

# common targets
clean:
	rm -f *.elf *.dis *.mem *.hex

# software build
build: program.dis program.hex

program.elf: main.S
	$(CC) -o program.elf main.S -O0 -march=rv32i -mabi=ilp32 -nostdlib -T $(COMMON)/program.ld

program.dis: program.elf
	$(OD) -M no-aliases -Dz -j .text program.elf > program.dis

program.mem: program.elf
	$(OC) program.elf -O verilog program.mem

program.hex: program.mem
	$(COMMON)/hex32.py program.mem program.hex

# simulation in modelsim
modelsim: program.hex
	rm -rf sim
	mkdir sim
	cp program.hex sim/
	cd sim && vsim -novopt -do $(COMMON)/modelsim_script.tcl

# copy to board
board: program.hex
	cp ./program.hex ../../board/program

#########################################################
# Icarus verilog simulation

TOPMODULE=sm_testbench
IVARG = -g2005
IVARG += -D ICARUS
IVARG += -I ../
IVARG += -I ../../../src
IVARG += -I ../../../testbench
IVARG += -s $(TOPMODULE)
IVARG += ../../../src/*.v
IVARG += ../../../testbench/*.v

icarus:
	rm -rf sim
	mkdir sim
	cp *.hex sim
	cd sim && iverilog $(IVARG)
	cd sim && vvp -la.lst a.out -n
	
gtkwave:
	cd sim && gtkwave dump.vcd
