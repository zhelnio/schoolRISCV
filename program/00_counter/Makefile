
COMMON = $(CURDIR)/../common
RARS = java -jar $(CURDIR)/../../scripts/bin/rars1_4.jar

# common targets
clean:
	rm -f *.elf *.dis *.mem *.hex

# run rars
rars:
	$(RARS)

# software build
build: program.hex

# compile to hex memory image using RARS
program.hex: main.S
	$(RARS) nc a dump .text HexText program.hex main.S

# simulation in modelsim
modelsim: program.hex
	rm -rf sim
	mkdir sim
	cp program.hex sim/
	cd sim && vsim -novopt -do $(COMMON)/modelsim_script.tcl

# copy to board
board: program.hex
	cp ./program.hex ../../board/program


# CROSS_COMPILE ?= riscv64-unknown-elf-
#
# CC = $(CROSS_COMPILE)gcc
# OD = $(CROSS_COMPILE)objdump
# OC = $(CROSS_COMPILE)objcopy
#
# build: program.dis program.hex
#
# program.elf: main.S
# 	$(CC) -o program.elf main.S -O0 -march=rv32i -mabi=ilp32 -nostdlib -T $(COMMON)/program.ld
#
# program.dis: program.elf
# 	$(OD) -M no-aliases -Dz -j .text program.elf > program.dis
#
# program.mem: program.elf
# 	$(OC) program.elf -O verilog program.mem
#
# program.hex: program.mem
# 	cat program.mem | $(COMMON)/hex32.awk > program.hex