section .data
msg1 : db 'Enter 10 numbers',10
l1 : equ $-msg1
ans : db 'Sum of Numbers : '
lans : equ $-ans
msg : db 'hi',10
l : equ $-msg
endl : db 10
lendl : equ $-endl

z : db '0'
lz : equ $-z

section .bss
num : resd 1
snum : resd 1
sq : resd 1
temp : resb 1
nod : resb 1
sum : resd 1
ptemp : resb 1

section .text

global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

mov esi, 10

sum_loop:
cmp esi, 0
je end_sum_loop
sub esi, 1

call read_num
mov eax, dword[num]
mov dword[snum], eax

call find_square
mov eax, dword[sq]
add dword[sum], eax
jmp sum_loop

end_sum_loop:

mov eax, dword[sum]
mov dword[num], eax
call print_num

mov eax, 4
mov ebx, 1
mov ecx ,endl
mov edx, lendl
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


find_square:
pusha

mov eax, dword[snum]
mov edx, 0
mov ebx, eax
mul ebx
mov dword[sq], eax

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

cmp dword[num], 0
jne extracting
mov eax, 4
mov ebx, 1
mov ecx, z
mov edx, lz
int 80h
jmp end_printing

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
























