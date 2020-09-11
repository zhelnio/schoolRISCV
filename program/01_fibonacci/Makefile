# schoolRISCV program Makefile
#
# Stanislav Zhelnio, 2020
#

# default target to run when make is called without args
help:
	$(info make help     - show this message (default))
	$(info make clean    - delete folder with simulation data)
	$(info make rars     - run RISC-V CPU simulator)
	$(info make build    - create .hex program image)
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
#  java -jar ../common/rars1_4.jar & - run rars1_4.jar application using java machine
#									   in background
RARS = java -jar ../common/rars1_4.jar
rars:
	$(RARS) &

#########################################################
# software build
build: program.hex

# make program.hex - compile to hex memory image using RARS
#  java -jar ../common/rars1_4.jar nc a dump .text HexText program.hex main.S
#    java -jar ../common/rars1_4.jar - run rars1_4.jar application using java machine
#    nc                              - copyright notice will not be displayed
#    a                               - assemble only, do not simulate
#    dump .text HexText program.hex  - dump segment .text to program.hex file in HexText format
program.hex: main.S
	$(RARS) nc a dump .text HexText program.hex main.S

# make board - copy to board
#  copies program.hext to board/program where is will be searched with synthesis tools
board: program.hex
	cp ./program.hex ../../board/program

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
