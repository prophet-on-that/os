BUILD-DIR := ../build/$(shell basename $$PWD)
ISO-DIR := $(BUILD-DIR)/iso
BOOT-DIR := $(ISO-DIR)/boot
GRUB-DIR := $(BOOT-DIR)/grub

.PHONY: all
all: $(BUILD-DIR)/os.bin

$(BUILD-DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD-DIR)

$(BUILD-DIR)/boot.o: boot.s | $(BUILD-DIR)
	$(AS) -o $@ $<

$(BUILD-DIR)/kernel.o: kernel.c | $(BUILD-DIR)
	$(CC) -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

$(BUILD-DIR)/os.bin: linker.ld $(BUILD-DIR)/boot.o $(BUILD-DIR)/kernel.o
	i686-elf-gcc -T $< -o $@ -ffreestanding -O2 -nostdlib $(filter-out $<,$^) -lgcc

$(GRUB-DIR):
	mkdir -p $@

$(BOOT-DIR)/os.bin: $(BUILD-DIR)/os.bin | $(GRUB-DIR)
	cp $< $@

$(GRUB-DIR)/grub.cfg: grub.cfg | $(GRUB-DIR)
	cp $< $@

$(BUILD-DIR)/os.iso: $(BOOT-DIR)/os.bin $(GRUB-DIR)/grub.cfg
	grub-mkrescue -o $@ $(ISO-DIR)

.PHONY: run
run: $(BUILD-DIR)/os.bin
	qemu-system-i386 -kernel $<

.PHONY: run-iso
run-iso: $(BUILD-DIR)/os.iso
	qemu-system-i386 -cdrom $<
