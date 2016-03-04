;
; Simple boot sector that prints a message to the screen using BIOS routine
;
[ org 0x7c00 ]

mov ah, 0x0e	; tele-type mode

mov bp, 0x8000	; Setting the base of stack
mov sp, bp

push 'A'	; Pushing characters to the stack
push 'B'
push 'C'

pop bx		; we can only pop 16-bits, so pop to bx
mov al, bl	; then copy bl (8-bit) to al
int 0x10

pop bx		; we can only pop 16-bits, so pop to bx
mov al, bl	; then copy bl (8-bit) to al
int 0x10

mov al, [0x7ffe]; To prove our stack grows downwards from bp,
		; fetch the char at 0x8000 - 0x2 (ie, 16-bits)
int 0x10


jmp $		; jump to the current address. meaning eternity.


times 510-($-$$) db 0	; Padding with zeros

dw 0xaa55	; Magic number
