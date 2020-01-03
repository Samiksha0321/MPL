%macro print 2				;write system call
	mov rax, 01h 
	mov rdi, 01h
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	
section .text
global _start 
_start:
	

	mov rax, 60
	mov rdi, 00
	syscall
