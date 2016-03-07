run: clean build 
	qemu-system-i386 -drive file=target/keranel.img,format=raw

build: assemble compile
	cat target/boot_sect.bin target/kernel.bin > target/keranel.img
	dd if=/dev/zero count=20 >> target/keranel.img

assemble: init
	nasm boot_sect.asm -f bin -o target/boot_sect.bin

compile: init
	gcc -ffreestanding -c kernel/kernel.c -o target/kernel.o
	ld -o target/kernel.bin -Ttext 0x1000 target/kernel.o --oformat binary

init:
	mkdir target

read: build
	od -t x1 -A n target/keranel.img

clean:
	rm -rf target
