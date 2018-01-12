section .data
msg1 : db 'Enter a',10
l1 : equ $-msg1
msg2 : db 'Enter b',10
l2 : equ $-msg2
msg3 : db 'Enter no of elements of array',10
l3 : equ $-msg3
msg4 : db 'Enter elements of array',10
l4 : equ $-msg4
space : db ' '
ls : equ $-space
endl : db 10
lendl : equ $-endl
answ : db 'Elements divisible by both a and b are',10
lansw : equ $-answ
zero : db '0'
lz : equ $-zero

section .bss

d0 : resd 1
d1 : resd 1
ans_count : resd 1
a : resd 1
b : resd 1
num  : resd 1
temp : resd 1
read_num : resd 1
print_num : resd 1
count : resd 1
ptemp : resd 1
num_of_ans : resd 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h
	
	mov dword[read_num], 0
	call read_number

	mov eax, dword[read_num]
	mov dword[a], eax
	mov dword[read_num], 0

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	call read_number

	mov eax, dword[read_num]
	mov dword[b], eax
	mov dword[read_num], 0

	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h

	call read_number

	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, l4
	int 80h

	mov eax, dword[read_num]
	mov dword[num], eax
	
	mov dword[ans_count], 0
	mov ecx, dword[num]

	mov dword[num_of_ans], 0

	answer:

		call read_number
		mov eax, dword[read_num]
		mov edx, 0
		mov ebx, dword[a]
		div ebx
		cmp edx, 0
		jne not_divisible

		mov eax, dword[read_num]
		mov ebx, dword[b]
		mov edx, 0
		div ebx
		cmp edx, 0
		jne not_divisible

		mov eax, dword[read_num]
		push eax
		add dword[num_of_ans], 1

		not_divisible:
		loop answer

		mov eax, 4
		mov ebx, 1
		mov ecx, answ
		mov edx, lansw
		int 80h

	printing_the_answer:

		cmp dword[num_of_ans], 0
		je allOver
		sub dword[num_of_ans], 1
		pop eax
		mov dword[print_num], eax
		call print_number
		
		mov eax, 4
		mov ebx, 1
		mov ecx, space
		mov edx, ls
		int 80h

		jmp printing_the_answer

	allOver:

	mov eax, 4
	mov ebx, 1
	mov ecx, endl
	mov edx, lendl
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h


	read_number:

		pusha
			mov dword[read_num], 0
			reading:
				mov eax, 3
				mov ebx, 0
				mov ecx, d0
				mov edx, 1
				int 80h

				cmp dword[d0], 10
				je end_reading
				sub dword[d0], 30h
				mov eax, dword[read_num]
				mov edx, 0
				mov ebx, 10
				mul ebx
				add eax, dword[d0]
				mov dword[read_num], eax
				jmp reading
			end_reading:
		popa
		ret


	print_number:
		pusha
		cmp dword[print_num], 0
		jne extracting
			mov eax, 4
			mov ebx, 1
			mov ecx, zero
			mov edx, lz
			int 80h
			jmp end_printing
		
			extracting:
				cmp dword[print_num], 0
				je print
				add dword[count], 1
				mov eax, dword[print_num]
				mov edx, 0
				mov ebx, 10
				div ebx
				push edx
				mov dword[print_num], eax
				jmp extracting

			print:
				cmp dword[count], 0
				je end_printing

				sub dword[count], 1
				pop eax
				mov dword[ptemp], eax
				add dword[ptemp], 30h

				mov eax, 4
				mov ebx, 1
				mov ecx, ptemp
				mov edx, 1
				int 80h
				jmp print
			end_printing:

		popa
		ret







































