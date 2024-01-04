org 100h   

jmp start 

Y db 0,4,7,11,14,16,18,19,20,20,19,18,15,13,10,6,3,-1,-5,-9,-12,-15,-17,-19,-20,-20,-20,-19,-17,-15,-12,-9,-5
X db 20,20,19,17,15,12,9,5,1,-3,-6,-10,-13,-15,-18,-19,-20,-20,-19,-18,-16,-14,-11,-7,-4,0,4,7,11,14,16,18,19

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
    
    cmp bx,1        ;Compara si Bx es 1 ya que significa el boton Izquierdo
    mov bx,0        ;Inicio del contador en 0      
    
    je dibuja       ;Si es igual a 1, saltara a la etiqueta dibuja 
     
    jmp repite      ;Sino estara repitiendo el ciclo
    
dibuja:

    PIX X(bx),Y(bx) ;Ejecucion de la funcion para pintar el pixel
    
    inc bx          ;Incremento del contador
    cmp bx,33       ;Condicion de paro del ciclo
    jne dibuja      ;Si no es igual a 33, saltara a la etiqueta        
    
    jmp repite
    mov ah, 0h      ;Termina la ejecucion del programa
    int 16h

ret
                 
                 
                 