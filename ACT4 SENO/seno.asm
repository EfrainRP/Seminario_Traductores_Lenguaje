.model small 

.data             
var1 db 5
seno db 80,100,119,135,148,156,160,159,152,142,127,109,90,70,51,33,18,8,1,0,4,12,25,41,60,80

.code

mov ax,@data     ;Almacenamos la direccion de la memoria
mov ds,ax        ;DS se encargara de poder acceder a esos datos en memoria 
mov bx,5         ;Direccionamos el valor 5 a Bx
mov si,2         ;Almacenamos el indice deseado 
mov al,(bx+4*si) ;Obtendremos el dato en aquella posicion segun la operacion 


                              
                              
