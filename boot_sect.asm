;
; A boot sector that boots a C kernel in 32-bit protected mode
;
[org 0x7c00]

KERNEL_OFFSET equ 0x1000	; This is the memory offset to which we will load our kernel

  mov [BOOT_DRIVE], dl		; BIOS stores out boot drive in dl. So it's best to remember
				; this for later

  mov bp, 0x9000		; Set the stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string

  call load_kernel

  call switch_to_pm		; Note that we never return from here.

  jmp $				; jump to the current address. meaning eternity.

; Utils
%include "utils/print.asm"
%include "utils/disk.asm"
%include "utils/gdt.asm"
%include "utils/print_pm.asm"
%include "utils/switch_to_pm.asm"

[bits 16]
;load kernel

load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string

  mov bx, KERNEL_OFFSET
  mov dh, 2
  mov dl, [BOOT_DRIVE]
  call disk_load

  ret

[bits 32]
; This is where we arrive after switching to and initializing PM.

BEGIN_PM:

  mov ebx, MSG_PROT_MODE
  call print_string_pm		; Use our 32-bit print routine

  call KERNEL_OFFSET		; Start executing kernel code

  jmp $

BOOT_DRIVE:
  db 0

MSG_REAL_MODE:
  db "Started in 16-bit Real Mode", 0x0a, 0x0d, 0

MSG_PROT_MODE:
  db "Successfully landed in 32-bit Protected Mode", 0

MSG_LOAD_KERNEL:
  db "Loading kernel into memory.", 0x0a, 0x0d, 0

times 510-($-$$) db 0	; Padding with zeros
dw 0xaa55		; Magic number
