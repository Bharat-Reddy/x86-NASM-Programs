section .data
msg1 : db 'Enter value of n',10
l1 : equ $-msg1
endl : db 10
lendl : equ $-endl
z : db '0'
lz : equ $-z

section .bss
num : resd 1
nod : resb 1
sum : resd 1
a0 : resd 1
temp : resb 1
ptemp : resb 1
n : resd 1

section .text

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

mov dword[sum], 0
call addNumbers

mov eax, dword[sum]
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

;;;;;;;;;;;;;;;;;;; Function ;;;;;;;;;;;;;;;;;;;;;;;;;;

addNumbers:
pusha

cmp dword[n], 0
jne still_alive

popa
ret

still_alive:

mov eax, dword[n]
add dword[sum], eax
sub dword[n], 1
call addNumbers

popa
ret

;;;;;;;;;;;;;;;;;END FUNCTION ;;;;;;;;;;;;;;;;;;;;;;;;;



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
movzx ebx, byte[temp]
add eax, ebx
mov dword[num], eax
jmp reading

end_reading:

popa
ret


print_num:
pusha

cmp dword[num], 0
jne offf
mov eax, 4
mov ebx, 1
mov ecx, z
mov edx, lz
int 80h
jmp end_printing

offf:

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















