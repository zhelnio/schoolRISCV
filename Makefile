
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
