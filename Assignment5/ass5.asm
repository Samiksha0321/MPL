%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro



section .data
msg0: db "1.Number of blank spaces :",0x0A
len0: equ $-msg0
msg1: db 0x0A,"2.Number of lines",0x0A
len1: equ $-msg1
msg2: db 0x0A,"3.Occurance of a particular character",0x0A
len2: equ $-msg2
msg3: db 0x0A,"Content of file is read successfully",0x0A
len3: equ $-msg3
msg4: db 0x0A,"The file is open",0x0A
len4: equ $-msg4
msg5: db 0x0A,"The file is not open",0x0A
len5: equ $-msg5
msg6: db 0x0A,"Content of file is NOT read successfully",0x0A
len6: equ $-msg6
msg7: db 0x0A,"Enter The Character : ",0x0A
len7: equ $-msg7
endl: db 0x0A
endlen: equ $-endl
fname: db 'abc.text',0




section .bss
global char,buffer,lenght1,length2,lenght3
fd: resb 17
char: resb 2
result: resb 4
cnt: resb 2
length1: resb 8
length2: resb 8
length3: resb 8
buffer: resb 1000



section .text
extern ent,spc,occ
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
	mov qword[length2],rax
	mov qword[length3],rax

	scall 1,1,buffer,1000

	scall 1,1,msg0,len0
	call spc
	scall 1,1,msg1,len1
	call ent
	scall 1,1,msg2,len2
	scall 1,1,msg7,len7
	scall 0,1,char,2
	call occ
	scall 1,1,endl,endlen
exit:	mov rax,60
	mov rdi,0
	syscall



