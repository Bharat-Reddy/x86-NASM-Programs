section .data
msg1 : db 'Enter first number: '
l1 : equ $-msg1
msg2 : db 'Enetr second number: '
l2 : equ $-msg2
ending : db 10
end_l : equ $-ending

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1
ans1 : resb 1
ans2 : resb 1

section .text
    global _start:
    _start:
    mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, junk
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h

        mov ax, word[d1]
	mov bx, word[d2]
	sub ax, 30h
	sub bx, 30h
	add ax, bx
	mov bl, 10
	mov ah, 0
	div bl
	add ah, 30h
	add al, 30h
	mov [ans1], al
	mov [ans2], ah

	mov eax, 4
	mov ebx, 1
	mov ecx, ans1
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans2
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ending
	mov edx, end_l
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
