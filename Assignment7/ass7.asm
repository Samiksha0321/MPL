%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
msg0: db "1.Sorted Array is :",0x0A
len0: equ $-msg0
msg1: db 0x0A,"2.Number of Elements",0x0A
len1: equ $-msg1
msg2: db 0x0A,"3.",0x0A
len2: equ $-msg2
msg3: db 0x0A,"Content of file is read successfully",0x0A
len3: equ $-msg3
msg4: db 0x0A,"The file is open",0x0A
len4: equ $-msg4
msg5: db 0x0A,"The file is not open",0x0A
len5: equ $-msg5
msg6: db 0x0A,"Content of file is NOT read successfully",0x0A
len6: equ $-msg6
msg7: db 0x0A,"The file is closed",0x0A
len7: equ $-msg7
endl: db 0x0A
endlen: equ $-endl
fname: db 'abc.txt',0

section .bss
buffer: resb 1000
cnt:resb 4
result1: resb 17
fd: resb 17
char: resb 2
result: resb 1
length1: resb 8
arr: resb 1000

section .txt
global _start
_start:

	scall 2,fname,2,0777
	mov qword[fd],rax
	bt rax,63
	JNC next
	scall 1,1,msg5,len5
	jmp exit
next:	scall 1,1,msg4,len4
	scall 0,[fd],buffer,1000
	mov qword[length1],rax

	scall 1,1,buffer,1000
	
	scall 1,1,msg0,len0
 ;Ascending
	mov bx,07h
upppp:	mov rcx,06h
	mov rsi,buffer
	mov rdi,buffer+2
uppp:	mov al,byte[rsi]
	mov dl,byte[rdi]
	cmp al,dl
	jbe nexttt
	mov byte[rsi],dl
	mov byte[rdi],al
nexttt:	add rsi,2
	add rdi,2
	dec rcx
	jnz uppp
	dec bx
	jnz upppp

	scall 1,1,buffer,1000
	scall 1,[fd],msg0,len0
	scall 1,[fd],buffer,100

;Descending
	mov bx,07h
upp:	mov rcx,06h
	mov rsi,buffer
	mov rdi,buffer+2
up:	mov al,byte[rsi]
	mov dl,byte[rdi]
	cmp al,dl
	jae nextt
	mov byte[rsi],dl
	mov byte[rdi],al
nextt:	add rsi,2
	add rdi,2
	dec rcx
	jnz up
	dec bx
	jnz upp
	
	scall 1,1,buffer,1000
	scall 1,[fd],msg0,len0
	scall 1,[fd],buffer,100

	mov rax,3
	mov rdi,[fd]
	scall 1,1,msg7,len7


exit:	mov rax,60
	mov rdi,0
	syscall









