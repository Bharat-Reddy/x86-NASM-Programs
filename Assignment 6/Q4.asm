section .data
msg1 : db 'Enter value of n',10
l1 : equ $-msg1
endl : db 10
lendl : equ $-endl

section .bss
num : resd 1
temp : resb 1
nod : resb 1
ptemp : resb 1
n : resd 1
ans : resd 1
v0 : resd 1
ft : resd 1

section .text

global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

call read_num
mov eax, dword[num]
mov dword[n], eax

mov dword[ans], 1

call factorial

mov eax, dword[ans]
mov dword[num], eax

call print_num

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


factorial:
pusha

cmp dword[n], 0
jne continue

popa
ret

continue:

mov eax, dword[n]
mov ebx, dword[ans]
mov edx, 0
mul ebx
mov dword[ans], eax
sub dword[n], 1
call factorial

popa
ret


read_num:
pusha

mov dword[num], 0

reading:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_reading
cmp byte[temp], ' '
je end_reading

sub byte[temp], 30h

mov eax, dword[num]
mov edx, 0
mov ebx, 10
mul ebx
movzx ecx, byte[temp]
add eax, ecx
mov dword[num], eax
jmp reading

end_reading:

popa
ret


print_num:
pusha

mov byte[nod], 0

extracting:

cmp dword[num], 0
je print
add byte[nod], 1

mov eax, dword[num]
mov edx, 0
mov ebx, 10
div ebx
push edx
mov dword[num], eax
jmp extracting

print:

cmp byte[nod], 0
je end_printing
sub byte[nod], 1

pop edx
mov byte[ptemp], dl

add byte[ptemp], 30h
pusha
mov eax, 4
mov ebx, 1
mov ecx, ptemp
mov edx, 1
int 80h
popa

jmp print

end_printing:

popa
ret




















