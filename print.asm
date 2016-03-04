;
; print_string is to print the string starts at address in bx
;

print_string:
  pusha
  mov ah, 0x0e
  call print_string_rec
  popa
  ret

print_string_rec:
  mov ch, [bx]
  cmp ch, 0x00
  je exit
  call print_char
  add bx, 0x1
  jmp print_string_rec

print_char:
  mov al, ch
  int 0x10
  ret

exit:
  ret


