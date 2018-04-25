section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msg2 : db 'Modified String : '
l2 : equ $-msg2

section .bss
string : resb 50
str_len : resb 1
temp : resb 1

section .text

global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

mov esi, string
mov byte[str_len], 0

reading:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_reading
pusha

cmp byte[temp], 'A'
jne continue
mov byte[temp], ''
jmp continue2
continue:
cmp byte[temp], 'I'
jne continue2
mov byte[temp], ''
continue2:
cmp byte[temp], 'a'
jne continue3
mov byte[temp], ''
continue3:
cmp byte[temp], 'i'
jne continue4
mov byte[temp], ''
continue4:
popa
add byte[str_len], 1
mov al, byte[temp]
mov byte[esi], al
add esi, 1
jmp reading

end_reading:

mov byte[esi], 0
mov esi, string
movzx ecx, byte[str_len]
printing:
cmp ecx, 0
je end_printing
sub ecx, 1
mov al, byte[esi]
mov byte[temp], al
pusha
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa
add esi, 1
jmp printing

end_printing:

exit:
mov eax, 1
mov ebx, 0
int 80h



























