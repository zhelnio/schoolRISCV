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

QUARTUS     := cd $(BUILD_DIR) && quartus
QUARTUS_SH  := cd $(BUILD_DIR) && quartus_sh
QUARTUS_PGM := cd $(BUILD_DIR) && quartus_pgm

ifdef WSLENV
  QUARTUS     := $(QUARTUS).exe
  QUARTUS_SH  := $(QUARTUS_SH).exe
  QUARTUS_PGM := $(QUARTUS_PGM).exe
endif

open: $(BUILD_DIR)
	$(QUARTUS) $(PROJECT_NAME).qpf &

build: $(BUILD_DIR)
	$(QUARTUS_SH) --flow compile $(PROJECT_NAME)

load:
	$(QUARTUS_PGM) -c $(CABLE_NAME) -m JTAG -o "p;$(PROJECT_NAME).sof"
