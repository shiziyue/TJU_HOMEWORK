.8086
.model small
.stack 256

data segment
	pbuff1 db 'Input a decimal number:','$'
	pbuff2 db 'To Hex:','$'
	pbuff3 db ' <-- STOP: Wrong key pressed.',0dh,0ah,'$'
data ends

.code segment
	assume cs:code,ds:data
rpt:
	mov ax,seg data
	mov ds,ax
	lea dx,pbuff1
	mov ah,9
	int 21h
	call dec2bin
	push ax
		lea dx,pbuff2
		mov ah,9
		int 21h
	pop ax
	call crlf
	call bin2hex
	call crlf
	jmp rpt

dec2bin proc near
	xor bx,bx
newchar:
	mov ah,1
	int 21h
	cmp al,27d
	je quit
	cmp al,13d
	je continue
	sub al,30h
	jl exit
	cmp al,9
	jg exit
	cbw
	xchg ax,bx
	mov cx,10
	mul cx
	xchg ax,bx
	add bx,ax
	jmp newchar
exit:
	push ax
		lea dx,pbuff3
		mov ah,9
		int 21h
	pop ax
continue:
	ret

dec2bin endp

bin2hex proc near
	mov ch,4
rotate:mov cl,4
	rol bx,cl
	mov al,bl
	and al,0fh
	add al,30h
	cmp al,3ah
	jl printit
	add al,07h
printit:
	mov dl,al
	mov ah,2
	int 21h
	dec ch
	jne rotate
	ret
bin2hex endp

crlf proc near
	mov dl,0dh
	mov ah,2
	int 21h
	mov dl,0ah
	mov ah,2
	int 21h
	ret
crlf endp

quit proc near
	mov ah,4ch
	int 21h
quit endp

code ends
end rpt