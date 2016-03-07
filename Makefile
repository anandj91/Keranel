KERNEL_DIR=kernel
BOOT_DIR=boot
DRIVER_DIR=driver

C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
C_HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}

run: keranel.img
	qemu-system-i386 -drive file=keranel.img,format=raw

build: keranel.img

keranel.img: ${BOOT_DIR}/boot_sect.bin kernel.bin
	cat $^ > $@
	dd if=/dev/zero count=20 >> $@

kernel.bin: ${KERNEL_DIR}/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${C_HEADERS}
	gcc -ffreestanding -c $^ -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

%.bin: %.asm
	nasm $< -f bin -o $@
	
read: kernel.bin
	ndisasm -b 32 $<

clean:
	rm *.bin *.img
	rm -f ${KERNEL_DIR}/*.o ${BOOT_DIR}/*.bin ${DRIVER_DIR}/*.o


