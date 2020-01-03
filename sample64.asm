%macro print 2
	mov rax, 01h	;write system call
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	msg db "Enter name", 0xA
	len equ $-msg 
	cnt db 5h

section .bss
	name resb 10

section .text
global _start
_start:
	print msg, len

	mov rax, 00h	; read system call
	mov rdi, 00h
	mov rsi, name
	mov rdx, 10
	syscall
loop1:
	print name, 10
dec byte[cnt]
jnz loop1

	mov rax, 60
	mov rdi, 00h
	syscall
