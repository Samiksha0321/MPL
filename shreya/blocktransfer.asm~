%macro print 2
mov rax, 01
mov rdi, 01
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .data
block1: dq 11H, 02H, 07H, 24H, 56H
block2: dq 00H, 00H, 00H, 00H, 00H
count1 db 05H
cnt db 10H
msg1 db "Before block transfer: ",0xA
len1 equ $-msg1
new db 0xA
msg2 db "After block transfer: ", 0xA
len2 equ $-msg2
colon db ":"


section .bss
result resq 1

section .text

global _start

_start: print msg1, len1
	
	mov r8, block1

LL: 	mov rax, r8
	CALL HtoA
	print colon, 1
	mov rax, qword[r8]
	call HtoA
	print new, 1
	add r8, 08
	dec byte[count1]
	jnz LL
	
	print new,1

	mov byte[count1], 05H
	mov r8, block1
	mov r9, block2
	L: mov rbx, qword[r8]
	mov qword[r9], rbx
	add r8, 08
	add r9, 08
	dec byte[count1]
	jnz L

	print msg2, len2
	
	mov byte[count1], 05H
	mov r9, block2
	L2: mov rax, r9
	CALL HtoA
	print colon, 1
	mov rax, qword[r9]
	call HtoA
	print new, 1
	add r9, 08
	dec byte[count1]
	jnz L2

	mov rax, 60
	mov rdi, 00
	syscall

HtoA:   mov rsi, result
	mov byte[cnt], 10h
label1: rol rax,4
	mov bl, al
	and bl, 0FH
	cmp bl, 09H
	jbe l1
	add bl,07H
	l1: add bl, 30H
	mov byte[rsi], bl
	inc rsi
	dec byte[cnt]
	jnz label1

	print result,16
	ret
