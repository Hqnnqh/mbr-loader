ASM_SRC_DIR := src/real_mode/
BUILD_DIR := build
OUTPUT := $(BUILD_DIR)/bootloader.bin
DISK := $(BUILD_DIR)/hdd.img

NASM := nasm
NASM_FLAGS := -f bin

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: all clean run

all: $(BUILD_DIR) $(OUTPUT)

$(OUTPUT): $(ASM_SRC_DIR)boot_sector.asm
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $<

clean:
	rm -rf $(BUILD_DIR)

run: all
	qemu-img create -f raw $(DISK) 10M
	dd if=$(OUTPUT) of=$(DISK) conv=notrunc
	qemu-system-i386 -drive format=raw,file=$(DISK),if=ide
