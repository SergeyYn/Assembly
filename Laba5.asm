.386

data segment use16
	mouseX dw 0
	mouseY dw 0
data ends

code SEGMENT use16
ASSUME cs:code, ds:data


prmaus 	proc 	far
	push ds    
	push es
	pusha
	push 0b800h
	pop es	

	mov mouseX, cx
	mov mouseY, dx

	mov ax, mouseX
	shr ax, 3
	mov mouseX, ax
	mov ax, mouseY
	shr ax, 3
	mov mouseY, ax
	mov ax, 160
	mul mouseY
	mov mouseY, ax
	shl mouseX, 1
	mul mouseX
	mov ecx, mouseY
	add ecx, mouseX

	cmp byte ptr es:[ecx*1], 48
	jg mark1
	je process_zero
	jmp final
	mark1:
	cmp byte ptr es:[ecx*1], 57
	jl process
	je process_nine
	jg mark2


	mark2:
	cmp byte ptr es:[ecx*1], 65
	jg mark3
	je process_A
	jmp final
	mark3:
	cmp byte ptr es:[ecx*1], 70
	jl process
	je process_F
	jmp final


	process:
	cmp bx, 10b
	je increm
	cmp bx, 01b
	je decrem

	increm:
	inc byte ptr es:[ecx*1]
	jmp final
	decrem:
	dec byte ptr es:[ecx*1]
	jmp final

	process_zero:
	cmp bx, 10b
	je inc_zero
	cmp bx, 01b
	je dec_zero

	inc_zero:
	inc byte ptr es:[ecx*1]
	jmp final

	dec_zero:
	mov byte ptr es:[ecx*1], 70
	jmp final


	process_nine:
	cmp bx, 10b
	je inc_nine
	cmp bx, 01b
	je dec_nine

	inc_nine:
	mov byte ptr es:[ecx*1], 65
	jmp final

	dec_nine:
	dec byte ptr es:[ecx*1]
	jmp final


	process_F:
	cmp bx, 10b
	je inc_F
	cmp bx, 01b
	je dec_F

	inc_F:
	mov byte ptr es:[ecx*1], 48
	jmp final

	dec_F:
	dec byte ptr es:[ecx*1]
	jmp final

	process_A:
	cmp bx, 10b
	je inc_A
	cmp bx, 01b
	je dec_A

	inc_A:
	inc byte ptr es:[ecx*1]
	jmp final

	dec_A:
	mov byte ptr es:[ecx*1], 57
	jmp final

	final:
	popa
	pop es
	pop ds
	ret
prmaus endp

begin:
mov ax,0b800h
mov es,ax
mov ax,3
int 10h

mov cx, 1000
mov ax,00f41h
rep stosw
mov cx, 1000
mov ax,00f14h
rep stosw


xor ax,ax
int 33h
mov ax,0ch
mov cx, 01010b
push es
push cs
pop es
lea dx, prmaus
int 33h
pop es


mov ah, 01h
int 21h
xor cx,cx
mov ax,0ch
int 33h
MOV AX, 4C00H
INT 21H
code ENDS
	end begin

