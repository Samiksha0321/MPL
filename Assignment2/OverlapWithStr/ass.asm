;
;						Overlapping With String
;_______________________________________________________________________________________________________________________________

%macro print 2
	mov rax, 01h
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	
	array dq 10h, 20h, 30h, 40h, 50h, 00h, 00h, 00h, 00h
	
	msg1 db "Before :", 0xA
	len1 equ $-msg1
	
	msg2 db "After :", 0xA
	len2 equ $-msg2
	
	new db 0xA
	colon db ":"

	count db 8h

section . text
global _start
_start:
	print new, 1
	print msg1, len1
	
	mov r8, array
	L1:	mov rax, r8
		call HtoA
		print colon, 1
		mov rax, qword[r8]
		call HtoA
		print new, 1
		add r8, 08h
		dec byte[cnt]
	jnz L1




	print new, 1
	print msg2, len2

	mov r9, array
	L2:	mov rax, r9
		call HtoA
		print colon, 1
		mov rax, qword[r9]
		call HtoA
		print new, 1
		add r9, 08h
		dec byte[cnt]
	jnz L2
	print new, 1	

	mov rax, 60
	mov rdi, 00
	syscall

HtoA:
	mov rsi, result
	mov byte[count], 10h
	L:	rol rax, 4
		mov bl, al
		and bl, 0Fh
		cmp bl, 09h
		jbe label
		add bl, 07h
		label:	add bl, 30h
		mov byte[rsi], bl
		inc rsi			
		dec byte[count]
	jnz L

	print result, 16
ret
