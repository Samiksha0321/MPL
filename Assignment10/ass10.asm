section .data
	msg	db 0xA,"Enter the values of the quadratic number", 0xA




section .text
global _start
_start:

mov rax, 2
mov rdi, fname1 
mov rsi, 2 
mov rdx, 0777 
Syscall
mov [fd_in], rax


mov rax, 0
mov rdi, [fd_in] 
mov rsi, Buffer 
mov rdx, length 
Syscall


mov rax, 01 
mov rdi, [fd_in] 
mov rsi, Buffer
mov rdx, length 
Syscall


mov rax,3
mov rdi,[fd_in]
syscall
