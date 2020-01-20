;Write 64 bit ALP to convert 4-digit Hex number into its equivalent
;BCD number and 5-digit BCD number into its equivalent HEX
;number. Make your program user friendly to accept the choice from
;user for:
;a) HEX to BCD
;b) BCD to HEX
;c) EXIT

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

section .data
	main:	db "Select one of the following", 0xA
		db "1. HEX to BCD", 0xA
		db "2. BCD to HEX", 0xA
		db "3. EXIT", 0xA
	main_len:	equ	$-main
	
	err_msg:	db	"Enter valid data: ", 0xA
	err_len:	equ	$-err_msg
section .bss
	choice	resb	6
	
section .text
global _start
_start:
	print	main, main_len
	read	choice, 2
	mov	al, [choice]
	
c1:	cmp	al, '1'
	jne	c2
	call	HEX_BCD
	jmp	_start

c2:	cmp	al, '2'
	jne	c3
	call	BCD_HEX
	jmp	_start
	
c3:	cmp	al, '3'
	jne	err
	exit
	
err:	print	err_msg, err_len
	jmp	_start
	
	
	
		
