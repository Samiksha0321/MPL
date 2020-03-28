;Write X86/64 ALP to perform non-overlapped and overlapped
;block transfer (with and without string specific instructions). Block
;containing data can be defined in the data segment.

Section .data
m1: db "Array before overlapping:", 0xA
l1: equ $-m1
m2: db "String: ", 0xA
l2: equ $-m2
m3: db "Array after overlapping: ", 0xA
l3: equ $-m3
msg1: db '  ',0x0A
len1: equ $-msg1
msg2: db ':'
len2: equ $-msg2
array: dq 0x2123654798456321,0x4236547984563216,0x8323654798456321,0xE523654798456321,0x2723654798456321,0,0,0,0,0
array2:dq 0,0,0,0,0,0,0,0,0,0

Section .bss
res: resb 16
count: resb 1
count2: resb 1

Section .text
global _start
_start:

mov rax,1
mov rdi,1
mov rsi,m1
mov rdx,l1
syscall

;Display of data and addresses
mov rsi,array
mov byte[count],10
up: mov rdx,rsi
push rsi
call htoa
syscall

;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

pop rsi
mov rdx,qword[rsi]
push rsi
call htoa
syscall

;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall


pop rsi
add rsi,8
dec byte[count]
jnz up
;Display of data and address ends



;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

;move block of data
mov rsi,array
mov rdi,array2
mov rcx,5
cld
rep movsq


;end block of data

;move block of data
mov rsi,array2
mov rdi,array+24
mov byte[count],5


up4:
mov rbx,qword[rsi]
mov qword[rdi],rbx
add rsi,8
add rdi,8
dec byte[count]
jnz up4


;end block of data


;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rax,1
mov rdi,1
mov rsi,m3
mov rdx,l3
syscall

;Display of data and addresses
mov rsi,array
mov byte[count],10
up5: mov rdx,rsi
push rsi
call htoa
syscall

;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

pop rsi
mov rdx,qword[rsi]
push rsi
call htoa
syscall

;Display1 begins
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall


pop rsi
add rsi,8
dec byte[count]
jnz up5
;Display of data and address ends










mov rax,60
mov rbx,3
syscall


htoa:   mov rsi,res
mov byte[count2],16
up2: rol rdx,04
mov cl,dl
and cl,0FH
cmp cl,09
jbe next2
add cl,07H
next2: add cl,30H
mov byte[rsi],cl
inc rsi
dec byte[count2]
jnz up2

mov rax,1
mov rdi,1
mov rsi,res
mov rdx,16
syscall
ret

