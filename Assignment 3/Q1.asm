section .data
msg1 : db 'Enter no of rows',10
l1 : equ $-msg1
msg2 : db 'Enter no of columns',10
l2 : equ $-msg2
msg3 : db 'Enter elements of array',10
l3 : equ $-msg3
space : db ' '
ls : equ $-space
endl : db 10
lendl : equ $-endl
zero : db '0'
lz : equ $-zero

section .bss
;main function
num : resd 1
temp : resd 1
l : resd 1
r : resd 1
m : resd 1
n : resd 1
i : resd 1
j : resd 1
arr : resd 100
count : resd 1
ka : resd 1
kb : resd 1

;read_function
just_read : resd 1
rtemp : resd 1

;print_function
just_print : resd 1
ptemp : resd 1
pcount : resd 1
pprint : resd 1

section .text
global _start:
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1 
	mov edx, l1
	int 80h

	call read_number
	mov eax, dword[just_read]
	mov dword[m], eax
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	call read_number
	mov eax, dword[just_read]
	mov dword[n], eax
;	pusha
;	mov dword[just_print], eax
;	call print_number
;	popa
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h

	mov eax, 0
	mov ebx, arr
	mov dword[i], 0
	mov dword[j], 0
	
	i_loop:
	mov dword[j], 0
		j_loop:
			call read_number
			mov ecx, dword[just_read]
			mov dword[ebx + eax], ecx
			add eax, 4
			add dword[j], 1
			mov edx, dword[j]
			cmp edx, dword[n]
			jb j_loop
		add dword[i], 1
		mov edx, dword[i]
		cmp edx, dword[m]
		jb i_loop

		;Calculation of l ams r
		mov eax, dword[n]
		add eax, 1
		mov edx, 0
		mov ebx, 4
		mul ebx
		mov dword[l], eax

		mov eax, dword[n]
		sub eax, 1
		mov edx, 0
		mov ebx, 4
		mul ebx
		mov dword[r], eax

		mov eax, dword[n]
		mov dword[count], eax
		mov eax, 0
		mov ecx, dword[r]
		mov ebx, arr

		exchanging:
		
			cmp dword[count], 0
			je end_exhanging

			sub dword[count], 1
			mov edx, dword[ebx + eax]
			mov dword[ka], edx
			mov edx, dword[ebx + ecx]
			mov dword[ebx + eax], edx
			mov edx, dword[ka]
			mov dword[ebx + ecx], edx

			add eax, dword[l]
			add ecx, dword[r]
			jmp exchanging
		end_exhanging:

		mov eax, 0
		mov ebx, arr
		mov dword[i], 0
		mov dword[j], 0

		i_loop1:
			mov dword[j], 0
			j_loop1:
				mov edx, dword[ebx + eax]
				mov dword[just_print], edx
				call print_number
				add eax, 4
				add dword[j], 1
				mov edx, dword[j]
				cmp edx, dword[n]

				pusha
				mov eax, 4
				mov ebx, 1
				mov ecx, space
				mov edx, ls
				int 80h
				popa

				jb j_loop1
				pusha
				mov eax, 4
				mov ebx, 1
				mov ecx, endl
				mov edx, lendl
				int 80h
				popa
			add dword[i], 1
			mov edx, dword[i]
			cmp edx, dword[n]
			jb i_loop1
		mov eax, 1
		mov ebx, 0
		int 80h


	read_number:
	pusha
		mov dword[just_read], 0
		mov dword[rtemp], 0
		reading:
			mov eax, 3
			mov ebx, 0
			mov ecx, rtemp
			mov edx, 1
			int 80h

			cmp dword[rtemp], 10
			je end_reading

			sub dword[rtemp], 30h
			mov eax, dword[just_read]
			mov edx, 0
			mov ebx, 10
			mul ebx
			add eax, dword[rtemp]
			mov dword[just_read], eax
			jmp reading
		end_reading:
	popa
	ret

	print_number:
	pusha
	cmp dword[just_print], 0
	jne start
	mov eax, 4
	mov ebx, 1
	mov ecx, zero
	mov edx, lz
	int 80h
	jmp end_printing
	start:
		mov dword[ptemp], 0
		mov dword[pcount], 0
		mov dword[pprint], 0
		extracting:
			cmp dword[just_print], 0
			je print
			add dword[pcount], 1
			mov eax, dword[just_print]
			mov edx, 0
			mov ebx, 10
			div ebx
			push edx
			mov dword[just_print], eax
			jmp extracting
		print:
		cmp dword[pcount], 0
		je end_printing
		pop edx
		mov dword[pprint], edx
		add dword[pprint], 30h
		mov eax, 4
		mov ebx, 1
		mov ecx, pprint
		mov edx, 1
		int 80h
		sub dword[pcount], 1
		jmp print
	end_printing:
	popa
	ret



