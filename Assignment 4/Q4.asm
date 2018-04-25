section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1

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
;;;;;;;;;;;;;;;;;;;;;; READING ;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;; END READING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov esi, string
movzx edi, byte[str_len]

processing:
cmp edi, 0
je end_processing

sub edi, 1

mov al, byte[esi]
cmp al, 'a'
jnb small
cmp al, 'Z'
jna capital
next:
mov al, byte[temp]
mov byte[esi], al
add esi, 1
jmp processing

end_processing:
jmp gothere
small:
mov byte[temp], al
movzx eax, byte[temp]
sub eax, 'a'
add eax, 1
mov edx, 0
mov ebx, 26
div ebx
mov byte[temp], dl
add byte[temp], 'a'
jmp next

capital:
mov byte[temp], al
movzx eax, byte[temp]
sub eax, 'A'
add eax, 1
mov edx, 0
mov ebx, 26
div ebx
mov byte[temp], dl
add byte[temp], 'A'
jmp next

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRINTING ;;;;;;;;;;;;;;;;;;;;;;
gothere:
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END PRINTING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov eax, 1
mov ebx, 0
int 80h























