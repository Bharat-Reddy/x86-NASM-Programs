section .data
msg1 : db 'Enter size of array',10
l1 : equ $-msg1
msg2 : db 'Enter element :'
l2 : equ $-msg2
msg3 : db 'Your array',10
l3 : equ $-msg3
space : db ' '
ls : equ $-space
zero : db '0'
lz : equ $-zero

section .bss
num : resd 1
temp : resd 1
ctemp : resb 1
ptemp : resd 1
just_read : resd 1
print_now : resd 1
count : resd 1
arr : resd 20
i : resd 1
j : resd 1
ei : resd 1
ej : resd 1

section .text

global _start:
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_number_function

	mov eax, dword[just_read]
	mov dword[num], eax
	mov dword[temp], eax

	mov eax, arr
	enter_array_loop:
		cmp dword[temp], 0
		je exit_array_loop
		sub dword[temp], 1
		call read_number_function

		mov ebx, dword[just_read]
		mov dword[eax], ebx
		add eax, 4
		jmp enter_array_loop
	exit_array_loop:
	mov eax, dword[num]
	mov dword[temp], eax
	mov eax, arr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sorting using bubble sort
pusha
mov byte[i], 0
mov byte[j], 0
	i_loop:
		mov byte[j], 0
			j_loop:
				mov eax, dword[j]
				shl eax, 2
				mov dword[ej], eax 
				mov eax, arr
				mov ebx, dword[ej]
				add eax, ebx
				mov ebx, eax
				add ebx, 4
				
				mov ecx, dword[eax]
				mov edx, dword[ebx]
				cmp ecx, edx
				jnb no_swap

				swap:
				mov dword[eax], edx
				mov dword[ebx], ecx

				no_swap:

				add dword[j], 1
				mov eax, dword[num]
				sub eax, dword[i]
				sub eax, 1
				cmp dword[j], eax
				jb j_loop
			
			add dword[i], 1
			mov eax, dword[num]
			cmp dword[i], eax
			jb i_loop
popa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	print_array_loop:
		push eax
		cmp dword[temp], 0
		je end_printing
		
		sub dword[temp], 1
		pop eax
		mov ebx, dword[eax]
		mov dword[print_now], ebx
		call print_number_function
		add eax, 4
		jmp print_array_loop
	end_printing:

		mov eax, 1
		mov ebx, 0
		int 80h

	read_number_function:
	pusha
		
		mov dword[just_read], 0

		reading:
			mov eax, 3
			mov ebx, 0
			mov ecx, ctemp
			mov edx, 1
			int 80h

			cmp byte[ctemp], 10
			je end_reading

			sub byte[ctemp], 30h

			mov eax, dword[just_read]
			mov edx, 0
			mov ebx, 10
			mul ebx
			movzx ebx, byte[ctemp]
			add eax, ebx
			mov dword[just_read], eax
			jmp reading
		end_reading:

	popa
	ret

	print_number_function:
	pusha
	cmp dword[print_now], 0
	jne start
	
		mov eax, 4
		mov ebx, 1
		mov ecx, zero
		mov edx, lz
		int 80h
		jmp end_print
		
	start:
		mov dword[count], 0
		extracting:
			cmp dword[print_now], 0
			je print
			add dword[count], 1
			mov eax, dword[print_now]
			mov edx, 0
			mov ebx, 10
			div ebx
			push edx
			mov dword[print_now], eax
			jmp extracting

		print:
			cmp dword[count], 0
			je end_print
			sub dword[count], 1
			pop edx
			mov eax, edx
			add eax, 30h
			mov dword[ptemp], eax
			mov eax, 4
			mov ebx, 1
			mov ecx, ptemp
			mov edx, 4
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





















