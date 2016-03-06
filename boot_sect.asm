;
; Simple boot sector that prints a message to the screen using BIOS routine
;
[org 0x7c00]

mov bx, HELLO_MSG
call printstr

mov [BOOT_DRIVE], dl 		; BIOS stores our boot drive in DL , so it ’s
				; best to remember this for later.

mov bp, 0x8000			; Here we set our stack safely out of the
mov sp, bp			; way , at 0x8000

mov bx, 0x9000			; Load 3 sectors to 0x0000 ( ES ):0x9000 ( BX )
mov dh, 3			; from the boot disk.
mov dl, [BOOT_DRIVE]
call disk_load

mov bx, [0x9000]		; Print out the first loaded word , which
call printhex			; we expect to be 0xdada, stored

mov bx, [0x9000 + 512] 		; Also , print the first word from the
call printhex			; 2nd loaded sector : should be 0xface

mov bx, GOODBYE_MSG
call printstr

jmp $				; jump to the current address. meaning eternity.

%include "print.asm"
%include "disk.asm"

; util functions
printstr:
  call print_string 
  push bx
  mov bx, NL
  call print_string
  pop bx
  ret

printhex:
  call print_hex
  push bx
  mov bx, NL
  call print_string
  pop bx 
  ret

; Data
HELLO_MSG:
  db 'Hello World!!!', 0

GOODBYE_MSG:
  db 'Good Bye!!!', 0

NL:
  db 0x0a, 0x0d, 0

times 510-($-$$) db 0	; Padding with zeros
dw 0xaa55		; Magic number

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface

; Global variables
BOOT_DRIVE: db 0

