
code SEGMENT            ;7 6 5 4 3 2 1 0 початкові значення 
     ASSUME cs:code     ;6 4 7 6 5 1 5 1 результат

begin:
        mov dl, 01001101b   ; занесення початкових даних в регістр dl
        xor dh, dh   		; обнуляємо регістр dh 

      ; 0-ий розряд
        mov ah, dl       	; копіюємо регістр dl в регістр ah   
        and ah, 00000010b   ; виділяємо 1 розряд 
        shr ah, 1         	; робимо зсув вправо на 1 розряд 
        or dh, ah 			; заносимо в регістр dh значення за допомогою логічного АБО
        xor ah, ah  		; обнуляємо регістр аh

	  ; 1-ий розряд
        mov ah, dl          
        and ah, 00100000b   
        mov cl, 4
        shr ah, cl         
        or dh, ah 
        xor ah, ah 
 
	  ; 2-ий розряд
        mov ah, dl          
        and ah, 00000010b   
        shl ah, 1         
        or dh, ah 
        xor ah, ah  

         ; 3-ий розряд
        mov ah, dl          
        and ah, 00100000b
        mov cl, 2   
        shr ah, cl         
        or dh, ah 
        xor ah, ah
	
         ; 4-ий розряд
        mov ah, dl          
        and ah, 01000000b 
        mov cl, 2   
        shr ah, cl         
        or dh, ah 
        xor ah, ah

         ; 5-ий розряд
        mov ah, dl          
        and ah, 10000000b
        mov cl, 2    
        shr ah, cl        
        or dh, ah 
        xor ah, ah

         ; 6-ий розряд
        mov ah, dl          
        and ah, 00010000b 
        mov cl, 2   
        shl ah, cl         
        or dh, ah 
        xor ah, ah

        ; 7-ий розряд
        mov ah, dl          
        and ah, 01000000b   
        shl ah, 1         
        or dh, ah 
        xor ah, ah

    mov ax, 4c00h    
    int 21h 

code ENDS
    end begin
