section .data
msg1: db 'Enter the number of rows: '
size1: equ $-msg1
msg2: db 'Enter the number of columns: '
size2: equ $-msg2
msg3: db 'Enter the number elements: ',0Ah
size3: equ $-msg3
msg4: db 'The required matrix is: ',0Ah
size4: equ $-msg4
space: db ' '
size_: equ $-space
new_line: db 10

section .bss
num: resw 1
matrix: resw 50
nod: resw 1
temp: resw 1
t: resd 1
n: resw 1
m: resw 1
i: resw 1
j: resw 1
temp1: resw 1
temp2: resw 1
m1: resd 1 
zero: resw 1

section .text
global _start:
_start:

mov word[zero],0
add word[zero],30h

mov word[nod],0

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

call read_num
mov ax,word[num]
mov word[n],ax


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h

call read_num
mov ax,word[num]
mov word[m],ax

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
int 80h

mov eax,0
mov ebx,matrix
mov word[i],0
mov word[j],0

i_loop:
mov word[j],0

j_loop:
push eax
push ebx
call read_num
pop eax
pop ebx
mov dx,word[num]
mov word[ebx+eax],dx
add eax,2 

inc word[j]
mov cx,word[j]
cmp cx,word[m]
jb j_loop

inc word[i]
mov cx,word[i]
cmp cx,word[n]
jb i_loop


mov cx,word[n]
mov word[temp1],cx
mov cx,word[m]
mov word[temp2],cx


mov ax,word[n]
sub ax,1
mov dx,0
mov bx,word[m]
mul bx
add ax,ax
mov word[t],ax
;pusha
;mov ax, word[t]
;mov word[num], ax
;call print_num
;popa

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,size4
int 80h

mov eax,dword[t]
mov ebx,matrix
mov cx,word[ebx+eax]
mov word[num],cx



for1:
mov cx,word[n]
mov word[temp1],cx

for2:
push eax
push ebx
call print_num

mov eax,4
mov ebx,1
mov ecx,space
mov edx,size_
int 80h

pop eax
pop ebx

mov cx,word[m]
add cx,cx
mov word[m1],cx
sub eax,dword[m1]
mov cx,word[ebx+eax]
mov word[num],cx
dec word[temp1]
cmp word[temp1],0
ja for2


push eax
push ebx

mov eax,4
mov ebx,1
mov ecx,new_line
mov edx,1
int 80h

mov cx,word[m]
add cx,cx
mov word[m1],cx



mov ax,word[n]
sub ax,1
mov bx,word[m]
mul bx
add ax,1
add ax,ax
mov word[t],ax
pop eax
pop ebx
add eax,dword[m1]
add eax,dword[t]
mov cx,word[ebx+eax]
mov word[num],cx
dec word[temp2]
cmp word[temp2],0
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

cmp word[temp],10
je end_read
cmp word[temp],32
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

