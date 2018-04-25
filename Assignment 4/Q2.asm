section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msg2 : db 'Palindrome',10
l2 : equ $-msg2
msg3 : db 'Not Palindrome',10
l3 : equ $-msg3

section .bss
string : resb 50
str_len : resb 1
check : resb 1
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
mov ebx, 1
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

mov esi, string
mov edi, esi
movzx edx, byte[str_len]
add edi, edx
sub edi, 1
movzx ecx, byte[str_len]
mov byte[check], 0
checking:
cmp ecx, 0
je end_loop
sub ecx, 1
mov al, byte[esi]
mov ah, byte[edi]
cmp al, ah
je continue
mov byte[check], 1
jmp end_loop
continue:
add esi, 1
sub edi, 1
jmp checking
end_loop:

cmp byte[check], 0
je palindrome

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h
jmp exit

palindrome:
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h
exit:
mov eax, 1
mov ebx, 0
int 80h

















