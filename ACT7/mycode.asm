org 100h

jmp inicio
directorio db "E:\OneDrive - Universidad de Guadalajara\TRADUCTORES\Seminario\ACT7\Efrain", 0 

 
inicio: 
    mov dx, offset directorio ; offset lugar de memoria donde esta la variable
    mov ah, 39h ; crea directorio DS:DX apunta al directorio
    int 21h ;llamada a la interrupcion DOS
    ret

