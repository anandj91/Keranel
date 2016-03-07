run: clean build 
	qemu-system-i386 -drive file=target/keranel.img,format=raw

build: build_boot_sect build_kernel
	cat target/boot_sect.bin target/kernel.bin > target/keranel.img
	dd if=/dev/zero count=20 >> target/keranel.img

build_boot_sect: init
	nasm boot_sect.asm -f bin -o target/boot_sect.bin

build_kernel: init
	nasm kernel/kernel_entry.asm -f elf -o target/kernel_entry.o
	gcc -ffreestanding -c kernel/kernel.c -o target/kernel.o
	ld -o target/kernel.bin -Ttext 0x1000 target/kernel.o --oformat binary

init:
	mkdir target

read: build
	od -t x1 -A n target/keranel.img

clean:
	rm -rf target
