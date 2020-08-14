# schoolRISCV board Makefile
# Stanislav Zhelnio, 2020

help:
	$(info make help   - show this message)
	$(info make all    - clean, create the board project and run the synthesis)
	$(info make clean  - delete synth folder)
	$(info make create - create the board project)
	$(info make open   - open the board project)
	$(info make build  - build the board project)
	$(info make load   - program the FPGA board)
	@true

CABLE_NAME   ?= "USB-Blaster"
BUILD_DIR    ?= project
PROJECT_NAME ?= $(notdir $(CURDIR))

all: create build

clean:
	rm -rf $(BUILD_DIR)

create: clean $(BUILD_DIR)

$(BUILD_DIR):
	mkdir  $(BUILD_DIR)
	cp *.qpf $(BUILD_DIR)
	cp *.qsf $(BUILD_DIR)
	cp *.sdc $(BUILD_DIR)

open: $(BUILD_DIR)
	cd $(BUILD_DIR) && quartus $(PROJECT_NAME).qpf &

build: $(BUILD_DIR)
	cd $(BUILD_DIR) && quartus_sh --flow compile $(PROJECT_NAME)

load:
	cd $(BUILD_DIR) && quartus_pgm -c $(CABLE_NAME) -m JTAG -o "p;$(PROJECT_NAME).sof"
