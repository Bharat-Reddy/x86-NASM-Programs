section .data
msg1 : db 'Enter coefficient of x^2',10
l1 : equ $-msg1

msg2 : db 'Enter coefficient of x',10
l2 : equ $-msg2

msg3 : db 'Enter constant term',10
l3 : equ $-msg3

format1 : db '%lf',0

format2 : db 'Determinant = %f',10,0

root1 : db 'Root 1 : %f',10,0
root2 : db 'Root 2 : %f',10,0

equal_root : db 'Root 1 = Root 2 = %f',10,0

img1 : db 'Root 1 = (%f) + i(%f)',10,0
img2 : db 'Root 2 = (%f) - i(%f)',10,0

section .bss

a : resq 1
b : resq 1
c : resq 1
det : resq 1
t : resw 1
ans1 : resq 1
ans2 : resq 1
r1 : resq 1
r2 : resq 1

section .text

global main:

extern scanf
extern printf

main:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

push a
push format1
call scanf


mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, l2
int 80h

push b
push format1
call scanf


mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, l3
int 80h

push c
push format1
call scanf

fld qword[b]
fmul st0
fstp qword[det]
fld qword[a]
fmul qword[c]

mov word[t], 4
fimul word[t]
fchs
fld qword[det]
fadd st1
fstp qword[det]
ffree st0

;;;;;;;;;;;;; DETERMINANT
push dword[det+4]
push dword[det]
push format2
call printf

fldz
fcomp qword[det]
fstsw ax
sahf
ja imaginary

sahf
je equal

realAndDistinct:

fld qword[a]
mov word[t], 2
fimul word[t]

fld qword[det]
fsqrt

fdiv st1
fstp qword[ans2]

fld qword[b]
fchs
fdiv st1
fstp qword[ans1]
ffree st0

fld qword[ans1]
fadd qword[ans2]
fstp qword[r1]

fld qword[ans1]
fsub qword[ans2]
fstp qword[r2]

push dword[r1+4]
push dword[r1]
push root1
call printf

push dword[r2+4]
push dword[r2]
push root2
call printf

jmp exit

equal:


fld qword[a]
mov word[t], 2
fimul word[t]

fld qword[det]
fsqrt

fdiv st1
fstp qword[ans2]

fld qword[b]
fchs
fdiv st1
fstp qword[ans1]
ffree st0

fld qword[ans1]
fadd qword[ans2]
fstp qword[r1]

push dword[r1+4]
push dword[r1]
push equal_root
call printf

jmp exit

imaginary:

fld qword[a]
mov word[t], 2
fimul word[t]

fld qword[det]
fchs
fsqrt

fdiv st1
fstp qword[ans2]

fld qword[b]
fchs
fdiv st1
fstp qword[ans1]
ffree st0

push dword[ans2+4]
push dword[ans2]
push dword[ans1+4]
push dword[ans1]
push img1
call printf

push dword[ans2+4]
push dword[ans2]
push dword[ans1+4]
push dword[ans1]
push img2
call printf


exit:
mov eax, 1
mov ebx, 0
int 80h













