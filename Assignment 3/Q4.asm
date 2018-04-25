section .data
msg1: db 'Enter the number of rows: '
size1: equ $-msg1
msg2: db 'Enter the number of columns: '
size2: equ $-msg2
msg3: db 'Enter the elements of the array: ',0Ah
size3: equ $-msg3
space: db ' '
size_: equ $-space
newline: db 10

section .bss
num: resw 1
temp: resw 1
m: resw 1
n: resw 1
temp1: resw 1
temp2: resw 1
flag: resw 1
matrix: resw 50
nod: resw 1
t: resd 1
zero: resw 1

section .text
global _start:
_start:

mov word[zero],0
add word[zero],30h

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

call read_num
mov ax,word[num]
mov word[n],ax
mov word[temp1],ax

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h

call read_num
mov ax,word[num]
mov word[m],ax
mov word[temp2],ax

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
int 80h

mov edi,matrix

i_loop:
mov ax,word[m]
mov word[temp2],ax

j_loop:
call read_num
mov ax,word[num]
mov word[edi],ax
add edi,2
dec word[temp2]
cmp word[temp2],0
ja j_loop

dec word[temp1]
cmp word[temp1],0
ja i_loop

mov ax,word[m]
mov word[temp2],ax
mov ax,word[n]
mov word[temp1],ax
mov word[flag],2

mov edi,matrix

for1:
cmp word[flag],1
je if

else:
mov word[flag],1
mov ax,word[m]
mov word[temp2],ax
jmp L1
if:
mov ax,word[m]
mov word[temp2],ax
mov word[flag],2
L1:


for2:
cmp word[flag],1
je if1

else1:
mov ax,word[edi]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,space
mov edx,size_
int 80h

sub edi,2
jmp L2

if1:
mov ax,word[edi]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,space
mov edx,size_
int 80h

add edi,2
L2:
dec word[temp2]
cmp word[temp2],0
ja for2

cmp word[flag],1
je if3

else3:
add edi,2
jmp L3

if3:
sub edi,2

L3:

mov ax,word[m]
add ax,ax
mov word[t],ax
add edi,dword[t]
dec word[temp1]
cmp word[temp1],0
ja for1


exit:
mov eax,1
mov ebx,0
int 80h

read_num:

mov word[num],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read
cmp byte[temp],32
je end_read

mov ax,word[num]
mov bx,10
mul bx
mov bx,word[temp]
sub bx,30h
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
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


mov word[nod],0
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
