section .data
msg1 : db 'Enter radius of circle: '
l1 : equ $-msg1
format1 : db '%lf',0
format2 : db 'Perimeter = %lf',10

section .bss
t : resd 1

section text

global main:

extern scanf
extern printf

main:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

call read_number

mov dword[t], 2

fldpi
fmul st1
ffree st1
;fadd st0
fimul dword[t]
call print_number

exit:
mov eax, 1
mov ebx, 0
int 80h

;;;;;;;; Read Number

read_number:
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

print_number:
push ebp

mov ebp, esp
sub esp, 8
fstp qword[ebp - 8]
push format2
call printf
mov esp, ebp

pop ebp
ret












