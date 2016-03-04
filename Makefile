build: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.bin

clean:
	rm -f boot_sect.bin
