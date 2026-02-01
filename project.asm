.model small
.stack 100h
.data
userBuf db 20 dup(0)
passBuf db 20 dup(0)

msgUser db 'Enter Username:$'
msgPass db 'Enter Password:$'
msgGrant db 'Access Granted$'
msgDeny db 'Access Denied$'

u1 db 'ureed$'
p1 db '73e948c1$'
u2 db 'haroon$'
p2 db '73e948c2$'
u3 db 'hurraira$'
p3 db '73e948c3$'
u4 db 'ahmer$'
p4 db '73e948c4$'
u5 db 'ammar$'
p5 db '74e948c5$'

.code
main proc
mov ax,@data
mov ds,ax

mov dx,offset msgUser
mov ah,9
int 21h
lea si,userBuf
inputUser:
mov ah,1
int 21h
cmp al,0dh
je endUser
mov [si],al
inc si
jmp inputUser
endUser:
mov [si],'$'
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h

mov dx,offset msgPass
mov ah,9
int 21h
lea si,passBuf
inputPass:
mov ah,1
int 21h
cmp al,0dh
je endPass
mov [si],al
inc si
jmp inputPass
endPass:
mov [si],'$'
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h

lea si,userBuf
lea di,u1
call strCmp
cmp ax,0
jne check2
lea si,passBuf
lea di,p1
call strCmp
cmp ax,0
jne deny
jmp grant

check2:
lea si,userBuf
lea di,u2
call strCmp
cmp ax,0
jne check3
lea si,passBuf
lea di,p2
call strCmp
cmp ax,0
jne deny
jmp grant

check3:
lea si,userBuf
lea di,u3
call strCmp
cmp ax,0
jne check4
lea si,passBuf
lea di,p3
call strCmp
cmp ax,0
jne deny
jmp grant

check4:
lea si,userBuf
lea di,u4
call strCmp
cmp ax,0
jne check5
lea si,passBuf
lea di,p4
call strCmp
cmp ax,0
jne deny
jmp grant

check5:
lea si,userBuf
lea di,u5
call strCmp
cmp ax,0
jne deny
lea si,passBuf
lea di,p5
call strCmp
cmp ax,0
jne deny

grant:
mov dx,offset msgGrant
mov ah,9
int 21h
jmp exit

deny:
mov dx,offset msgDeny
mov ah,9
int 21h

exit:
mov ah,4ch
int 21h

strCmp proc
cmpLoop:
mov al,[si]
mov bl,[di]
cmp al,bl
jne notEqual
cmp al,'$'
je equal
inc si
inc di
jmp cmpLoop
notEqual:
mov ax,1
ret
equal:
xor ax,ax
ret
strCmp endp

end main
