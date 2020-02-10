______________________________________________________________________

;Write X86/64 ALP to perform multiplication of two 8-bit
;hexadecimal numbers. Use successive addition and add and shift
;method. (use of 64-bit registers is expected)
______________________________________________________________________

%macro	print 2
	mov	rax, 01h
	mov	rdi, 01h
	mov	rsi, %1
	mov	rdx, %2
	syscall
%endmacro

%macro	read 2
	mov	rax, 00h
	mov	rdi, 00h
	mov	rsi, %1
	mov	rdx, %2
	syscall
%endmacro

%macro	exit	0
	mov	rax, 60h
	mov	rdi, 00h
	syscall
______________________________________________________________________

section .data
	msg1:	db	"Enter 1st hex number: "
	len1:	equ	$-msg1
	msg2:	db	"Enter 2nd hex number: "
	len2:	equ	$-msg2
	msg3:	db	"Multiplication is: "
	len3:	equ	$-msg3
______________________________________________________________________

section .bss
	first	resb	1
	second	resb	1
	ans	resw	1
______________________________________________________________________

section .text
global _start
_start:

	print 

	print	msg1, len1
	read	first, 3		; 2 digit num + enter 
	call	convert
	mov [num1],bl
	
	print	msg2, len2
	read	second, 3		; 2 digit num+ enter 
	call convert
	xor rcx,rcx
	xor rax,rax
	mov	rax, [num1]
	
	print	msg3, len3
	
	
----------------------------------------------------------------------

Successive_Addition:
	
 
 
       
        mov rax,0
 mov rdi,0
 mov rsi,num
 mov rdx,3
 syscall



 
 repet:
 add rcx,rax
 dec bl
 jnz repet

 mov [result],rcx

        mov rax,1
 mov rdi,1
 mov rsi,res
 mov rdx,res_len
 syscall

 

 mov rbx,[result]

 call display
ret

	
______________________________________________________________________



