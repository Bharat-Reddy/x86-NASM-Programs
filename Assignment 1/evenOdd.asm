section .data
msg1 : db 'Enter a number to check weather it is even or odd :'
l1 : equ $-msg1
ans1 : db 'Entered number is EVEN!!!',10
al1 : equ $-ans1
ans2 : db 'Entered number is ODD!!!',10
al2 : equ $-ans2

section .bss
d1 : resb 1

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

	sub byte[d1], 30h

	mov ax, word[d1]

	mov bl, 2
	mov ah, 0
	div bl

	cmp ah, 0
	je if

	else:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans2
		mov edx, al2
		int 80h
		jmp L

	if:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans1
		mov edx, al1
		int 80h

	L:
		mov eax, 1
		mov ebx, 0
		int 80h
