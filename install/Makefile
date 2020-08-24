
# small piece of Makefile magic to simplify HDL tools install

install:
	# toolchain + simulator
	$(MAKE) install_tools

ifdef WSL_DISTRO_NAME
	# WSL settings fix
	$(MAKE) install_wsl
endif

ifndef WSL_DISTRO_NAME
	# For Windows 10 this soft have to be installed on host system, not WSL guest
	# Visual Studio Code
	$(MAKE) install_vscode
	# Quartus
  ifeq (, $(shell which quartus))
	$(MAKE) install_quartus
  endif
endif

APT_INSTALL = sudo apt-get --yes install

install_tools:
	sudo apt update
	# common packages
	$(APT_INSTALL) git make iverilog gtkwave
	# default jre if no one found
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
			   libstdc++6:i386 
			   #lib32z1 lib32ncurses5-dev

QUARTUS_PROFILE = /etc/profile.d/quartus.sh

# Quartus package download
$(QUARTUS_TAR):
	wget -O $@ $(QUARTUS_URL)

install_quartus: $(QUARTUS_TAR)
	# Quartus package unpack
	mkdir -p $(QUARTUS_TMP)
	tar -xf $(QUARTUS_TAR) -C $(QUARTUS_TMP)

	# Quartus package dependences install
	sudo dpkg --add-architecture i386
	sudo apt update
	$(APT_INSTALL) $(QUARTUS_LIBS)

	# Quartus package install
	$(QUARTUS_RUN) $(QUARTUS_RUN_OPT)

	# Quartus profile settings
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/quartus/bin' | sudo tee -a $(QUARTUS_PROFILE)
	echo 'export PATH=$$PATH:$(QUARTUS_DIR)/modelsim_ase/bin' | sudo tee -a $(QUARTUS_PROFILE)

	# USB-Blaster udev rules
	sudo cp files/100-altera.rules /etc/udev/rules.d/
	sudo service udev restart

	# Change Modelsim default font settings & menus visibility
	cp files/.modelsim $(HOME)

##################################################################################
# quartus install commands
install_wsl:
	# change owner of files that were created by windows programs in WSL filesystem
	# from 'root' to WSL user
	sudo cp files/wsl.conf /etc/
	# WSL 1 profile settings to set DISPLAY for X apps
	sudo cp files/wsl.sh /etc/profile.d/
