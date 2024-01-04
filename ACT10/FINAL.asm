org 100h   

jmp start 

corX0 dw ?           ;Valor en memoria para la coordena X0 del mouse
corY0 dw ?           ;Valor en memoria para la coordena Y0 del mouse 

corX1 dw ?           ;Valor en memoria para la coordena X1 del mouse
corY1 dw ?           ;Valor en memoria para la coordena Y1 del mouse   


COLOR EQU 0Fh       ;La expresion COLOR es igual a 0Fh (255d), como constante numerica
                    
macro DRAW          ;La expresion DRAW se sustituira por definicion para ejecutar el codigo dentro de el   
    mov ah,0Ch      ;Escribe un punto en la pantalla en modo video, con lo que tenga en Cx y Dx, con la int 10h      
    mov al, COLOR   ;Valor del color a pintar
    int 10h
    endm

start:
    mov ax, @data   ;Se almacena la direccion de memoria de nuestro arreglos
    mov ds, ax      ;Guardandola en el registro para las direcciones
     
    mov ah, 0       ;Establece el modo video
    mov al, 13h     ;320 x 200 en grafico
    int 10h     
    
    mov ah,0h       ;Verifica driver del raton
    int 33h            
    
repite:    
    mov ax, 03h     ;Lee el estado de los botones y la posicion del cursor
    int 33h
     
    mov corX0, cx   ;Almacenamos en memoria las coordenadas X0 y Y0 del mouse
    mov corY0, dx
    
    cmp bx, 1       ;Compara si Bx es 1 ya que significa el boton Izquierdo    
    mov bx, 0
    jne repite      ;Si NO es igual a 1, saltara a la etiqueta repite 

repite1: 
    mov ax,03h      ;Lee el estado de los botones y la posicion del cursor
    int 33h
     
    mov corX1, cx   ;Almacenamos en memoria las coordenadas X1 y Y1 del mouse
    mov corY1, dx
    
    cmp bx, 1       ;Compara si Bx es 1 ya que significa el boton Izquierdo    
    jne repite1     ;Si NO es igual a 1, saltara a la etiqueta dibuja 
    
    mov ah,0Ch      ;Escribira un punto en la pantalla en modo video, con lo que tenga en Cx y Dx, con la int 10h      
    mov al, COLOR   ;Valor del color a pintar
  
    mov cx, corX0   ;Moveremos las coordenas de X0, Y0, para empezar a dibujar la figura
    mov dx, corY0
    
dibujaX0:
  
    int 10h             ;Ejecucion de la definicion de DRAW
    inc cx           ;Incremento del registro Cx para recorrer en el eje X
    cmp cx, corX1    ;Condicion de paro del ciclo
    jne dibujaX0     ;Si no es igual a distancia X1, saltara a la etiqueta dibujaX0   

dibujaY1: 
   
    int 10h             ;Ejecucion de la definicion de DRAW
    inc dx           ;Incremento del registro Dx para recorrer en el eje Y
    cmp dx, corY1    ;Condicion de paro del ciclo
    jne dibujaY1     ;Si no es igual a distancia Y1, saltara a la etiqueta dibujaY1
 
dibujaX1:
  
    int 10h             ;Ejecucion de la definicion de DRAW
    dec cx           ;Decremento del registro Cx para recorrer en el eje X
    cmp cx, corX0    ;Condicion de paro del ciclo
    jne dibujaX1     ;Si no es igual a distancia X0, saltara a la etiqueta dibujaX1  

dibujaY0:  
  
    int 10h             ;Ejecucion de la definicion de DRAW
    dec dx           ;Decremento del registro Cx para recorrer en el eje Y
    cmp dx, corY0    ;Condicion de paro del ciclo
    jne dibujaY0     ;Si no es igual a distancia Y0, saltara a la etiqueta dibujaY0
        
    mov ah, 0h       ;Termina la ejecucion del programa
    int 16h
    
ret
                 
                 
                 