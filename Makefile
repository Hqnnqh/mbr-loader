ASM_SRC_DIR := src
BUILD_DIR := build
OUTPUT := $(BUILD_DIR)/bootloader.bin

NASM := nasm
NASM_FLAGS := -f bin

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

all: $(BUILD_DIR) $(OUTPUT)

$(OUTPUT): $(ASM_SRC_DIR)/boot_sector.asm
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $<

clean:
	rm -rf $(BUILD_DIR)

run: $(OUTPUT)
	qemu-system-x86_64 -drive format=raw,file=$(OUTPUT)

.PHONY: all clean run
