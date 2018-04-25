section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msg2 : db 'Max string : '
l2 : equ $-msg2
msg3 : db 'Min string : '
l3 : equ $-msg3
endl : db 10
lendl : equ $-endl
nil : db 'NIL',10
lnil : equ $-nil

section .bss
string : resb 50
str_len : resb 1
check : resb 1
temp : resb 1
i : resb 1
j : resb 1
t_si : resb 1
t_ei : resb 1
min_si : resb 1
min_ei : resb 1
max_si : resb 1
max_ei : resb 1
max_diff : resb 1
min_diff : resb 1
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
jne go
mov al, 0
mov byte[temp], al
go:

mov al, byte[temp]
mov byte[esi], al
add esi, 1
jmp reading

end_reading:

mov byte[esi], 0

cmp byte[str_len], 0
jne goAhead
mov eax, 4
mov ebx, 1
mov ecx, nil
mov edx, lnil
int 80h

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h
jmp exit
goAhead:

mov byte[t_si], 0
mov byte[t_ei], 0
mov byte[max_si], 0
mov byte[max_ei], 0
mov byte[min_si], 0
mov byte[min_ei], 0
mov byte[max_diff], 0
mov byte[min_diff], 9

movzx ecx, byte[str_len]
mov esi, string
mov byte[i], 0

i_loop:
cmp byte[i], cl
ja end_i_loop
push ecx
mov al, byte[esi]
cmp al, 0

jne continue


mov al, byte[i]
mov byte[t_ei], al
sub al, byte[t_si]
cmp al, byte[min_diff]
jnb continue1
mov byte[min_diff], al
mov al, byte[t_si]
mov byte[min_si], al
mov al, byte[t_ei]
mov byte[min_ei], al

continue1:

mov al, byte[t_ei]
sub al, byte[t_si]
cmp al, byte[max_diff]
jna offf
mov byte[max_diff], al
mov al, byte[t_si]
mov byte[max_si], al
mov al, byte[t_ei]
mov byte[max_ei], al

offf:
mov al, byte[i]
add al, 1
mov byte[t_si], al
continue:
pop ecx
add byte[i], 1
add esi, 1
jmp i_loop

end_i_loop:

mov esi, string
movzx edx, byte[min_si]
add esi, edx
mov edi, string
movzx edx, byte[min_ei]
add edi, edx

pusha
mov eax ,4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h
popa

printing_min_string:
cmp esi, edi
jnb end_minstring
mov al, byte[esi]
mov byte[t], al

mov eax, 4
mov ebx, 1
mov ecx, t
mov edx, 1
int 80h
add esi, 1
jmp printing_min_string

end_minstring:

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

mov esi, string
movzx edx, byte[max_si]
add esi, edx
mov edi, string
movzx edx, byte[max_ei]
add edi, edx

pusha
mov eax ,4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h
popa

printing_max_string:
cmp esi, edi
jnb end_maxstring
mov al, byte[esi]
mov byte[t], al

mov eax, 4
mov ebx, 1
mov ecx, t
mov edx, 1
int 80h
add esi, 1
jmp printing_max_string

end_maxstring:

mov eax, 4
mov ebx, 1
mov ecx, endl
mov edx, lendl
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h











