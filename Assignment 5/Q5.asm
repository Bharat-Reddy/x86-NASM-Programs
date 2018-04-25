section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msg2 : db 'Enter the word to be replaced',10
l2 : equ $-msg2
msg3 : db 'Enter New word',10
l3 : equ $-msg3
nil : db 'NIL',10
lnil : equ $-nil

space : db ' '
ls : equ $-space

msg : db 'hi',10
l : equ $-msg
endl : db 10
lendl : equ $-endl

section .bss
string : resb 50
str_len : resb 1
old_word : resb 50
old_len : resb 1
new_word : resb 50
new_len : resb 1
temp : resb 1
i : resb 1
j : resb 1
t : resb 1
t_len : resb 1
start_i : resb 1
check : resb 1
p_temp : resb 1
p : resb 1
len : resb 1
s : resb 1

section .text
global _start:
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

mov byte[s], 0

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

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi, old_word
mov byte[old_len], 0

old_reading:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_old_reading
mov al, byte[temp]
mov byte[esi], al
add byte[old_len], 1
add esi, 1
jmp old_reading

end_old_reading:
mov byte[esi], '0'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi, new_word
mov byte[new_word], 0

new_reading:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_new_reading
mov al, byte[temp]
mov byte[esi], al
add byte[new_len], 1
add esi, 1
jmp new_reading

end_new_reading:
mov byte[esi], '0'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi, string
mov al, byte[str_len]
mov byte[t_len], al
mov byte[i], 0

add byte[t_len], 1

printing:
add byte[s], 1
cmp byte[t_len], 0
je end_printing
sub byte[t_len], 1


mov al, byte[esi]
cmp al, '0'
jne continue_foreward
mov al, byte[i]
add al, 1
mov byte[start_i], al
mov byte[check], 0
call check_equal
cmp byte[check], 0
je continue_foreward

;;;;;;;;;;;;
cmp byte[s], 1
je skip
pusha
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, ls
int 80h
popa
skip:
;;;;;;;;;;;;
call print_new
movzx eax, byte[old_len]
add eax, 1
add esi, eax
add byte[i], al
jmp printing

continue_foreward:
add byte[i], 1
mov al, byte[esi]
mov byte[p_temp], al
cmp byte[p_temp], '0'
jne pr
mov byte[p_temp], ' '
pr:
cmp byte[s], 1
je skip2
pusha
mov eax, 4
mov ebx, 1
mov ecx, p_temp
mov edx, 1
int 80h
popa
skip2:
add esi, 1
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


print_new:
pusha
mov esi, new_word
movzx edi, byte[new_len]

loop_printing:
cmp edi, 0
je end_loop_printing
sub edi, 1
mov al, byte[esi]
mov byte[p], al
pusha
mov eax, 4
mov ebx, 1
mov ecx, p
mov edx, 1
int 80h
popa
add esi, 1
jmp loop_printing

end_loop_printing:

popa
ret


check_equal:
pusha
mov byte[len], 0
mov byte[check], 1

mov esi, string
movzx edi, byte[start_i]
add esi, edi


calc:
mov al, byte[esi]
cmp al, '0'
je end_calc
add byte[len], 1
add esi, 1
jmp calc
end_calc:

mov al, byte[len]
cmp al, byte[old_len]
jne yahoo
mov byte[check], 1

mov esi, string
movzx eax, byte[start_i]
add esi, eax
mov edi, old_word
loop_checking:
cmp byte[len], 0
je end_loop_checking
sub byte[len], 1

mov al, byte[esi]
mov ah, byte[edi]
cmp al, ah
jne yahoo
add esi, 1
add edi, 1
jmp loop_checking

end_loop_checking:

jmp good
yahoo:
mov byte[check], 0
good:
popa
ret
















