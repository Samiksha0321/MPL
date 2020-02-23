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

	main:	db	"Select the method: ", 0xA
		db	"1. Successive Addition", 0xA
		db	"2. Add and shift method", 0xA
		db	"3. Booth's algo", 0xA
	m_len:	equ	$-main
	
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
	choice	resb	1
______________________________________________________________________

section .text
global _start
_start:

	print	main, len_main
	read	choice, 2
	mov	al, [choice]
	
c1:	cmp	al, '1'
	jne	c2
	call	Successive_Addition
	jmp	_start
	
c2:	cmp	al, '2'
	jne	c3
	call 	Add_Shift_method
	jmp	_start
	
c3:	cmp	al, '3'
	jne	c4
	call	Booth_algo	
	jmp	_start
	
c4:	exit
	
	
	

	
	print	msg2, len2
	read	second, 3		; 2 digit num+ enter 
	call convert
	xor rcx,rcx
	xor rax,rax
	mov	rax, [num1]
	
	print	msg3, len3
	
	
----------------------------------------------------------------------
input_from_user:
	print	msg1, len1
	read	first, 3		; 2 digit num + enter 
	call	convert_ASCII_to_hex

	print	msg2, len2
	read	second, 3
	call	convert_ASCII_to_hex
ret 

convert_ASCII_to_hex:
	mov	rsi, result
	mov	byte[count], 10h
	L:	rol	rax, 4
		mov	bl, al
		and	bl, 0Fh
		cmp	bl, 09h
		jbe	label
		add	bl, 07h
		label:	add	bl, 30h
		mov	byte[rsi], bl
		inc	rsi			
		dec	byte[count]
	jnz	L

	print	result, 16
ret
		

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



