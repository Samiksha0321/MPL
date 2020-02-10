______________________________________________________________________

;Write 64 bit ALP to convert 4-digit Hex number into its equivalent
;BCD number and 5-digit BCD number into its equivalent HEX
;number. Make your program user friendly to accept the choice from
;user for:
;a) HEX to BCD
;b) BCD to HEX
;c) EXIT
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
	main:	db "Select one of the following", 0xA
		db "1. HEX to BCD", 0xA
		db "2. BCD to HEX", 0xA
		db "3. EXIT", 0xA
		db "Enter your choice: "
	main_len:	equ	$-main
	
	
	err_msg:	db	"Enter valid data: ", 0xA
	err_len: equ $-err_msg
	
	
	msg1:	db	"Enter 4 digit HEX number: ", 0xA
	msg1_len: equ $-msg1
	
	
	msg2:	db	"Enter 5 digit BCD number: ", 0xA
	msg2_len: equ $-msg2
______________________________________________________________________
	
section .bss
	choice	resb	6
	digitcount	resb	1
	
	
	
	
______________________________________________________________________	
	
section .text
global _start
_start:
	print	main, main_len
	read	choice, 2
	mov	al, [choice]
	
c1:	cmp	al, '1'
	jne	c2
	call	HEX_to_BCD
	jmp	_start

c2:	cmp	al, '2'
	jne	c3
	call	BCD_to_HEX
	jmp	_start
	
c3:	cmp	al, '3'
	jne	err
	exit
	
err:	print	err_msg, err_len
	jmp	_start
	
					; HEX to BCD	
HEX_to_BCD:
	call accept 



----------------------------------------------------------------------
					
accept:
	read    buf,5     

	xor     bx,bx
	mov     rcx,4
	mov     rsi,buf
next_digit:
	shl bx,04
	mov al,[rsi]
        cmp     al,"0"     
        jb  error       
        cmp   al,"9"   
        jbe  sub30      

        cmp al,"A"     
        jb   error         
        cmp al,"F"
        jbe   sub37         

        cmp     al,"a"         
        jb error        
        cmp al,"f"
        jbe  sub57          

error:  print   emsg,emsg_len   
        exit

sub57:  sub al,20h         
sub37:  sub   al,07h       
sub30:  sub   al,30h       
    
    add bx,ax       
    inc rsi     
    loop    next_digit
ret
______________________________________________________________________



