ASM=nasm
SRC_DIR=src
BUILD_DIR=build
QEMU=qemu-system-i386

all: $(BUILD_DIR)/sysastro.img

$(BUILD_DIR)/sysastro.img: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	cat $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin > $(BUILD_DIR)/sysastro.img
	truncate -s 1440k $(BUILD_DIR)/sysastro.img

$(BUILD_DIR)/boot.bin: $(SRC_DIR)/bootloader/boot.asm
	$(ASM) -f bin $< -o $@

$(BUILD_DIR)/kernel.bin: $(SRC_DIR)/kernel/kernel.asm
	$(ASM) -f bin $< -o $@

run: $(BUILD_DIR)/sysastro.img
	$(QEMU) -drive format=raw,file=$(BUILD_DIR)/sysastro.img,index=0,if=floppy

clean:
	rm -rf $(BUILD_DIR)/*.bin $(BUILD_DIR)/*.img