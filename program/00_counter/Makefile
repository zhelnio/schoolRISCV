
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
