
# common packages
UBUNTU_PKG  = git make iverilog gtkwave snap

# default java runtime if no one found
ifeq (, $(shell which java))
UBUNTU_PKG += default-jre
endif

install_ubuntu:
	# common packages & java
	sudo apt install $(UBUNTU_PKG)
	# embedded toolchain is prefered
	# but it is not available in ubuntu 18.04 repo
	sudo apt install gcc-riscv64-unknown-elf || sudo apt install gcc-riscv64-linux-gnu

install_vscode:
	sudo snap install code --classic
	code --install-extension ms-vscode.cpptools
	code --install-extension zhwu95.riscv
	code --install-extension eirikpre.systemverilog

##################################################################################
# quartus install commands

QUARTUS_URL ?= http://download.altera.com/akdlm/software/acdsinst/20.1std/711/ib_tar/Quartus-lite-20.1.0.711-linux.tar

TMPDIR      ?= $(CURDIR)/tmp
QUARTUS_TAR ?= $(notdir $(QUARTUS_URL))
QUARTUS_PKG ?= $(TMPDIR)/$(QUARTUS_TAR)
QUARTUS_RUN ?= $(TMPDIR)/components/QuartusLiteSetup-20.1.0.711-linux.run
QUARTUS_PROFILE ?= /etc/profile.d/quartus.sh

# QUARTUS_DIR = /opt/altera/quartus_lite/20.1

QUARTUS_DIR ?= $(HOME)/intelFPGA_lite/20.1
QUARTUS_BIN ?= $(QUARTUS_DIR)/quartus/bin/quartus

clean:
	rm -rf $(TMPDIR)

$(TMPDIR):
	mkdir -p $(TMPDIR)

$(QUARTUS_PKG): $(TMPDIR)
	$(info # Quartus package download start)
	wget -O $@ $(QUARTUS_URL)
	$(info # Quartus package download end)

$(QUARTUS_RUN): $(QUARTUS_PKG)
	$(info # Quartus package unpack start)
	cd $(TMPDIR); tar -xf $(QUARTUS_PKG)
	$(info # Quartus package unpack end)

QUARTUS_RUN_OPT  = --unattendedmodeui minimal
QUARTUS_RUN_OPT += --mode unattended
QUARTUS_RUN_OPT += --disable-components arria_lite,max,modelsim_ae
QUARTUS_RUN_OPT += --accept_eula 1
QUARTUS_RUN_OPT += --installdir $(QUARTUS_DIR)

QUARTUS_LIBS = libc6:i386 libncurses5:i386 libxtst6:i386 libxft2:i386 libc6:i386 libncurses5:i386 \
			   libstdc++6:i386 lib32z1 lib32ncurses5 

$(QUARTUS_BIN): $(QUARTUS_RUN)
	$(info # Quartus package install start)
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install $(QUARTUS_LIBS)
	$(QUARTUS_RUN) $(QUARTUS_RUN_OPT)
	$(info # Quartus package install end)

$(QUARTUS_PROFILE):
	$(info # Quartus profile settings start)
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/quartus/bin' | sudo tee -a $@
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/modelsim_ase/bin' | sudo tee -a $@
	$(info # Quartus profile settings end)

test: $(QUARTUS_BIN)


install_quartus:
