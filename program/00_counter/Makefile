
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

# common targets
clean:
	rm -f *.elf *.dis *.mem *.hex

# run rars
RARS = java -jar ../common/rars1_4.jar

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
build: program.hex

# compile to hex memory image using RARS
program.hex: main.S
	$(RARS) nc a dump .text HexText program.hex main.S

# copy to board
board: program.hex
	cp ./program.hex ../../board/program

#########################################################
# simulation in modelsim

VSIM := vsim
ifdef WSL_DISTRO_NAME
VSIM := $(VSIM).exe
endif

modelsim: program.hex
	rm -rf sim
	mkdir sim
	cp program.hex sim/
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
	cp *.hex sim
	cd sim && iverilog $(IVARG)
	cd sim && vvp -la.lst a.out -n
	
gtkwave:
	cd sim && gtkwave dump.vcd
