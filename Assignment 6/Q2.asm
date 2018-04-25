section .data
msg1 : db 'Enter a number',10
l1 : equ $-msg1

ans : db 'Fibanocii ubers upto the given no ',10
lans : equ $-ans

space : db ' '
lspace : equ $-space
endl : db 10
lendl : equ $-endl
z : db '0'
lz : equ $-z
o : db '1'
lo : equ $-o

section .bss
num : resd 1
nod : resb 1
fib1 : resd 1
fib2 : resd 1
sum : resd 1
a0 : resd 1
a1 : resd 1
max : resd 1
fp : resd 1
temp : resb 1
ptemp : resb 1

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
mov dword[max], eax

;;;;;;;;;;;; base conditions ;;;;;;;;;;;;;;

cmp dword[max], 0
ja goAhead
mov eax, 4
mov ebx, 1
mov ecx, z
mov edx, lz
int 80h

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

jmp exit

goAhead:
cmp dword[max], 1
ja normal

mov eax, 4
mov ebx, 1
mov ecx, z
mov edx, lz
int 80h

mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, lspace
int 80h

mov eax, 4
mov ebx, 1
mov ecx, o
mov edx, lo
int 80h

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

jmp exit

;;;;;;;;;;; End base conditions ;;;;;;;;;;;
normal:


mov eax, 4
mov ebx, 1
mov ecx, z
mov edx, lz
int 80h

mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, lspace
int 80h

mov eax, 4
mov ebx, 1
mov ecx, o
mov edx, lo
int 80h

mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, lspace
int 80h

mov dword[fib1], 0
mov dword[fib2], 1

mov dword[a0], 0
mov dword[a1], 1


call fibo

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


fibo:
pusha

mov eax, dword[a0]
mov ebx, dword[a1]
add eax, ebx
cmp eax, dword[max]
jna continue

exit_base_condition:
popa
ret

continue:

mov dword[num], eax

call print_num

pusha
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, lspace
int 80h
popa

mov ebx, dword[a1]
mov dword[a0], ebx
mov dword[a1], eax
call fibo

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
movzx ebx, byte[temp]
add eax, ebx
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



























