
# HDL tools install

Tools list:

* Intel Quartus Prime Lite & Mentor Modelsim ASE
* Icarus Verilog
* GTKWave
* RISC-V toolchain
* Visual Studio Code & extensions
* Make
* Git

Supported OS:

* Ubuntu 18.04
* Ubuntu 20.04
* Windows 10 2004

You can choose any way of installation:
1. Ubuntu automatic install (preferred)
1. Virtual machine with preinstalled HDL tools (Ubuntu)
1. Ubuntu manual install
1. Windows 10 install

## Ubuntu automatic install

[Installation example video](https://www.youtube.com/watch?v=dMqLNLOHOMg&list=PL7J5ZgBGsxn6rquSuWO07kUk_YJrQnXec)

1. Download schoolRISCV and launch installation

    ```bash
    sudo apt install make git
    git clone https://github.com/zhelnio/schoolRISCV
    cd schoolRISCV/install
    make install
    ```

1. Log out & log in again to apply profile settings changes

## Virtual machine with preinstalled HDL tools

[VM import example video](https://www.youtube.com/watch?v=qheliCHj1h4&list=PL7J5ZgBGsxn6rquSuWO07kUk_YJrQnXec)

1. Download & Install [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. Download virtual machine [image](https://yadi.sk/d/t6FUr7X0kmpSJg) (Ubuntu 18.04 or Ubuntu 20.04)
1. VirtualBox --> File --> Import Appliance
1. Select dowloaded virtual machine .OVA file --> Next --> Import
1. Log in into virtual machine
1. Open Terminal on schoolRISCV folder and run

    ```
    git pull
    ```

## Ubuntu manual install

1. common dev tools, open source simulator & waveform viewer

    ```bash
    sudo apt-get --yes install git make iverilog gtkwave
    ```

1. Download schoolRISCV

    ```bash
    git clone https://github.com/zhelnio/schoolRISCV
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
        sudo apt-get --yes install libc6:i386 libncurses5:i386 libxtst6:i386 libxft2:i386 libc6:i386 libncurses5:i386 libstdc++6:i386
        ```

    * download Quartus Prime Lite from https://fpgasoftware.intel.com/20.1/ (Edition: Lite -> Release: 20.1 -> Operation System: Linux -> Combined Files;)

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

    * copy **schoolRISCV/install/files/quartus.sh** to **/etc/profile.d/** to add Quartus & Modelsim binary to $PATH, replace **/home/user/intelFPGA_lite/20.1** with the actual one if required

        ```bash
        # /etc/profile.d/quartus.sh
        export PATH=$PATH:/home/user/intelFPGA_lite/20.1/quartus/bin
        export PATH=$PATH:/home/user/intelFPGA_lite/20.1/modelsim_ase/bin
        ```

    * copy Linux device manager settings file **schoolRISCV/install/files/100-altera.rules** to **/etc/udev/rules.d/**

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
1. Log out & log in again to apply profile settings changes

## Windows 10 install

[Installation example video](https://www.youtube.com/watch?v=ncTCohAgFPU&list=PL7J5ZgBGsxn6rquSuWO07kUk_YJrQnXec)

1. Install Ubuntu 18.04 or 20.04 on Windows Subsystem for Linux ([Guide](https://wiki.ubuntu.com/WSL))

    * Enabling WSL in Windows 10

        * Open the Start Menu and search **Turn Windows features on or off**
        * Select **Windows Subsystem for Linux**
        * Click OK
        * Restart your computer when prompted
        * download & install X-server to launch Linux GUI programs: https://sourceforge.net/projects/vcxsrv/

    * Installing Ubuntu on WSL via the Microsoft Store

        * Open the Microsoft Store
        * Search for "Ubuntu"
        * Install "Ubuntu 20.04 LTS"
        * Launch Ubuntu 20.04 LTS
        * Create new user and set its password

1. Automatic Ubuntu package install & settings update
    * Launch Ubuntu 20.04 LTS and use its command prompt to run automatic install

        ```bash
        sudo apt update
        sudo apt install make git
        git clone https://github.com/zhelnio/schoolRISCV
        cd schoolRISCV/install
        make install
        ```

1. **Or** Manual Ubuntu package install & settings update
    * common dev tools, open source simulator & waveform viewer

        ```bash
        sudo apt update
        sudo apt-get --yes install git make iverilog gtkwave
        ```

    * Java runtime environment (if not installed) to run RARS

        ```bash
        sudo apt-get --yes install default-jre
        ```

    * RISC-V toolchain

        ```bash
        # Ubuntu 18.04
        sudo apt-get --yes install gcc-riscv64-linux-gnu
        # Ubuntu 20.04
        sudo apt-get --yes install gcc-riscv64-unknown-elf
        ```

    * Download schoolRISCV

        ```bash
        git clone https://github.com/zhelnio/schoolRISCV
        ```

    * Change WSL settings:

        ```bash
	    # change owner of files that were created by windows programs in WSL filesystem
	    # from 'root' to WSL user
	    sudo cp schoolRISCV/install/files/wsl.conf /etc/
	    # WSL 1 profile settings to set DISPLAY for X apps
	    sudo cp schoolRISCV/install/files/wsl.sh /etc/profile.d/
        ```

1. Visual Studio Code
    * Download windows installer from https://code.visualstudio.com/Download
    * Install Visual Studio Code
    * Run Visual Studio Code
    * Install Extensions:
        * ms-vscode.cpptools
        * zhwu95.riscv
        * eirikpre.systemverilog
        * ms-vscode-remote.remote-wsl

1. Quartus Lite

    * download and install [7-zip](https://www.7-zip.org/download.html)
    * download Quartus Prime Lite installation package from https://fpgasoftware.intel.com/20.1/ (Edition: Lite -> Release: 20.1 -> Operation System: Windows -> Combined Files)
    * Extract downloaded **Quartus-lite-20.1.0.711-windows.tar** using 7-zip
    * launch the installation **Quartus-lite-20.1.0.711-windows/setup.bat**
    * select set of required options in the installer GUI:

        - Installation directory: C:\intelFPGA_lite\20.1
        - [x] Quartus Prime
        - [x] Quartus Prime Help
        - [x] Cyclone IV
        - [x] Cyclone V
        - [x] MAX 10 FPGA
        - [x] Modelsim Intel FPGA Starter Edition (Free)
        - Launch USB Blaster II driver installation

    * add Quartus & Modelsim binary to PATH Environment Variable:
        * System -> Advanced System Settings
        * Advanced -> Environment Variables -> User variables for user -> Path -> Edit
        * New -> Browse -> C:\intelFPGA_lite\20.1\quartus\bin64
        * New -> Browse -> C:\intelFPGA_lite\20.1\modelsim_ase\win32aloem (added by installer)

1. Sign out & log in again to apply profile settings changes
