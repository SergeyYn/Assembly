.386
.model flat, C
.code 
Big3sSub proc @mas1:dword, @mas2:dword, @mas3:dword, @carry:byte, @len:word

	mov esi, @mas2
	mov edi, @mas3
	mov ecx, @mas1
	mov eax, 0
	mov bx, 4
	mov dh, 0
	cmp @len, bx
	jle mark
	loop1:
		mov edx, [esi]
		sub edx, eax
		sub edx, [edi]

		jc AddFlag

		mov eax, 0

		jmp ENDiteration

		AddFlag:
			mov eax, 1

		ENDiteration:
		mov [ecx], edx
		add bx, 4
		lea esi, [esi] + 4
		lea edi, [edi] + 4
		lea ecx, [ecx] + 4
		cmp bx, @len
		jle loop1

	mov dh, al
	mark:
	mov ax, @len
	mov bl, 4
	div bl
	mov bh, ah
	cmp ah, 0
	jg AddCycle

	ret

	AddCycle:
	mov al, dh
	mov bl, 0
	loop2:
		mov dl, [esi]
		sub dl,al
		sub dl, [edi]
		jc AddFlag2

		mov al, 0

		jmp ENDiteration2

		AddFlag2:
			mov al, 1

		ENDiteration2:
		mov [ecx], dl
		add bl, 1
		lea esi, [esi] + 1
		lea edi, [edi] + 1
		lea ecx, [ecx] + 1
		cmp bl, bh
		jl loop2
	ret




Big3sSub endp
end