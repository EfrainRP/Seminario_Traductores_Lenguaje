org 100h

jmp start 

;X db 160,157,150,138,123,105,85,65,46,29,15,6,1,1,6,15,29,46,65,85,105,123,138,150,157
;Y db 80,100,119,135,148,156,160,159,152,142,127,109,90,70,51,33,18,8,1,0,4,12,25,41,60
Y db 80, 91, 102, 113, 122, 131, 139, 146, 152, 156, 159, 160, 160, 158,154, 149, 143, 136, 127, 118, 107, 97, 86, 74, 63, 53, 42, 33, 24, 17, 11, 6, 2, 1,1, 1, 4, 8, 14, 21, 29, 38, 47, 58, 69 
X db 160, 159, 157, 153, 148, 141, 134, 125, 115, 105, 94, 83, 72, 61, 50, 40, 31, 22, 15, 9, 5, 2, 1, 1, 2, 5, 9, 15, 22, 31, 40, 50, 61, 72, 83, 94, 105, 115, 125, 134, 141, 148, 153, 157, 159 
;Y db 80,95,109,123,135,145,152,157,160,159,156,150,142,131,119,105,90,75,60,46,33,22,12,6,1,1,1,6,12,22,33,46,60
;X db 160,159,154,148,138,127,114,100,85,70,55,41,29,18,10,4,1,1,3,8,15,25,37,51,65,80,95,109,123,135,145,152,157,
COLOR EQU 0Fh       ;La expresion COLOR es igual a 0Fh (255d), como constante numerica
                    
macro PIX xo,yo     ;La expresion PIX se sustituira por definicion, incluyendo argumentos
                            ;es como se definiera una funcion
    mov Cl,xo       ;Valor de coordenada X
    mov Dl,yo       ;Valor de coordenada Y 
    add Cl,80       ;Sumatoria para centrar las X en la pantalla
    add Dl,15       ;Sumatoria para centrar las Y en la pantalla
    mov al, COLOR   ;Valor del color a pintar
    int 10h
    
    endm

start: 
    mov ah, 0       ;Establece el modo video
    mov al, 13h     ;320 x 200 en grafico
    int 10h
     
    mov ah,0Ch      ;Escribe un punto en la pantalla en modo video
    mov Bx,0        ;Inicio del contador en 1
     
repite:
    PIX X(Bx),Y(Bx) ;Ejecucion de la funcion para pintar pixel  
    
    inc Bx          ;Incremento del contador
    cmp Bx,45       ;Condicion de paro del ciclo
    jne repite      ;Si no es igual a 90, saltara a la etiqueta
   
    mov AH,0        ;Termina la ejecucion del programa
    int 16h
ret
