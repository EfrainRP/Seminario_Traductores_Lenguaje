.model small  ; Modelo reducido para tener de 64Kb

.data  ; Definicion del segmento de datos


.code  ; Definicion del segmento de codigo
     
    mov ah,01h ; Entrada de teclado
    int 21h    ; LLmada a la funcion
    mov ah,00h ; Limpiamos Ah para el display  
    aaa        ; Correjira el resultado de Al a un valor 
                    ; decimal desempaquetado 
    mov bx,ax  ; Almacenamos el primer valor introducido
    out 199,ax ; Imprimimos el 1er valor introducido al display
    
    
    mov ah,01h ; Entrada de teclado 
    int 21h    ; LLmada a la funcion  
    mov ah,00h ; Limpiamos Ah para el display    
    aaa        ; Correjira el resultado de Al a un valor 
                    ; decimal desempaquetado
    mov cx,ax  ; Almacenamos el segundo valor introducido
    out 199,ax ; Imprimimos el 2ndo valor introducido al display
    
    mov ax,bx  ; Movemos el resultado de Bx a Ax 
    mul cx     ; Ax = Ax * Cx
    aaa        ; Correjira el resultado de Al a un valor 
                    ; decimal desempaquetado 
    add al,30h ; Se suma 30h para adecuarlo al ASCII para 
                    ; la imprsion en pantalla    
    mov dl,al  ; Movemos el resultado para la pantalla a la salida
    mov ah,2h  ; Exhibe salida
    int 21h    ; LLmada a la funcion
    mov ah,00h ; Limpiamos Ah para el display
    aaa        ; Correjira el resultado de Al a un valor 
                    ; decimal desempaquetado
    out 199,ax ; Imprimimos el 1er valor introducido al display

  