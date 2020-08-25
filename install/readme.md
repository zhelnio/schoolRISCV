
# HDL tools install

Supported OS:

* Ubuntu 18.04
* Ubuntu 20.04
* Windows 10 2004

## Ubuntu automatic install

```bash
sudo apt install make git
git clone https://github.com/zhelnio/schoolRISCV
cd schoolRISCV/install
make install
```

## Ubuntu manual install

1. common dev tools, open source simulator & waveform viewer

    ```bash
    sudo apt-get --yes install git make iverilog gtkwave
    ```

1. Java runtime environment (if not installed) to run RARS

    ```bash
    sudo apt-get --yes install default-jre
    ```

1. RISC-V toolchain

    ```bash
    # Ubuntu 18.04
    sudo apt-get --yes install gcc-riscv64-linux-gnu
    # Ubuntu 20.04
    sudo apt-get --yes install gcc-riscv64-unknown-elf
    ```

1. Visual Studio Code & extensions

    ```bash
    sudo apt-get --yes install snap
    sudo snap install code --classic
    code --install-extension ms-vscode.cpptools
    code --install-extension zhwu95.riscv
    code --install-extension eirikpre.systemverilog
    ```

1. Quartus Lite
    * install Quartus dependency packages

        ```bash
        sudo dpkg --add-architecture i386
        sudo apt update
        sudo apt-get --yes install libc6:i386 libncurses5:i386 libxtst6:i386 libxft2:i386 libc6:i386        libncurses5:i386 libstdc++6:i386 
        ```

    * download Quartus Lite 20.1 from https://fpgasoftware.intel.com/20.1/
    * unpack .tar & run installation

        ```bash
        tar -xf Quartus-lite-20.1.0.711-linux.tar
        ./setup.sh
        ```

    * select set of required options in the installer GUI:

        - Installation directory: /home/user/intelFPGA_lite/20.1
        - [x] Quartus Prime
        - [x] Quartus Prime Help
        - [x] Cyclone IV
        - [x] Cyclone V
        - [x] MAX 10 FPGA
        - [x] Modelsim Intel FPGA Starter Edition (Free)

    * copy **files/quartus.sh** to **/etc/profile.d/** to add Quartus & Modelsim binary to $PATH, replace **/home/user/intelFPGA_lite/20.1** with the actual one if required

        ```bash
        # /etc/profile.d/quartus.sh
        export PATH=$PATH:/home/user/intelFPGA_lite/20.1/quartus/bin
        export PATH=$PATH:/home/user/intelFPGA_lite/20.1/modelsim_ase/bin
        ```

    * copy Linux device manager settings file **files/100-altera.rules** to **/etc/udev/rules.d/**

        ```bash
        # /etc/udev/rules.d/100-altera.rules
        # USB-Blaster
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE:="0666", SYMLINK+="usbblaster/%k"
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE:="0666", SYMLINK+="usbblaster/%k"
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE:="0666", SYMLINK+="usbblaster/%k"

        # USB-Blaster II
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE:="0666", SYMLINK+="usbblaster2/%k"
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE:="0666", SYMLINK+="usbblaster2/%k"
        ```

    * restart Linux device manager

        ```bash
        sudo service udev restart
        ```

    * copy **files/.modelsim** to **/home/user** to change default Modelsim font settings

## Windows 10 install


