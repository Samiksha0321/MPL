%macro print 2				;write system call
	mov rax, 01h 
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	msg1 db 'count of positive numbers in array is: ',
	len1 equ $ -msg1

	msg2 db 'count of negative numbers in array is: ',
	len2 equ $ -msg2	
		
	nextLine db ' ',0xA
	len equ $ -nextLine

	array db 0x11, 0xA, 0x13, 0x92, 0xAF	;array declaration
	pos db 0h				;variable 
	neg: db 0h
	cnt db 5h

section .text
global _start
_start:
	mov rsi, array
	xor rax, rax
label1:
	mov al, byte[rsi]
	bt rax, 07			;test the 7th bit, ie. MSB
	jc l1				;jump if condition is met
	inc byte[pos]
	jmp l2
l1:
	inc byte[neg]
l2:
	inc rsi 
	dec byte[cnt]
	jnz label1			;jump not zero 
	
	add byte[pos], 30h
	add byte[neg], 30h	

	print msg1, len1		;print msg1
	print pos, 1
	
	print nextLine, len

	print msg2, len2
	print neg, 1
	
	print nextLine, len

	mov rax, 60
	mov rdi, 00
	syscall
