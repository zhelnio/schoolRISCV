

install:
	# toolchain + simulator
	$(MAKE) install_tools
ifndef WSLENV
	# Visual Studio Code
	$(MAKE) install_vscode
	# Quartus
	$(MAKE) install_quartus
endif

APT_INSTALL = sudo apt-get --yes install

install_tools:
	# common packages
	$(APT_INSTALL) git make iverilog gtkwave
	# java
  ifeq (, $(shell which java))
	$(APT_INSTALL) default-jre
  endif
	# embedded toolchain is prefered
	# but it is not available in ubuntu 18.04 repo
	$(APT_INSTALL) gcc-riscv64-unknown-elf || $(APT_INSTALL) gcc-riscv64-linux-gnu

install_vscode:
  ifeq (, $(shell which code))
	$(APT_INSTALL) snap
	sudo snap install code --classic
  endif
	code --install-extension ms-vscode.cpptools
	code --install-extension zhwu95.riscv
	code --install-extension eirikpre.systemverilog

##################################################################################
# quartus install commands

QUARTUS_URL ?= http://download.altera.com/akdlm/software/acdsinst/20.1std/711/ib_tar/Quartus-lite-20.1.0.711-linux.tar

QUARTUS_TMP ?= tmp
QUARTUS_TAR ?= $(notdir $(QUARTUS_URL))
QUARTUS_RUN ?= $(QUARTUS_TMP)/components/QuartusLiteSetup-20.1.0.711-linux.run
QUARTUS_PROFILE ?= /etc/profile.d/quartus.sh

# QUARTUS_DIR = /opt/altera/quartus_lite/20.1
QUARTUS_DIR ?= $(HOME)/intelFPGA_lite/20.1

clean:
	rm -rf $(QUARTUS_TMP) $(QUARTUS_TAR)

QUARTUS_RUN_OPT  = --unattendedmodeui minimal
QUARTUS_RUN_OPT += --mode unattended
QUARTUS_RUN_OPT += --disable-components arria_lite,max,modelsim_ae
QUARTUS_RUN_OPT += --accept_eula 1
QUARTUS_RUN_OPT += --installdir $(QUARTUS_DIR)

QUARTUS_LIBS = libc6:i386 libncurses5:i386 libxtst6:i386 libxft2:i386 libc6:i386 libncurses5:i386 \
			   libstdc++6:i386 lib32z1 lib32ncurses5 

# Quartus package download
$(QUARTUS_TAR):
	wget -O $@ $(QUARTUS_URL)

install_quartus: $(QUARTUS_TAR)
	# Quartus package unpack
	tar -xf $(QUARTUS_TAR) -C $(QUARTUS_TMP)

	# Quartus package dependences install
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install $(QUARTUS_LIBS)

	# Quartus package install
	$(QUARTUS_RUN) $(QUARTUS_RUN_OPT)

	# Quartus profile settings
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/quartus/bin' | sudo tee -a $(QUARTUS_PROFILE)
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/modelsim_ase/bin' | sudo tee -a $(QUARTUS_PROFILE)
