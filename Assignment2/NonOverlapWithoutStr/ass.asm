;				
;					Non overlapping without string
;_________________________________________________________________________________________________________________________

%macro print 2				
	mov rax, 01h 
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	
	array1 dq 10h, 20h, 30h, 40h, 50h
	array2 dq 00h, 00h, 00h, 00h, 00h

	msg1 db "Before :", 0xA
	len1 equ $ -msg1
	msg2 db "After :", 0xA
	len2 equ $ -msg2
	colon db ":"
	new db 0xA	
	
	cnt1 db 5h
	count db 10h

section .bss
	result resq 1
	
section .text
global _start 
_start:
	print new, 1
	print msg1, len1		;before

	mov r8, array1

	label1:	mov rax, r8			
		call HtoA
		print colon, 1
		mov rax, qword[r8]
		call HtoA
		print new, 1
		add r8, 08
		dec byte[cnt1]
	jnz label1

	print new, 1
					
	mov byte[cnt1], 5h		 
	mov r8, array1			 
	mov r9, array2			 
	L:	mov rbx, qword[r8]	 
		mov qword[r9], rbx	 
		add r8, 08		 
		add r9, 08		 
		dec byte[cnt1]		
	jnz L

	print msg2, len2		;after

	mov byte[cnt1], 5h
	mov r9, array2
	L2:	mov rax, r9
		call HtoA
		print colon, 1
		mov rax, qword[r9]
		call HtoA
		print new, 1
		add r9, 08
		dec byte[cnt1]
	jnz L2
	
	print new, 1

	mov rax, 60
	mov rdi, 00
	syscall


HtoA:	mov rsi, result
	mov byte[count], 10h
	
	l1:	rol rax, 4
		mov bl, al
		and bl, 0FH
		cmp bl, 09H
		jbe l3
		add bl, 07H
		l3:	
			add bl, 30H
		mov byte[rsi], bl
		inc rsi
		dec byte[count]
	jnz l1
	
	print result, 16
ret
