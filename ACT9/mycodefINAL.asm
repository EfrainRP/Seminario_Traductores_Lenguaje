org 100h   

jmp start 

;X dw 160,157,150,138,123,105,85,65,46,29,15,6,1,1,6,15,29,46,65,85,105,123,138,150,157
;Y dw 80,100,119,135,148,156,160,159,152,142,127,109,90,70,51,33,18,8,1,0,4,12,25,41,60

Y db 0,4,7,11,14,16,18,19,20,20,19,18,15,13,10,6,3,-1,-5,-9,-12,-15,-17,-19,-20,-20,-20,-19,-17,-15,-12,-9,-5
X db 20,20,19,17,15,12,9,5,1,-3,-6,-10,-13,-15,-18,-19,-20,-20,-19,-18,-16,-14,-11,-7,-4,0,4,7,11,14,16,18,19
;X db -5,-5,-6,-8,-10,-13,-16,-20,-24,-28,-31,-35,-38,-40,-43,-44,-45,-45,-44,-43,-41,-39,-36,-32,-29,-25,-21,-18,-14,-11,-9,-7,-6,

;Y db 0,9,18,27,34,40,45,48,50,50,48,44,39,32,24,15,6,-3,-12,-21,-29,-36,-42,-46,-49,-50,-49,-46,-42,-36,-29,-21,-12,-3
;X db 50,49,46,42,36,29,21,12,3,-6,-15,-24,-32,-39,-44,-48,-50,-50,-48,-45,-40,-34,-27,-18,-9,0,9,18,27,34,40,45,48,50    

;Y db 80,95,109,123,135,145,152,157,160,159,156,150,142,131,119,105,90,75,60,46,33,22,12,6,1,1,1,6,12,22,33,46,60
;X db 160,159,154,148,138,127,114,100,85,70,55,41,29,18,10,4,1,1,3,8,15,25,37,51,65,80,95,109,123,135,145,152,157,
corX dw ?           ;Valor en memoria para el eje X del mouse
corY dw ?           ;Valor en memoria para el eje Y del mouse
COLOR EQU 0Fh       ;La expresion COLOR es igual a 0Fh (255d), como constante numerica
                    
macro PIX xo,yo     ;La expresion PIX se sustituira por definicion, incluyendo argumentos
    mov cx,corX     ;Movemos la posicion del mouse para sumarle la funcion e imprimir
    mov dx,corY
    
    add cl,xo       ;Valor de coordenada X, ya con la suma del eje X del mouse
    add dl,yo       ;Valor de coordenada Y, ya con la suma del eje Y del mouse

    mov ah,0Ch      ;Escribe un punto en la pantalla en modo video      
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
    mov ax,03h      ;Lee el estado de los botones y la posicion del cursor
    int 33h
     
    mov corX,cx     ;Almacenamos en memoria las coordenadas X y Y del mouse
    mov corY,dx
    
    cmp Bx,1        ;Compara si Bx es 1 ya que significa el boton Izquierdo
    mov Bx,0        ;Inicio del contador en 0      
    
    je dibuja       ;Si es igual a 1, saltara a la etiqueta dibuja 
     
    jmp repite      ;Sino estara repitiendo el ciclo
    
dibuja:

    PIX X(bx),Y(bx) ;Ejecucion de la funcion para pintar el pixel
    
    inc Bx          ;Incremento del contador
    cmp BX,33       ;Condicion de paro del ciclo
    jne dibuja      ;Si no es igual a 33, saltara a la etiqueta        
    
    jmp repite
    mov ah, 0h      ;Termina la ejecucion del programa
    int 16h

ret
