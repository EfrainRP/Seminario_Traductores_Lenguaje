.model small  
.stack 100
.data
    val: db "Introduzca valor: $" 
    msg: db "El resultado es: $$$$$$"   
    newl: db 0Dh,0Ah,24h
    mil2 db 0
    mil db 0
    cen db 0   
    dece db 0
    uni db 0 
    r dw 0

.code   
    mov ax,@data
    mov ds,ax 

    mov ah,09h
    mov dx,val  ;Intrucciones para la impresion
    int 21h     ;de la cadena para meter un valor       
    
    mov ch,0
    jmp entrada ;Funcion para introducir 1er numero                        
    
    inicio:
        mov r,di    ;Guardar 1er numero en r (del registro)     
       
        mov ah,09h
        mov dx,newl ;Intrucciones para "imprimir" 
        int 21h     ;y posicionar una nueva linea

        mov dx,val  ;Intrucciones para la impresion
        int 21h     ;de la cadena para meter el otro valor 
        
        jmp entrada ;Funcion para introducir 2ndo numero en Di  
        
    entrada:
        xor ax,ax   ;Limpiamos
        mov ah, 01h 
        
        int 21h     ;Entrada del 1er digito
        sub al,30h  ;Lo convertimos en numero desde el ASCII
        mov mil,al  ;Guardar en memoria
        
         
        int 21h     ;Entrada del 2ndo digito
        sub al,30h  ;Lo convertimos en numero desde el ASCII
        mov cen,al  ;Guardar en memoria
        
         
        int 21h     ;Entrada del 3er digito
        sub al,30h  ;Lo convertimos en numero desde el ASCII
        mov dece,al
        
         
        int 21h     ;Entrada del 4to digito
        sub al,30h  ;Lo convertimos en numero desde el ASCII
        mov uni,al  ;Guardar en memoria
        
        xor ax,ax   ;Limpiamos
        xor bx,bx  
        
        ;Juntamos las cifras en el regirto Di, multiplicando por
            ;multiplos de 10 con su respectiva cifra para sumarse
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
        add di,ax   ;Resultado final en Di   
        
        xor bx,bx   ;Limpiamos registros  
        xor ax,ax 
        
        inc ch      ;Incrementara nuestro contador 
                        ;para hacerlo 2 veces
        cmp ch,2    ;Va comparando con el 2
        jl  inicio  ;Si es menor que "2", saltara 
               
    multi:
        add ax,r    ;Empezamos sumamos el mismo numero
        dec di      ;Decrementa el "contador", que es el otro operando
        cmp di,0    ;Va comparando con el 0
        jg multi    ;Saltara si es mayor que "0", el numero
        jmp mostrar ;Sino cumple se mostrara el numero final
        
    mostrar:
        xor di,di    ;Limpiamos registros   
        xor cx,cx
        
        xor dx,dx 
        mov bx,1000
        div bx      ;Dividimos entre 1000
        aam         ;AAM dividira las ultimas cifras para 
        add ah,30h      ;las milesimas y diezmilesimas
        mov mil2,ah
        add al,30h
        mov mil,al
        mov ax,dx 
        
        mov bx,100
        xor dx,dx
        div bx      ;Dividimos entre 100 para las centenas
        add al,30h  
        mov cen,al
        mov ax,dx 
        
        mov bx,10
        xor dx,dx
        div bx      ;Dividimos entre 10 para las decimas
        add al,30h
        mov dece,al
        add dl,30h
        mov uni,dl  ;El resto de la division son las unidades 
        
        mov ah,09h
        mov dx,newl
        int 21h

        mov bx,17    ;Introducion de valores en la memoria MSG 
        mov ah,mil2  
        mov msg[bx],ah
        
        mov ah,mil 
        mov msg[bx+1],ah

        mov ah,cen 
        mov msg[bx+2],ah
        
        mov ah,dece 
        mov msg[bx+3],ah 
        
        mov ah,uni
        mov msg[bx+4],ah
          
        mov ah,09h
        mov dx,msg  ;Instruccion para mostrar la cadena 
        int 21h         ;final del resultado
         
         
 