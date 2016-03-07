;
; Simple boot sector that prints a message to the screen using BIOS routine
;
[org 0x7c00]

  mov bp, 0x9000		; Set the stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string

  call switch_to_pm		; Note that we never return from here.

  jmp $				; jump to the current address. meaning eternity.

%include "utils/print.asm"
%include "utils/gdt.asm"
%include "utils/print_pm.asm"
%include "utils/switch_to_pm.asm"

[bits 32]
; This is where we arrive after switching to and initializing PM.

BEGIN_PM:

  mov ebx, MSG_PROT_MODE
  call print_string_pm		; Use our 32-bit print routine

  jmp $

MSG_REAL_MODE:
  db "Started in 16-bit Real Mode", 0

MSG_PROT_MODE:
  db "Successfully landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0	; Padding with zeros
dw 0xaa55		; Magic number
