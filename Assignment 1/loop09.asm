section .data
msg : db 'Enter a number between 0 nd 9 :'
l : equ $-msg

section .bss
d1 : resb 1
c : resb 1
section .text
global _start:
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, l
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h

	sub byte[d1], 30h
	mov bp, word[d1]
	mov byte[c], 1
	for:
		add byte[c], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, c
		mov edx, 1
		int 80h
		sub byte[c], 30h
		add byte[c], 1
		cmp word[c], bp
		jna for

		mov eax, 1
		mov ebx, 0
		int 80h
	
