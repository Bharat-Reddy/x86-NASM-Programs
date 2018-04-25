section .data

section .bss
string : resb 50
str_len : resb 1
temp : resb 1

section .text
global _start:
_start:
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
add byte[str_len], 1

mov al, byte[temp]
mov byte[esi], al
add esi, 1
jmp reading

end_reading:
mov byte[esi], 0
;jmp exit
mov esi, string
mov edi, esi
movzx ecx, byte[str_len]
add edi, ecx
sub edi, 1
movzx eax, byte[str_len]
mov edx, 0
mov ebx, 2
div ebx
mov ecx, eax
;jmp exit
reversing:
cmp ecx, 0
je end_reversing
sub ecx, 1

mov al, byte[esi]
mov ah, byte[edi]
mov byte[esi], ah
mov byte[edi], al
add esi, 1
sub edi, 1
jmp reversing

end_reversing:

mov esi, string
movzx ecx, byte[str_len]

printing:
cmp byte[str_len], 0
je end_printing
sub byte[str_len], 1

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









