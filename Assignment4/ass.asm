;______________________________________________________________________

;Write X86/64 ALP to perform multiplication of two 8-bit
;hexadecimal numbers. Use successive addition and add and shift
;method. (use of 64-bit registers is expected)
;______________________________________________________________________

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
%endmacro

;______________________________________________________________________

section .data

	main:	db	0xA
		db	"Select the method: ", 0xA
		db	"1. Successive Addition", 0xA
		db	"2. Add and shift method", 0xA
		db	"3. Booth's algo", 0xA
	m_len:	equ	$-main
	
	msg1:	db	"Enter 1st 2 digit hex number: "
	len1:	equ	$-msg1
	msg2:	db	"Enter 2nd 2 digit hex number: "
	len2:	equ	$-msg2
	msg3:	db	"Multiplication is: "
	len3:	equ	$-msg3
;______________________________________________________________________

section .bss
	num	resb	1
	first	resb	1
	second	resb	1
	ans	resb	2
	choice	resb	1
	cnt	resb	2
;______________________________________________________________________

section .text
global _start
_start:
	xor	rax, rax
	xor	rbx, rbx
	xor	rcx, rcx
	xor	rdx, rdx
	
	print	main, m_len
	read	choice, 2
	mov	al, [choice]

	cmp	al, '4'
	jne continue
	exit
	
continue:	
	print	msg1, len1
	read	num, 3		
	call	AtoH
	mov	byte[first], bl
	
	print	msg2, len2
	read	num, 3		
	call	AtoH
	mov	byte[second], bl
	
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


;----------------------------------------------------------------------

Successive_Addition:
	mov	cl, byte[second]
	mov	dl, byte[first]
	cmp	cl, 00	
	je	next	
	
	L1:	add	ax, dx
	sub	cl, 01H
	jne	L1

	next:	mov	dx, ax
	mov	word[ans], dx
	call HtoA
	call _start
	
	
Add_Shift_method:

ret


Booth_algo:

ret

;----------------------------------------------------------------------
AtoH:
	mov	rsi, num
	mov	byte[cnt], 2
	
	up:	rol	bl, 4
		mov	dl, byte[rsi]
		cmp	dl, 39H
		jbe	next1
		sub	dl, 07H
		
		next1:	sub	dl, 30H
		
		add	bl, dl
		inc	rsi
		dec	byte[cnt]
		jnz	up	
		
ret



HtoA:
	mov	rsi, ans
	mov	byte[cnt], 10h
	
	L:	rol	rax, 4
		mov	bl, al
		and	bl, 0Fh
		cmp	bl, 09h
		jbe	label
		add	bl, 07h
		label:		add bl, 30h
		mov	byte[rsi], bl
		inc	rsi			
		dec	byte[cnt]
	jnz L

	print	ans, 16
ret
	


	


;______________________________________________________________________



