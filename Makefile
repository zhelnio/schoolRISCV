

UBUNTU_PKG  = git iverilog gtkwave
ifeq (, $(shell which java))
UBUNTU_PKG += default-jre
endif
ifeq (, $(shell which snap))
UBUNTU_PKG += snap
endif
ifeq (, $(shell which riscv64-linux-gnu-gcc))
UBUNTU_PKG += gcc-riscv64-linux-gnu
endif

install_ubuntu:
	sudo apt install $(UBUNTU_PKG)

install_vscode:
	sudo snap install code --classic
	code --install-extension ms-vscode.cpptools
	code --install-extension zhwu95.riscv
	code --install-extension eirikpre.systemverilog
