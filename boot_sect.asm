;
; Simple boot sector that prints a message to the screen using BIOS routine
;
[ org 0x7c00 ]

  mov bx, HELLO_MSG
  call print_string

  mov bx, GOODBYE_MSG
  call print_string

  mov bx, GOODBYE_MSG
  call print_hex

jmp $		; jump to the current address. meaning eternity.

%include "print.asm"

; Data
HELLO_MSG:
  db 'Hello World!!!', 0x0a, 0x0d, 0

GOODBYE_MSG:
  db 'Good Bye!!!', 0x0a, 0x0d, 0


times 510-($-$$) db 0	; Padding with zeros

dw 0xaa55	; Magic number

dw GOODBYE_MSG, 0
