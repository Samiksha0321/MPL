%macro	print 2
	mov	rax, 01h
	mov	rdi, 01h
	mov	rsi, %1
	mov	rdx, %2
	syscall
%endmacro


section .data
	real_mode	db	0xA, 'Processor is in Real Mode', 0xA
	real_len	equ	$-real_mode

	pro_mode	db	0xA, 'Processor is in Protected Mode', 0xA
	pro_len	equ	$-pro_mode

	gdtmsg		db	0xA, 'GDTR : '
	gmsg_len	equ	$-gdtmsg

	ldtmsg		db	0xA, 'LDTR : '
	lmsg_len	equ	$-ldtmsg

	idtmsg		db	0xA, 'IDTR : '
	imsg_len	equ	$-idtmsg

	trmsg		db	0xA, 'TR : '
	tmsg_len	equ	$-trmsg

	mswmsg		db	0xA, 'MSW : '
	m_len	equ	$-mswmsg

	col db ':'

	newline db 0xA


section .bss
	gdt	resd 1
		resw 1
	ldt	resw 1
	idt	resd 1
   	   	resw 1
   	tr	resw 1
	cro 	resd 1
	num 	resb 04



section .text
global _start
_start:   
	smsw	eax        	

	mov	[cro], eax
	bt	eax, 0        
	jc	pmode
	print	real_mode, real_len
	jmp	nxt1
	pmode:	print	pro_mode, pro_len
nxt1:    
	sgdt	[gdt]
	sldt	[ldt]
	sidt	[idt]
	str	[tr]

	print	gdtmsg, gmsg_len
   	mov	bx, [gdt+4]
	call	disp_num
	mov	bx, [gdt+2]
	call	disp_num
	print	col, 1
	mov	bx, [gdt]
	call	disp_num

	print	ldtmsg, lmsg_len
	mov	bx, [ldt]
	call	disp_num

	print	idtmsg, imsg_len
   	mov	bx, [idt+4]
	call	disp_num
	mov	bx, [idt+2]
	call	disp_num
	print	col, 1
	mov	bx, [idt]
	call	disp_num

	print	trmsg, tmsg_len   
	mov	bx, [tr]
	call	disp_num

	print	mswmsg, m_len
   	mov	bx, [cro+2]
	call	disp_num

	mov	bx, [cro]
	call	disp_num

	print	newline, 1
	mov eax,01
	mov ebx,00
	int 80h

disp_num:
	mov	esi, num   
	mov	ecx, 04       
lable:
	rol	bx, 4       
	mov	dl, bl       
	and	dl, 0fh        
	add	dl, 30h        
	cmp	dl, 39h        
	jbe	L    
	add	dl, 07h       
L:
	mov	[esi], dl       
	inc	esi           
	loop	lable     
       print	num, 4    
ret