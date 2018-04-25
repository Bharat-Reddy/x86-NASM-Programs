section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msga : db 'Number of A : '
la : equ $-msga
msge : db 'Number of E : '
le : equ $-msge
msgi : db 'Number of I : '
li : equ $-msgi
msgo : db 'Number of O : '
lo : equ $-msgo
msgu : db 'Number of U : '
lu : equ $-msgu
msg : db 'Total number of Vowels : '
l : equ $-msg
endl : db 10
lendl : equ $-endl
zero : db '0'
lz : equ $-zero

a : db 0
e : db 0
i : db 0
o : db 0
u : db 0
str_len : db 0
count : db 0

section .bss
check : resb 1
string : resb 50
temp : resb 1
num : resw 1
nod : resb 1
t : resb 1

section .text

global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; READING STRING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END READING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; COUNTING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi, string

counting:

mov byte[check], 0
mov al, byte[esi]
cmp al, 0
je end_counting

cmp al, 'a'
je add_a
cmp al, 'A'
je add_a
cmp al, 'e'
je add_e
cmp al, 'E'
je add_e
cmp al, 'i'
je add_i
cmp al, 'I'
je add_i
cmp al, 'o'
je add_o
cmp al, 'O'
je add_o
cmp al, 'u'
je add_u
cmp al, 'U'
je add_u
next:
cmp byte[check], 0
je stable
add byte[count], 1
stable:
add esi, 1
jmp counting

end_counting:
jmp skip

add_a:
add byte[a], 1
mov byte[check], 1
jmp next
add_e:
add byte[e], 1
mov byte[check], 1
jmp next
add_i:
add byte[i], 1
mov byte[check], 1
jmp next
add_o:
add byte[o], 1
mov byte[check], 1
jmp next
add_u:
add byte[u], 1
mov byte[check], 1
jmp next

skip:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END COUNTING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRINTING :;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov eax, 4
mov ebx, 1
mov ecx, msga
mov edx, la
int 80h

movzx ax, byte[a]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msge
mov edx, le
int 80h

movzx ax, byte[e]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msgi
mov edx, la
int 80h

movzx ax, byte[i]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msgo
mov edx, lo
int 80h

movzx ax, byte[o]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msgu
mov edx, lu
int 80h

movzx ax, byte[u]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, l
int 80h

movzx ax, byte[count]
mov word[num], ax
call print_number

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END PRINTING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
mov eax, 1
mov ebx, 0
int 80h

print_number:
pusha

zero_case:
cmp word[num], 0
jne continue
mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, lz
int 80h
jmp end_printing

continue:
mov byte[nod], 0
mov byte[t], 0

extracting:
cmp word[num], 0
je print_num
add byte[nod], 1
mov ax, word[num]
mov dx, 0
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extracting

print_num:
cmp byte[nod], 0
je end_printing
sub byte[nod], 1
pop dx
add dx, 30h
mov byte[t], dl

mov eax, 4
mov ebx, 1
mov ecx, t
mov edx, 1
int 80h
jmp print_num

end_printing:

popa
ret
