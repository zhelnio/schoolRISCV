
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


install_quartus_download: $(QUARTUS_PKG)

$(QUARTUS_PKG):
	mkdir -p $(TMPDIR)
  ifeq (,$(wildcard $(QUARTUS_PKG)))
	# Quartus package download
	wget -O $@ $(QUARTUS_URL)
  endif

QUARTUS_RUN_OPT  = --unattendedmodeui minimal
QUARTUS_RUN_OPT += --mode unattended
QUARTUS_RUN_OPT += --disable-components arria_lite,max,modelsim_ae
QUARTUS_RUN_OPT += --accept_eula 1
QUARTUS_RUN_OPT += --installdir $(QUARTUS_DIR)

QUARTUS_LIBS = libc6:i386 libncurses5:i386 libxtst6:i386 libxft2:i386 libc6:i386 libncurses5:i386 \
			   libstdc++6:i386 lib32z1 lib32ncurses5 

install_quartus: $(QUARTUS_PKG)
	# Quartus package unpack
	cd $(TMPDIR); tar -xf $(QUARTUS_PKG)

	# Quartus package dependences install
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install $(QUARTUS_LIBS)

	# Quartus package install
	$(QUARTUS_RUN) $(QUARTUS_RUN_OPT)

	# Quartus profile settings
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/quartus/bin' | sudo tee -a $@
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/modelsim_ase/bin' | sudo tee -a $@
