section .data
msg1 : db 'Enter size of array',10
l1 : equ $-msg1
msg2 : db 'Enter elements of array',10
l2 : equ $-msg2
msg3 : db 'Sorted array ',10
l3 : equ $-msg3

format1 : db '%lf',0
format2 : db '%lf',10

section .bss
arr : resq 100
n : resw 1
n1 : resw 1
n2 : resw 1
i : resw 1
j : resw 1
k : resw 1

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

;;;;;;;;;;;;;;;;;;;;; MAIN
main:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

call read_num

fist word[n]
ffree st0

mov ax, word[n]
mov word[n1], ax
mov word[n2], ax
mov word[i], ax
mov word[j], ax
sub word[j], 1

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
;;;;;;;;;;;;; SORTING

i_loop:
cmp word[i], 0
je end_i_loop

mov ecx, arr
push ecx

mov ax, word[j]
mov word[k], ax

j_loop:
cmp word[k], 0
je end_j_loop

pop ecx
fld qword[ecx]
fld qword[ecx+8]

fcomp st1
fstsw ax
sahf

jb swap

poping:

ffree st0
ffree st1
add ecx, 8
push ecx

sub word[k], 1
jmp j_loop

swap:
fld qword[ecx]
fld qword[ecx+8]
fstp qword[ecx]
fstp qword[ecx+8]
jmp poping

end_j_loop:

sub word[i], 1
jmp i_loop

end_i_loop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h

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
