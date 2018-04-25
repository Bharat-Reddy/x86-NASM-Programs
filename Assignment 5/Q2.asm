section .data
msg1 : db 'Enter a string',10
l1 : equ $-msg1
msg2 : db 'Yes',10
l2 : equ $-msg2
msg3 : db 'No',10
l3 : equ $-msg3
nil : db 'NIL',10
lnil : equ $-nil

section .bss
string : resb 50
str_len : resb 1
check : resb 1
temp : resb 1
a0 : resb 1
a1 : resb 1
v0 : resb 1
i : resb 1
j : resb 1
len : resb 1
ans : resb 1
l : resb 1
r : resb 1
diff : resb 1

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

cmp byte[str_len], 0
jne goAhead
mov eax, 4
mov ebx, 1
mov ecx, nil
mov edx, lnil
int 80h
jmp exit

goAhead:

mov byte[i], 0
mov byte[j], 0
mov byte[ans], 0
mov byte[diff], 0
i_loop:
mov al, byte[str_len]
cmp byte[i], al
jnb end_i_loop
mov al, byte[i]
mov byte[j], al
add byte[j], 1
j_loop:
mov al, byte[str_len]
cmp byte[j], al
jnb end_j_loop

mov al, byte[i]
mov byte[a0], al
mov al, byte[j]
mov byte[a1], al
call check_palindrome
cmp byte[v0], 0
je continue1
mov byte[ans], 1
mov al, byte[a1]
sub al, byte[a0]
cmp al, byte[diff]
jna continue1

mov byte[diff], al
mov al, byte[a0]
mov ah, byte[a1]
mov byte[l], al
mov byte[r], ah


continue1:
add byte[j], 1
jmp j_loop

end_j_loop:

add byte[i], 1
jmp i_loop

end_i_loop:

cmp byte[ans], 1
je go_to_yes
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h
jmp exit

go_to_yes:

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h


mov esi, string
movzx eax, byte[l]
add esi, eax
movzx eax, byte[r]
mov edi, string
add edi, eax

loop_again:
cmp esi, edi
ja end_loop_again

mov dl, byte[esi]
mov byte[temp], dl
pusha
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa
add esi ,1
jmp loop_again

end_loop_again:


exit:
mov eax, 1
mov ebx, 0
int 80h


check_palindrome:
pusha
mov byte[v0],1
mov esi, string
mov edi, string
movzx eax, byte[a0]
add esi, eax
movzx eax, byte[a1]
add edi, eax
movzx eax, byte[a1]
movzx ebx, byte[a0]
sub eax, ebx
mov byte[len], al

checking:
cmp byte[len], 0
je end_checking
sub byte[len], 1

mov al, byte[esi]
mov ah, byte[edi]
cmp al, ah
je continue3
mov byte[v0], 0
jmp end_checking

continue3:
add esi, 1
sub edi, 1
jmp checking

end_checking:

popa
ret

















