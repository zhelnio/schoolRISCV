# schoolRISCV board Makefile
# Stanislav Zhelnio, 2020

default: create

help:
	$(info make help   - show this message)
	$(info make all    - clean, create the board project and run the synthesis)
	$(info make clean  - delete synth folder)
	$(info make create - create the board project(default))
	$(info make open   - open the board project)
	$(info make build  - build the board project)
	$(info make load   - program the FPGA board)
	@true

CABLE_NAME   ?= "USB-Blaster"
PROJECT_NAME ?= $(notdir $(CURDIR))
PROJECT_DIR  ?= project

all: create build

clean:
	rm -rf $(PROJECT_DIR)

create: clean $(PROJECT_DIR)

$(PROJECT_DIR):
	mkdir  $(PROJECT_DIR)
	cp $(PROJECT_NAME).qpf_ $(PROJECT_DIR)/$(PROJECT_NAME).qpf
	cp $(PROJECT_NAME).qsf_ $(PROJECT_DIR)/$(PROJECT_NAME).qsf
	cp $(PROJECT_NAME).sdc_ $(PROJECT_DIR)/$(PROJECT_NAME).sdc

QUARTUS     := cd $(PROJECT_DIR) && quartus
QUARTUS_SH  := cd $(PROJECT_DIR) && quartus_sh
QUARTUS_PGM := cd $(PROJECT_DIR) && quartus_pgm

ifdef WSL_DISTRO_NAME
  QUARTUS     := $(QUARTUS).exe
  QUARTUS_SH  := $(QUARTUS_SH).exe
  QUARTUS_PGM := $(QUARTUS_PGM).exe
endif

open: $(PROJECT_DIR)
	$(QUARTUS) $(PROJECT_NAME).qpf &

build: $(PROJECT_DIR)
	$(QUARTUS_SH) --flow compile $(PROJECT_NAME)

load:
	$(QUARTUS_PGM) -c $(CABLE_NAME) -m JTAG -o "p;$(PROJECT_NAME).sof"
