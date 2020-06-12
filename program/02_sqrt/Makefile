
CROSS_COMPILE ?= riscv64-unknown-elf-

CC = $(CROSS_COMPILE)gcc
OD = $(CROSS_COMPILE)objdump
OC = $(CROSS_COMPILE)objcopy

COMMON = $(CURDIR)/../common

build: program.elf program.dis program.mem

clean:
	rm -f *.elf *.dis *.mem *.hex

program.elf: main.S
	$(CC) -o program.elf main.S -O0 -march=rv32i -mabi=ilp32 -nostdlib -T $(COMMON)/program.ld

program.dis: program.elf
	$(OD) -M no-aliases -Dz -j .text program.elf > program.dis

program.mem: program.elf
	$(OC) program.elf -O verilog program.mem
	cat program.mem | $(COMMON)/hex32.awk > program.hex

run:
	rm -rf sim
	mkdir sim
	cp program.hex sim/
	cd sim && vsim -novopt -do $(COMMON)/modelsim_script.tcl
