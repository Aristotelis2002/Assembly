MODEL small

stack 256

.data      
msgencrypt db 200 dup (?)          
cryptcount db '0'
helper db '0'
symbol db ?
message db 'Enter an input:', '$'
message1 db "Wrong input $"
message2 db "Max encryption reached $"
message3 db "Max decryption reached $"
filename db "message.txt"
handle dw 0
.code
.386
main:
	mov ax, @data
	mov ds, ax
	
	xor bx,bx
	mov cx, 200
	lea dx, filename
	mov al, 02h
	mov ah,3dh
	int 21h
	mov handle, ax
	mov bx, bx
	mov ah, 3fh
	mov bx, handle
	mov dx, offset msgencrypt
	int 21h
	
start:
	
	mov ah, 09h
	mov dx, offset message
	int 21h

	mov ah, 01h
	int 21h
	
	mov symbol, al
	
	mov ah, 02h
	mov dl, 10
	int 21h
	
	cmp symbol,'1'
	je  encrypt
	cmp symbol,'2'
	je  decrypt
	cmp symbol,'0'
	je  exit
wronginput:
	mov ah, 09h
	mov dx, offset message1
	int 21h
	jmp newline
maxencryption:
	mov ah, 09h
	mov dx, offset message2
	int 21h
	jmp newline
maxdecryption:
	mov ah, 09h
	mov dx, offset message3
	int 21h
	jmp newline
newline:
	mov dl, 10
	mov ah, 02h
	int 21h
	mov dl, 13
	mov ah, 02h
	int 21h
	jmp start
encrypt:
	cmp cryptcount, '3'
	je maxencryption
	cmp cryptcount, '1'
	je enprint2
	cmp cryptcount, '2'
	je enprint3
	
	mov  bx, offset msgencrypt
	inc  cryptcount
enprint1:
	mov  dl, [bx]            
	cmp  dl, ? 
	je  newline
	sub  dl, 1
	mov  [bx],dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp enprint1

enprint2:
	inc  cryptcount
	mov  bx, offset msgencrypt
enprint2_1:
	mov  ax, [bx]
	xor dx,dx
	mov cx, 2
	div cx
	cmp dx, 0
	je evenn
odd:
	xor  dx,dx
	mov  dl, [bx]
	cmp  dl, ? 
	je  newline
	sub  dl, 2
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                 
	jmp  enprint2_1

evenn:
	xor  dx,dx
	mov  dl, [bx]
	cmp  dl, ? 
	je  newline
	add  dl, 10
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp  enprint2_1
	
enprint3:    ;prez 1, -5 ili +5
	inc  cryptcount
	mov  bx, offset msgencrypt
	mov  helper, '0'
enprint3_1:
	cmp helper, '0'
	je first
	cmp helper, '1'
	je second
first:
	inc helper
	mov  dl, [bx]            
	cmp  dl, ? 
	je  newline
	sub  dl, 5
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp enprint3_1
second:
	dec helper
	mov  dl, [bx]            
	cmp  dl, ? 
	je  newline
	add  dl, 5
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp enprint3_1



decrypt:
	cmp cryptcount, '0'
	je maxdecryption
	cmp cryptcount, '2'
	je deprint2
	cmp cryptcount, '3'
	je deprint3
	
	
	mov  bx, offset msgencrypt
	dec  cryptcount
deprint1:
	mov  dl, [bx]           
	cmp  dl, ? 
	je  newline
	add  dl, 1
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp  deprint1
deprint2:
	dec  cryptcount
	mov  bx, offset msgencrypt
deprint2_1:
	mov  ax, [bx]
	xor dx,dx
	mov cx, 2
	div cx
	cmp dx, 0
	je evenn1
odd1:
	xor  dx,dx
	mov  dl, [bx]
	cmp  dl, ? 
	je  newline
	add  dl, 2
	mov  [bx], dl
	mov  ah, 02h           
	int  21h
	inc  bx                 

	jmp  deprint2_1

evenn1:
	xor  dx,dx
	mov  dl, [bx]
	cmp  dl, ? 
	je  newline
	sub  dl, 10
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp  deprint2_1
deprint3:    
	mov  helper, '0'
	dec  cryptcount
	mov  bx, offset msgencrypt
deprint3_1:
	cmp helper, '0'
	je first1
	cmp helper, '1'
	je second1
first1:
	inc helper
	mov  dl, [bx]            
	cmp  dl, ? 
	je  newline
	add  dl, 5
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp deprint3_1
second1:
	dec helper
	mov  dl, [bx]            
	cmp  dl, ? 
	je  newline
	sub  dl, 5
	mov  [bx], dl
	mov  ah, 02h             
	int  21h
	inc  bx                  
	jmp deprint3_1
	
exit:
	mov ax, 4c00h
	int 21h
end	main











