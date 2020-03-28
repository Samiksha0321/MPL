;Write an ALP to read and display the table content pointed by
;GDTR/LDTR and IDTR
;GDTR/IDTR :48
;LDTR/MSW/TR:16

section .data
msg0: db "1.The Content of GDTR is :",0x0A
len0: equ $-msg0
msg1: db 0x0A,"2.The Content of LDTR is : ",0x0A
len1: equ $-msg1
msg2: db 0x0A,"3.The Content of IDTR is :",0x0A
len2: equ $-msg2
msg3: db 0x0A
len3: equ $-msg3
msg4: db " : "
len4: equ $-msg4
msg5: db 0x0A,"4.The Content of MSW is :",0x0A
len5: equ $-msg5
msg6: db 0x0A,"3.The Content of TR is :",0x0A
len6: equ $-msg6
msg7: db 0x0A,"System is working in Protected mode",0x0A
len7: equ $-msg7
msg8: db 0x0A,"System is working in Real mode",0x0A
len8: equ $-msg8



section .bss

result1: resb 17
result2: resb 17
gdt: resb 17
ldt: resb 17
idt: resb 17
msw: resb 17
tr: resb 17

cnt:resb 4

%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro



section .text
global _start
_start:
	scall 1,1,msg0,len0
	sgdt [gdt]
	mov dx,[gdt]
	call htoa

	scall 1,1,msg1,len1
	sldt [ldt]
	mov dx,[ldt]
	call htoa2

	scall 1,1,msg2,len2
	sidt [idt]
	mov dx,[idt]
	call htoa

	scall 1,1,msg6,len6
	str [tr]
	mov dx,[tr]
	call htoa2


	scall 1,1,msg5,len5
	smsw [msw]
	mov dx,[msw]
	call htoa2


	smsw [result2]
	mov dx,[result2]
	bt dx,0
	jc next
	scall 1,1,msg8,len8
	jmp exit
next	scall 1,1,msg7,len7

exit:	mov rax,60
	mov rdi,0
	syscall




htoa:	mov rsi,result1
	mov byte[cnt],12

upp:	rol edx,04
	mov cl,dl
	and cl,0FH
	cmp cl,09H
	jbe next4
	add cl,07
next4:	add cl,30H
	mov byte[rsi],cl
	inc rsi
	dec byte[cnt]
	jnz upp
	
	scall 1,1,result1,12
	
	ret


htoa2:	mov rsi,result2
	mov byte[cnt],8

upp1:	rol edx,04
	mov cl,dl
	and cl,0FH
	cmp cl,09H
	jbe next41
	add cl,07
next41:	add cl,30H
	mov byte[rsi],cl
	inc rsi
	dec byte[cnt]
	jnz upp1
	
	scall 1,1,result2,8
	
	ret




