;
; Simple boot sector that prints a message to the screen using BIOS routine
;

mov ah, 0x0e	; tele-type mode

; First attempt
mov al, the_secret
int 0x10

; Second attempt
mov al, [the_secret]
int 0x10

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Forth attempt
mov al, [0x7c1e]
int 0x10


jmp $		; jump to the current address. meaning eternity.

the_secret:
  db "X"


times 510-($-$$) db 0	; Padding with zeros

dw 0xaa55	; Magic number
