# Makefile example that can be used with common RISC-V toolchain
#
# Stanislav Zhelnio, 2020
#

# default target to run when make is called without args
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

# common targets

# make clean
#  delete all compilation products & folder with simulation data
clean:
	rm -rf sim
	rm -f *.elf *.dis *.mem *.hex

# make rars
#  java -jar ../common/rars1_4.jar
#  * run rars1_4.jar application using java machine
RARS = java -jar ../common/rars1_4.jar
rars:
	$(RARS)

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

#compile program
#  Makefile automatic variables:
#    $@ - The file name of the target of the rule (program.elf)
#    $^ - The names of all the prerequisites (main.S)
#  riscv64-unknown-elf-gcc    - run gcc compiler
#    -o program.elf           - output file
#    main.S                   - input file
#    -O0                      - disable optimization
#    -march=rv32i             - target architecture RISC-V, instruction set rv32i
#    -mabi=ilp32              - integer ABI (int, long, and pointers are all 32-bits long. 
#                               long long is a 64-bit type, char is 8-bit, and short is 16-bit)
#                               Details: https://www.sifive.com/blog/all-aboard-part-1-compiler-args
#    -nostdlib                - Do not use the standard system startup files or libraries when linking
#    -T ../common/program.ld  - Use program.ld as the linker script
program.elf: main.S
	$(CC) -o $@ $^ -O0 -march=rv32i -mabi=ilp32 -nostdlib -T ../common/program.ld

#disassemble program
#  Makefile automatic variables:
#    $@ - The file name of the target of the rule (program.dis)
#    $< - The name of the first prerequisite (program.elf)
#  riscv64-unknown-elf-objdump - display information from object files
#    -M no-aliases             - disassembler-options; Print the 'raw' instruction 
#                                mnemonic instead of some pseudo instruction mnemonic
#    -D                        - disassemble the contents of all sections
#    program.elf               - input file
#    > program.dis             - redirect output to program.dis
program.dis: program.elf
	$(OD) -M no-aliases -D $< > $@

# dump program to memory image HEX file
#  Makefile automatic variables:
#    $@ - The file name of the target of the rule (program.dis)
#    $< - The name of the first prerequisite (program.elf)
# riscv64-unknown-elf-objcopy - copy and translate object files
#    program.elf              - input file
#    -O verilog               - output format
#    program.mem              - output file
program.mem: program.elf
	$(OC) $< -O verilog $@

# convert 8-bit hex dump to 32-bit hex-dump
# can be skipped if *-objcopy supports '--verilog-data-width' option
program.hex: program.mem
	../common/hex32.py $< $@

# make board - copy to board
#  copies program.hext to board/program where is will be searched with sinthesys tools
board: program.hex
	cp $^ ../../board/program

#########################################################
# simulation in modelsim

# vsim - command to run Modelsim
VSIM := vsim
# when we run modelsim from WSL it can be installed on host W10
# it this case we have to add .exe to the executed binary name
ifdef WSL_DISTRO_NAME
 ifeq (, $(shell which $(VSIM)))
  VSIM := $(VSIM).exe
 endif
endif

# make modelsim - start simulation using modelsim
#    rm -rf sim; mkdir sim;               - recreate simulation folder
#    cp *.hex sim/                        - copy memory image (program.hex) inside it
#    cd sim && vsim                       - go to simulation folder and start modelsim
#    -do ../../common/modelsim_script.tcl - run modelsim_script.tcl with simulation commands
modelsim: program.hex
	rm -rf sim
	mkdir sim
	cp *.hex sim/
	cd sim && $(VSIM) -do ../../common/modelsim_script.tcl

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

# make icarus - run compilation using Icarus Verilog simulator
#    rm -rf sim; mkdir sim; - recreate simulation folder
#    cp *.hex sim/          - copy memory image (program.hex) inside it
#    cd sim && iverilog     - go to simulation folder and start Icarus Verilog compiler
#                             it will produced the compiled simulation script sim/a.out
#      -g2005                 - Verilog Specification version
#      -D ICARUS              - define ICARUS verilog macro (the same as `define)
#      -I ../                 - path to search for `include files
#      -s sm_testbench        - use sm_testbench as top level module
#      ../../../src/*.v       - complie all the verilog sources from ../../../src/ folder
#    cd sim && vvp          - go to simulation folder and start Icarus Verilog runtime engine
#      -n                     - makes $stop a synonym for $finish
#      -la.lst                - write log to file a.lst
#      a.out                  - run a.out simulation
icarus: program.hex
	rm -rf sim
	mkdir sim
	cp *.hex sim
	cd sim && iverilog $(IVARG)
	cd sim && vvp -n -la.lst a.out 

# make gtkwave - open Icarus Verilog simulation dump using gtkwave
gtkwave:
	cd sim && gtkwave dump.vcd

#########################################################
# simulate with modelsim or icarus 
# if the first one is not found
DEFAULT_SIM = modelsim
ifeq (, $(shell which $(VSIM)))
  DEFAULT_SIM = icarus
endif

sim: $(DEFAULT_SIM)
