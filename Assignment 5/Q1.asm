section .data
msg1 : db 'Enter string',10
l1 : equ $-msg1
msg : db 'hi',10
le: equ $-msg
zero : db '0'
lz : equ $-zero
endl : db 10
lendl : equ $-endl

section .bss
string : resb 100
str_len : resb 1
temp : resb 1
t : resb 1
nod : resb 1
num : resw 1
i : resb 1
j : resb 1
indices : resb 100
ind_len : resb 1
a0 : resb 1
a1 : resb 1
max_count : resb 1
cur_count : resb 1
base : resd 1
l : resb 1
r : resb 1
k : resb 1
alpha : resb 100

section .text

global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

;;;;;;;;;;;;;;;;;;;;;;; Reading String ;;;;;;;;;;;;;;;;;;;;;;;

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END READING ;;;;;;;;;;;;;;;;;;;;;;;;;;;

movzx ecx, byte[str_len]
mov byte[i], 0
mov byte[j], 0
mov esi, string
mov edi, indices

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Capitals Indices ;;;;;;;;;;;;;;;;;;;;;;;;;

capital:
cmp byte[j], cl
jnb end_capital
add byte[j], 1

mov al, byte[esi]
cmp al, 'Z'
ja gotoend

mov bl, byte[j]
sub bl, 1
mov byte[edi], bl
add edi, 1
add byte[i], 1

gotoend:
add esi, 1
jmp capital

end_capital:

mov al, byte[i]
mov byte[ind_len], al

cmp al, 2
jnb goon

mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, lz
int 80h
jmp exit

goon:

mov byte[max_count], 0
mov byte[cur_count], 0
mov al, byte[ind_len]
sub al, 1
mov byte[j], 0
mov edi, indices
counting:
cmp byte[j], al
jnb end_counting
add byte[j], 1

mov byte[cur_count], 0

mov bl, byte[edi]
mov bh, byte[edi + 1]
mov byte[a0], bl
mov byte[a1], bh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call find_distinct

mov bx, word[num]
cmp bl, byte[max_count]
jna goforeward

mov byte[max_count], bl

goforeward:
add edi, 1
jmp counting

end_counting:

;add byte[max_count], 30h
;mov eax, 4
;mov ebx, 1
;mov ecx, max_count
;mov edx, 1
;int 80h

movzx ax, byte[max_count]
mov word[num], ax
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

find_distinct:
pusha
mov byte[num], 0

mov esi, alpha
mov edi, 0
set_zero:
cmp edi, 26
jnb end_set_zero
add edi, 1

mov byte[esi], 0
add esi, 1
jmp set_zero

end_set_zero:

mov bl, byte[a0]
mov bh, byte[a1]
add bl, 1
sub bh, 1
cmp bl, bh
jna toogood
mov word[num], 0
jmp end_final

toogood:
mov byte[l], bl
mov byte[r], bh


mov esi, string
mov edi, alpha
movzx ecx, byte[l]
add esi, ecx

main:
mov bl, byte[l]
cmp bl, byte[r]
ja end_main
add byte[l], 1

movzx eax, byte[esi]
sub eax, 97


mov byte[edi + eax], 1
add esi, 1
jmp main

end_main:

mov word[num], 0
mov esi, alpha
mov eax, 0
mov edx, 26
final:
cmp eax, edx
jnb end_final
add eax, 1

mov cl, byte[esi]
cmp cl, 0
jna donotadd
add word[num], 1

donotadd:
add esi, 1
jmp final

end_final:

popa
ret



print_num:

cmp word[num],0
je p

jmp L

p:
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,2
int 80h

L:

extract_no:
cmp word[num],0
je print_no
inc word[nod]
mov dx,0
mov ax,word[num]
mov cx,10
div cx
push dx
mov word[num],ax
jmp extract_no

print_no:
cmp word[nod],0
je end_print
dec word[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

jmp print_no
end_print:
ret

















