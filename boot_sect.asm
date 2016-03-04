;
; Simple boot sector that prints a message to the screen using BIOS routine
;

mov ah, 0x0e	; tele-type mode

mov al, 'H'	; Setting 'H' for printing on the screen
int 0x10	; Giving 0x10 interrupt for printing the character in al registry
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $		; jump to the current address. meaning eternity.

times 510-($-$$) db 0	; Padding with zeros

dw 0xaa55	; Magic number
