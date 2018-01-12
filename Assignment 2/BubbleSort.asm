section .data
msg1 : db 'Enter size of array',10
l1 : equ $-msg1
msg2 : db 'Enter element :'
l2 : equ $-msg2
msg3 : db 'Your array',10
l3 : equ $-msg3
space : db ' '
ls : equ $-space

section .bss
num : resb 1
temp : resb 1
ctemp : resb 1
ptemp : resb 1
just_read : resb 1
print_now : resb 1
count : resb 1
arr : resb 20
i : resb 1
j : resb 1

section .text

global _start:
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_number_function

	mov al, byte[just_read]
	mov byte[num], al
	mov byte[temp], al

	mov eax, arr
	enter_array_loop:
		cmp byte[temp], 0
		je exit_array_loop
		sub byte[temp], 1
		call read_number_function

		mov bl, byte[just_read]
		mov byte[eax], bl
		add eax, 1
		jmp enter_array_loop
	exit_array_loop:
	mov al, byte[num]
	mov byte[temp], al
	mov eax, arr
;	jmp print_array_loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sorting using bubble sort
pusha
mov byte[i], 0
mov byte[j], 0
	i_loop:
		mov byte[j], 0
			j_loop:
				mov eax, arr
				movzx ebx, byte[j]
				add eax, ebx
				mov ebx, eax
				add ebx, 1
				
				mov cl, byte[eax]
				mov ch, byte[ebx]
				cmp cl, ch
				jnb no_swap

				swap:
				mov byte[eax], ch
				mov byte[ebx], cl

				no_swap:

				add byte[j], 1
				mov al, byte[num]
				sub al, byte[i]
				sub al, 1
				cmp byte[j], al
				jb j_loop
			
			add byte[i], 1
			mov al, byte[num]
			cmp byte[i], al
			jb i_loop
popa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	print_array_loop:
		push eax
		cmp byte[temp], 0
		je end_printing
		
		sub byte[temp], 1
		pop eax
		mov bl, byte[eax]
		mov byte[print_now], bl
		call print_number_function
		add eax, 1
		jmp print_array_loop
	end_printing:

		mov eax, 1
		mov ebx, 0
		int 80h

	read_number_function:
	pusha
		
		mov byte[just_read], 0

		reading:
			mov eax, 3
			mov ebx, 0
			mov ecx, ctemp
			mov edx, 1
			int 80h

			cmp byte[ctemp], 10
			je end_reading

			sub byte[ctemp], 30h

			mov al, byte[just_read]
			mov ah, 0
			mov bl, 10
			mul bl
			add al, byte[ctemp]
			mov byte[just_read], al
			jmp reading
		end_reading:

	popa
	ret

	print_number_function:
	pusha
		mov byte[count], 0
		extracting:
			cmp byte[print_now], 0
			je print
			add byte[count], 1
			movzx ax, byte[print_now]
			mov bl, 10
			div bl
			movzx edx, ah
			push edx
			mov byte[print_now], al
			jmp extracting

		print:
			cmp byte[count], 0
			je end_print
			sub byte[count], 1
			mov edx, 0
			pop edx
			mov eax, edx
			add al, 30h
			mov byte[ptemp], al
			mov eax, 4
			mov ebx, 1
			mov ecx, ptemp
			mov edx, 1
			int 80h
			mov eax, 0
			jmp print
		end_print:

		mov eax, 4
		mov ebx, 1
		mov ecx, space
		mov edx, ls
		int 80h

	popa
	ret





















