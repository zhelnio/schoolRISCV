

install_ubuntu:
	sudo apt install git iverilog gtkwave

ifeq (, $(shell which java))
	sudo apt install default-jre
endif

ifeq (, $(shell which code))
	sudo apt install snap
	sudo snap install code --classic
endif

ifeq (, $(shell which riscv64-linux-gnu-gcc))
	sudo apt install gcc-riscv64-linux-gnu
endif
