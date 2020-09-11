# schoolRISCV board Makefile
#
# Stanislav Zhelnio, 2020
#

# default target to run when make is called without args
help:
	$(info make help   - show this message(default))
	$(info make all    - clean, create the board project and run the synthesis)
	$(info make clean  - delete synth folder)
	$(info make create - create the board project)
	$(info make open   - open the board project)
	$(info make build  - build the board project)
	$(info make load   - program the FPGA board)
	@true

CABLE_NAME   ?= "USB-Blaster"
PROJECT_NAME ?= $(notdir $(CURDIR))
PROJECT_DIR  ?= project

all: create build

# make clean
#  delete <project_dirname>
clean:
	rm -rf $(PROJECT_DIR)

# make create
#  delete and create <project_dirname>
create: clean $(PROJECT_DIR)

# make project
#  - if folder "project" does not exist
#  - create folder "project"
#  - copy all the project template files to new folder renaiming its extensions
$(PROJECT_DIR):
	mkdir  $(PROJECT_DIR)
	cp $(PROJECT_NAME).qpf_ $(PROJECT_DIR)/$(PROJECT_NAME).qpf
	cp $(PROJECT_NAME).qsf_ $(PROJECT_DIR)/$(PROJECT_NAME).qsf
	cp $(PROJECT_NAME).sdc_ $(PROJECT_DIR)/$(PROJECT_NAME).sdc

QUARTUS     := cd $(PROJECT_DIR) && quartus
QUARTUS_SH  := cd $(PROJECT_DIR) && quartus_sh
QUARTUS_PGM := cd $(PROJECT_DIR) && quartus_pgm

# when we run quartus bins from WSL it can be installed on host W10
# it this case we have to add .exe to the executed binary name
ifdef WSL_DISTRO_NAME
 ifeq (, $(shell which $(QUARTUS)))
  QUARTUS     := $(QUARTUS).exe
  QUARTUS_SH  := $(QUARTUS_SH).exe
  QUARTUS_PGM := $(QUARTUS_PGM).exe
 endif
endif

# make open
#  cd project && quartus <projectname> &
#     cd project            - go to project folder 
#	  &&                    - if previous command was successfull
#     quartus <projectname> - open <projectname> in quartus 
#     &                     - run previous command in shell background
open: $(PROJECT_DIR)
	$(QUARTUS) $(PROJECT_NAME) &

# make build
#  cd project && quartus_sh --flow compile <projectname>
#     cd project                              - go to project folder 
#     &&                                      - if previous command was successfull
#     quartus_sh --flow compile <projectname> - run quartus shell & perform basic compilation 
#                                               of <projectname> project
build: $(PROJECT_DIR)
	$(QUARTUS_SH) --flow compile $(PROJECT_NAME)

# make load
#  cd project && quartus_pgm -c "USB-Blaster" -m JTAG -o "p;<projectname>.sof"
#     cd project               - go to project folder 
#	  &&                       - if previous command was successfull
#     quartus_pgm              - launch quartus programmer
#     -c "USB-Blaster"         - connect to "USB-Blaster" cable
#     -m JTAG                  - in JTAG programming mode
#     -o "p;<projectname>.sof" - program (configure) FPGA with <projectname>.sof file
load:
	$(QUARTUS_PGM) -c $(CABLE_NAME) -m JTAG -o "p;$(PROJECT_NAME).sof"
