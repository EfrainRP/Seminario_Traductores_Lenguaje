.model small  
.stack 100
.data 
    msg: db " = $$$$$$$"
    mil2 db 0
    mil db 0
    cen db 0   
    dece db 0
    uni db 0 
    r dw 0

.code   
    mov ax,@data
    mov ds,ax 
     
    jmp entrada
    
    
    inicio:
        mov r,di 
                
        mov ah, 01h ;Entrada de la suma
        int 21h
        xor cx,cx
        mov cl,al   
        
        jmp entrada;quedara en DI el otro valor  
        
    entrada:
        xor ah,ah
        mov ah, 01h ;Entrada de valor a Al
        int 21h
        xor ah,ah 
        sub al,30h 
        mov mil,al
        
        mov ah, 01h ;Entrada de valor
        int 21h
        xor ah,ah  
        sub al,30h 
        mov cen,al
        
        mov ah, 01h ;Entrada de valor
        int 21h 
        xor ah,ah 
        sub al,30h 
        mov dece,al
        
        mov ah, 01h ;Entrada de valor
        int 21h 
        xor ah,ah   
        sub al,30h 
        mov uni,al 
        
        xor ax,ax ;limpiamos
        xor bx,bx  
        
        ;Juntamos 
        mov bl,uni
        mov di,bx
        
        xor ax,ax
        mov al,dece
        mov bx,10
        mul bx 
        add di,ax 
        
        xor ax,ax
        mov al,cen
        mov bx,100
        mul bx 
        add di,ax
        
        xor ax,ax
        mov al,mil
        mov bx,1000
        mul bx  
        
        add di,ax ;resultado en di   
        
        xor bx,bx ;Limpiamos registros
        xor ax,ax 
        
        cmp cl, '+'
        jz suma 
        
        jmp inicio       
    
    suma:    
        add r,di 
        xor di,di ; Limpiamos
        jmp mostrar
    
    
    mostrar: 
        xor ax,ax ;Limpiamos registros
        xor cx,cx
     
        mov ax,r
        xor dx,dx 
        mov bx,1000
        div bx 
        aam
        mov mil2,ah
        mov mil,al
        mov ax,dx 
        
        mov bx,100
        xor dx,dx
        div bx
        mov cen,al
        mov ax,dx 
        
        mov bx,10
        xor dx,dx
        div bx
        mov dece,al
        mov uni,dl

        mov bx,3 
        mov ah,mil2  
        add ah,30h
        mov msg[bx],ah
        
        mov ah,mil 
        add ah,30h
        mov msg[bx+1],ah

        mov ah,cen 
        add ah,30h
        mov msg[bx+2],ah
        
        mov ah,dece 
        add ah,30h
        mov msg[bx+3],ah 
        
        mov ah,uni
        add ah,30h
        mov msg[bx+4],ah
          
        mov ah,09h
        mov dx,msg
        int 21h
