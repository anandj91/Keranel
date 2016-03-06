[bits 32]

; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; print a null-terminated string pointed to by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY		; Set EDX to the start of vid mem.

print_string_pm_loop:
  mov al, [ebx]			; Store the char at EBX in AL
  mov ah, WHITE_ON_BLACK	; Store the attributes in AH

  cmp al, 0			; if (al == 0), at the end of string, so
  je print_string_pm_done	; jump to done

  mov [edx], ax			; Store attributes and char at current
				; character cell

  add ebx, 1			; Increment the EBX to the next character in string
  add edx, 2			; Move to next character in vid mem.

  jmp print_string_pm_loop	; loop around to print the next character

print_string_pm_done:
  popa
  ret
