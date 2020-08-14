
COMMON = $(CURDIR)/../common
RARS = java -jar $(COMMON)/rars1_4.jar

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
