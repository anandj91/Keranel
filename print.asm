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

print_hex:
  pusha
  mov ah, 0x0e

  mov ch, '0'
  call print_char
  mov ch, 'x'
  call print_char
  mov cx, 0x04
  call print_hex_rec
  popa
  ret

print_hex_rec:
  mov al, 0x0f
  and al, bl
  call print_hex_char
  shr bx, 4
  
  sub cx, 0x01
  cmp cx, 0x00
  je exit
  jmp print_hex_rec

print_hex_char:
  add al, 0x30
  cmp al, 0x39
  jle print_it
  add al, 0x07		; Adjust the ASCII for alphabets
  print_it: 
    int 0x10
    ret  

exit:
  ret


