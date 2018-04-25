section .text
global main
extern scanf
extern printf

print:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp-8]
push format2
call printf
mov esp, ebp
pop ebp
ret

read:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp-8]
mov esp, ebp
pop ebp
ret

main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

call read
fstp qword[x]
mov dword[count],2
fld qword[x]
fstp qword[xp]
mov dword[n],200
fld qword[x]
fstp qword[result]
fld1
fstp qword[fact]

sloop:
mov eax,dword[n]
cmp dword[count],eax
ja end
mov eax,dword[count]
mov edx,0
mov ebx,2
div ebx
mov dword[q],eax
cmp edx,0
je cont

fld qword[fact]
fimul dword[count]
fstp qword[fact]

fld qword[x]
fld qword[xp]
fmul ST1
fstp qword[xp]
fstp qword[num]

fld qword[fact]
fld qword[xp]
fdiv ST1

mov eax,dword[q]
mov edx,0
mov ebx,2
div ebx
cmp edx,1
je subt
adding:
fld qword[result]
fadd ST1
fstp qword[result]
fstp qword[num]
fstp qword[num]
inc dword[count]
jmp sloop

subt:

fld qword[result]
fsub ST1
fstp qword[result]
fstp qword[num]
fstp qword[num]
inc dword[count]
jmp sloop

cont:
fld qword[x]
fld qword[xp]
fmul ST1
fstp qword[xp]
fstp qword[num]

fld qword[fact]
fimul dword[count]
fstp qword[fact]

inc dword[count]
jmp sloop

end:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

fld qword[result]
call print

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,l3
int 80h

fld qword[x]
fsin
call print

exit:
mov eax,1
mov ebx,0
int 80h

section .data
format1: db "%lf",0
format2: db "%lf",10,0
msg1: db "Enter the value of X : ",10
l1: equ $-msg1
msg2: db "Series result is : ",10
l2: equ $-msg2
msg3: db "Processor result is : ",10
l3: equ $-msg3

section .bss
count:resd 1
x:resq 1
xp:resq 1
result:resq 1
fact:resq 1
n:resd 1
num:resq 1
q:resd 1
num2:resd 1

