.386
Tabl1 struc
	namex db 4 dup (?)
	field1 dw 4 dup (?)
Tabl1 ENDS

Data1 segment use16
	I_struc db ?
	I_namex db ?
	A1 Tabl1 6 dup (<>)
	adress dd begin_2
Data1 ends

Code1 segment use16
	ASSUME cs:Code1, ds:Data1  
begin:
	mov ax , Data1
    mov ds , ax
    mov I_struc , 0

	loop1:
        mov I_namex , 0
        movsx bx , I_struc
        imul bx  , size Tabl1
        loop2:
            movsx di , I_namex
            lea ax , [A1[bx]].namex[di]
            shl di , 1
            mov [A1[bx]].field1[di] , ax
            inc I_namex
            cmp I_namex , 4
        jl loop2
        inc I_struc
        cmp I_struc  ,6
    jl loop1
    jmp dword ptr adress
Code1 ends

Data2 segment use16
	A2 Tabl1 13 dup (<>)
Data2 ends

Code2 segment use16
	ASSUME cs:Code2, ds:Data1, es:Data2
begin_2:
	mov ax , Data1
    mov ds , ax
    mov ax , Data2
    mov es , ax
	mov ax, 0
	mov di, 4
	imul di, size Tabl1
	mov si , 2
	loop_3:
		mov cx , 4
		rep movsb
		mov cx , 4
		rep movsw
		inc ax
        cmp ax , 6
   	 jl loop_3

	mov ax, 4C00H 
	int 21H

Code2 ends
	end begin