section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
space : db ' '
ls : equ $-space
msg : db 'hi',10
l : equ $-msg
endl : db 10
lendl : equ $-endl

section .bss
string : resb 50
str_len : resb 1
temp : resb 1
i : resb 1
j : resb 1
t : resb 1

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
mov byte[esi], '0'
add esi, 1
reading:
mov eax, 3
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_reading
add byte[str_len], 1

cmp byte[temp], ' '
jne itsOK
mov byte[temp], '0'
itsOK:

mov al, byte[temp]
mov byte[esi], al
add esi, 1
jmp reading

end_reading:

mov byte[esi], '0'


movzx ecx, byte[str_len]
mov esi, string
add esi, ecx
;add string, ecx
add ecx, 1
printing:
cmp ecx, 0
je end_printing
sub ecx, 1

mov al, byte[esi]
cmp al, '0'
jne continue1
pusha
add esi, 1
loop_print:
mov al, byte[esi]
cmp al, '0'
jne go
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, ls
int 80h
jmp end_loop_print

go:
mov byte[t], al
mov eax, 4
mov ebx, 1
mov ecx, t
mov edx, 1
int 80h
add esi, 1
jmp loop_print

end_loop_print:

popa

continue1:
sub esi, 1
jmp printing

end_printing:

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


