section .data
msg1 : db 'Enter size of array',10
l1 : equ $-msg1

msg2 : db 'Enter array elements',10
l2 : equ $-msg2

msg3 : db 'Enter value of k',10
l3 : equ $-msg3

tes : db '--------------------',10
lt : equ $-tes

format1 : db '%lf',0

format2  db '%lf',10

section .bss

arr : resq 100
n : resw 1
n1 : resw 1
n2 : resw 1
i : resw 1
j : resw 1
k : resq 1
ki : resw 1
junk : resq 1

section .text

global main:

extern scanf
extern printf

;;;;;;;;;;;;;;; READ NUMBER

read_num:
push ebp

mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp - 8]
mov esp, ebp

pop ebp
ret

;;;;;;;;;;;;;;;;;; PRINT NUMBER

print_num:
push ebp

mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format2
call printf

mov esp, ebp

pop ebp
ret


main:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

call read_num

fistp word[n]
;ffree st0
;call print_num

mov ax, word[n]
mov word[n1], ax
mov word[n2], ax
mov word[i], ax
mov word[j], ax
;sub word[j], 1


mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h

mov ecx, arr
push ecx
reading:
cmp word[n1], 0
je end_reading
sub word[n1], 1

call read_num

pop ecx
fstp qword[ecx]
add ecx, 8
push ecx
jmp reading

end_reading:
pop ecx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h

call read_num
fstp qword[k]

;ffree st0
fld qword[k]
;call print_num
fstp qword[k]
mov esi, arr

i_loop:
cmp word[i], 0
je end_i_loop
sub word[i], 1

fld qword[esi]

mov edi, esi
add edi, 8

mov ax, word[j]
sub ax, 1
mov word[ki], ax

j_loop:
cmp word[ki], 0
jng end_j_loop
sub word[ki], 1
fld qword[edi]
;call print_num
;fistp qword[junk]
;call print_num
fadd st1
;call print_num
fld qword[k]
;call print_num
fsub st1
fldz
fcom st0, st1
fstsw ax
sahf
je print
comm:
;ffree st0
;ffree st1
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
add edi, 8
fld qword[esi]

jmp j_loop

print:
pusha
mov eax, 4
mov ebx, 1
mov ecx, tes
mov edx, lt
int 80h
popa
fld qword[edi]
call print_num
;fstp qword[junk]

fld qword[esi]
call print_num
pusha
mov eax, 4
mov ebx, 1
mov ecx, tes
mov edx, lt
int 80h
popa
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
fstp qword[junk]
jmp comm
;call print_num
end_j_loop:

sub word[j], 1
add esi, 8
;push ecx
jmp i_loop

end_i_loop:
jmp exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ecx, arr
push ecx
printing:
cmp word[n2], 0
je end_printing
sub word[n2], 1

pop ecx
fld qword[ecx]
add ecx, 8
push ecx

call print_num
ffree st0

jmp printing

end_printing:

exit:
mov eax, 1
mov ebx, 0
int 80h






