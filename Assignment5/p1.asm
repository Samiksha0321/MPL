section .data

count1: db 0x00
count2: db 0x00
count3: db 0x00

section .bss
extern char,buffer,length1,length2,length3
result: resb 8
cnt: resb 4


%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .text
global main1
main1:

global ent,spc,occ
spc:	mov bx,00
	mov cx,[length2]
	mov rsi,buffer
up:	mov al,byte[rsi]
	cmp al,0x20
	JNE next
	inc bx
next:	inc rsi
	dec cx
	jnz up
	mov dx,bx
	call htoa
	ret


ent:	mov bx,00
	mov cx,[length2]
	mov rsi,buffer
up1:	mov al,byte[rsi]
	cmp al,0x0A
	JNE next1
	inc bx
next1:	inc rsi
	dec cx
	jnz up1
	mov dx,bx
	call htoa
	ret
	

occ:	mov bx,00
	mov cx,[length2]
	mov rsi,buffer
	mov rdi,char
up2:	mov al,byte[char]
	cmp al,byte[rsi]
	JNE next2
	inc bx
next2:	inc rsi
	dec cx
	jnz up2
	mov dx,bx
	call htoa
	ret
	
	
htoa:	mov rsi,result
	mov byte[cnt],8

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
	
	scall 1,1,result,8
	
	ret
	
