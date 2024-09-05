ASM_SRC_DIR := src
BUILD_DIR := build
ASM_FILES := $(wildcard $(ASM_SRC_DIR)/*.asm)
OBJ_FILES := $(patsubst $(ASM_SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(ASM_FILES))
OUTPUT := $(BUILD_DIR)/bootloader.bin

NASM := nasm
NASM_FLAGS := -f bin

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

all: $(BUILD_DIR) $(OUTPUT)

$(OUTPUT): $(OBJ_FILES)
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $(ASM_FILES)

$(BUILD_DIR)/%.o: $(ASM_SRC_DIR)/%.asm
	$(NASM) $(NASM_FLAGS) -o $@ $<

clean:
	rm -rf $(BUILD_DIR)

run: $(OUTPUT)
	qemu-system-x86_64 -drive format=raw,file=$(OUTPUT)

.PHONY: all clean run