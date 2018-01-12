Section .data
msg : db 'Enter Your Name: '
len : equ $-msg

Section .bss
name : resb 1
len1 : resb 1

Section .text

;Output
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, len
int 80h

;input
mov eax, 3
mov ebx, 0
mov ecx, name
mov edx, len1
int 80h

;Output
mov eax, 4
mov ebx, 1
mov ecx, name
mov edx, len1
int 80h

;exit
mov eax, 1
mov ebx, 0
int 80h
