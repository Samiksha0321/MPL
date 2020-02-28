%macro	print 2
	mov	rax, 01h
	mov	rdi, 01h
	mov	rsi, %1
	mov	rdx, %2
	syscall
%endmacro

%macro read  2
	mov	rax, 00h
	mov	rdi, 00h
	mov	rsi,%1
	mov	rdx,%2
	syscall
%endmacro


Section .data
	title:	db "------ Factorial Program ------",0x0A
		db "Enter Number : ",0x0A
	title_len:	equ	$-title
	factMsg:	db "Factorial is :", 0x0A
	factMsg_len:	equ	$-factMsg
	cnt:	db 00H
	cnt2:	db 02H
	num_cnt: db 00H


Section .bss
	number:	resb 2
	factorial:	resb 8 


Section .text
global _start
_start:
	print	title, title_len
	read	number,2

	mov	rsi,number     
	call	AtoH   

FACTORIAL:
	call	fact_proc
	mov	rbx, rax
	mov	rdi, factorial
	call	HtoA_value
	print	factorial, 8

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall

fact_proc:
	cmp	bl, 01H
	jne	do_calc
	mov	ax, 1
ret

do_calc:
	push	rbx
	dec	bl
	call	fact_proc
	pop	rbx
	mul	bl
ret

AtoH:     
	mov	byte[cnt],02H
	mov	bx,00H
	hup:
	rol	bl,04
	mov	al,byte[rsi]
	cmp	al,39H
	JBE	HNEXT
	SUB	al,07H
	HNEXT:
	sub	al,30H
	add	bl,al
	INC	rsi
	DEC	byte[cnt]
	JNZ	hup
ret

HtoA_value: 
	mov	byte[cnt2], 08H
aup1:
	rol	ebx, 04
	mov	cl, bl
	and	cl, 0FH
	cmp	cl, 09H
	jbe	ANEXT1
	add 	cl, 07H
ANEXT1: 
	add	cl, 30H
	mov	byte[rdi],cl
	inc 	rdi
	dec	byte[cnt2]
	jnz	aup1
ret


