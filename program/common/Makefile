
# Makefile example that can be used with common RISC-V toolchain

default: build

help:
	$(info make help     - show this message)
	$(info make clean    - delete folder with simulation data)
	$(info make rars     - run RISC-V CPU simulator)
	$(info make build    - create .hex program image (default))
	$(info make board    - copy .hex to boards/program)
	$(info make modelsim - run simulation using modelsim)
	$(info make icarus   - run simulation using icarus verilog)
	$(info make gtkwave  - open icarus verilog simulation results in gtkwave)
	$(info make sim      - run simulation in modelsim (if installed) or using icarus)
	@true

COMMON = $(CURDIR)/../common

# common targets
clean:
	rm -f *.elf *.dis *.mem *.hex

# run rars
RARS = java -jar $(COMMON)/rars1_4.jar

rars:
	$(RARS)

# simulate with modelsim or icarus 
# if the first one is not found
DEFAULT_SIM = modelsim
ifeq (, $(shell which vsim))
  DEFAULT_SIM = icarus
endif

sim: $(DEFAULT_SIM)

#########################################################
# software build

# embedded toolchain is prefered
CROSS_COMPILE ?= riscv64-unknown-elf-
# but it is not available in ubuntu 18.04 repo
ifeq (, $(shell which $(CROSS_COMPILE)gcc))
 ifneq (, $(shell which riscv64-linux-gnu-gcc))
  CROSS_COMPILE = riscv64-linux-gnu-
 endif
endif

CC = $(CROSS_COMPILE)gcc
OD = $(CROSS_COMPILE)objdump
OC = $(CROSS_COMPILE)objcopy

build: program.dis program.hex

program.elf: main.S
	$(CC) -o $@ $^ -O0 -march=rv32i -mabi=ilp32 -nostdlib -T $(COMMON)/program.ld

program.dis: program.elf
	$(OD) -M no-aliases -Dz -j .text $< > $@

program.mem: program.elf
	$(OC) $< -O verilog $@

program.hex: program.mem
	$(COMMON)/hex32.py $< $@

# copy to board
board: program.hex
	cp $^ ../../board/program

#########################################################
# simulation in modelsim
modelsim: program.hex
	rm -rf sim
	mkdir sim
	cp $^ sim/
	cd sim && vsim -do ../../common/modelsim_script.tcl

#########################################################
# simulation in Icarus verilog

TOPMODULE=sm_testbench
IVARG = -g2005
IVARG += -D ICARUS
IVARG += -I ../
IVARG += -I ../../../src
IVARG += -I ../../../testbench
IVARG += -s $(TOPMODULE)
IVARG += ../../../src/*.v
IVARG += ../../../testbench/*.v

icarus: program.hex
	rm -rf sim
	mkdir sim
	cp $^ sim
	cd sim && iverilog $(IVARG)
	cd sim && vvp -la.lst a.out -n
	
gtkwave:
	cd sim && gtkwave dump.vcd
