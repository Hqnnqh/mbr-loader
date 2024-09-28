# mbr-loader

This project is a simple **legacy MBR BIOS bootloader**. It consists of a boot sector program written in assembly using NASM and a minimal kernel entry written in Rust. The bootloader follows the legacy Master Boot Record (MBR) format and can be run using QEMU for testing.

## Setup and Requirements

### Prerequisites

To compile and run the bootloader, you need the following tools installed:

1. **NASM**: The Netwide Assembler, used to assemble the bootloader code.
2. **QEMU**: A hardware emulator used to test the bootloader.

### Installation

To build and run mbr-loader, you need to have Rust installed. You can install Rust by following the instructions on the [official Rust website](https://www.rust-lang.org/).

1. Clone the repository:
```sh
    git clone https://github.com/Hqnnqh/mbr-loader.git
    cd mbr-loader
```

2. Build the bootloader:
```sh
    make all
```

3. Run the mbr-loader in QEMU:
```sh
    make run
```
