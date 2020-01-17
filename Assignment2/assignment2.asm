					;Non overlapping without string

%macro print 2				;write system call
	mov rax, 01h 
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	
	array1 dq 10h, 30h, 40h, 50h

	msg1 db "Before :", 0xA
	len1 equ $ -msg1
	msg2 db "After :", 0xA
	len2 equ $ -msg2
	msg3 db " ", 0xA
	len3 equ $ -msg3
	msg4 db ":"
	len4 equ $ -msg4
	new db 0xA	
	
	cnt1 db 5h
	count db 10h

section .bss
	result resb 1
	
section .text
global _start 
_start:
	print msg1, len1		;before

	mov r8, array1

label1:	mov rax, r8			
	call HtoA
	print msg4, 1
	mov rax, qword[r8]
	print new, 1
	add r8, 08
	dec byte[cnt1]
	jnz label1

	print msg2, len2		;after

	mov rax, 60
	mov rdi, 00
	syscall


HtoA:	mov rsi, r					;Non overlapping without string

%macro print 2				;write system call
	mov rax, 01h 
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	
	array1 dq 10h, 30h, 40h, 50h

	msg1 db "Before :", 0xA
	len1 equ $ -msg1
	msg2 db "After :", 0xA
	len2 equ $ -msg2
	msg3 db " ", 0xA
	len3 equ $ -msg3
	msg4 db ":"
	len4 equ $ -msg4
	new db 0xA	
	
	cnt1 db 5h
	count db 10h

section .bss
	result resb 1
	
section .text
global _start 
_start:
	print msg1, len1		;before

	mov r8, array1

label1:	mov rax, r8			
	call HtoA
	print msg4, 1
	mov rax, qword[r8]
	print new, 1
	add r8, 08
	dec byte[cnt1]
	jnz label1

	print msg2esult
	mov byte[count], 10h
	l1:	
	rol rax, 4
	mov bl, al
	and bl, 0FH
	cmp bl, 09H
	jbe l3
	add bl, 07H
	l3:	add bl, 30H
	mov byte[rsi], bl
	inc rsi
	dec byte[cnt1]
	jnz l1
	
	print result, 16
	ret
