org 100h
jmp inicio
directorio  db "E:\program files\emu8086\emu8086\MyBuild\Efrain", 0 
directorio1 db "E:\program files\emu8086\emu8086\MyBuild\Efrain\Robles.text", 0 
directorio2 db "E:\program files\emu8086\emu8086\MyBuild", 0 
handle dw ? 
texto db "holacomoestasesperoestesbien"
leido db "$" 
aux db "$"
cont db 0
 
inicio: 
    ;Crea carpeta
    mov dx, offset directorio   ;Buffer con la direccion deseada a crear
    mov ah, 39h                 ;Crea subdirectorio / carpeta deseado
    int 21h                     
    
    jc error                    ;Verificacion de bandera C de la carpeta creada
    
    ;Entra a la carpeta
    mov dx, offset directorio   ;Buffer con la direccion deseada a entrar
    mov ah, 3Bh                 ;Establece el directorio actual   
    int 21h 
    
    jc error                    ;Verificacion de bandera C de la carpeta encontrada
    
    ;Creamos archivo
    mov dx, offset directorio1  ;Buffer con la direccion deseada a crear
    mov ah, 3Ch                 ;Creacion del archivo
    int 21h                     ;Devolviendo: Ax=Handle  C=0/1 segun su ejecucion
    
    jc error                    ;Verificacion de bandera C del archivo creado     
    mov handle, ax              ;Handle almacenado en memoria                           

    ;Escribir archivo
    mov bx, handle              ;Bx=(Handle)Manejador del archivo texto
    mov cx, 28                  ;Cx=Numero de bytes deseados a leer
    mov dx, offset texto        ;Dx=Buffer de nuestra cadena a ser cargado(archivo a escribir)
    mov ah, 40h                 ;Escritura desde archivo / dispositivo    
    int 21h 
                                ;Verificacion de bandera C del archivo modificado 
    jc error 
    
    ;Cierre de archivo (handle)
    mov bx, handle              ;Bx=(Handle)Manejador del archivo texto
    mov ah, 3Eh                 ;Cierre del manejador de archivo(Handle)
    int 21h
    
    jc error                    ;Verificacion de bandera C del archivo cerrado 
    
    ;Abrir archivo (handle)
    mov al, 0h                  ;Seleccion de modo de lectura
    mov dx, offset directorio1  ;Dx=Buffer de nuestra cadena a ser cargado(archivo a leer)
    mov ah, 3Dh                 ;Apertura del archivo
    int 21h  
    
    jc error                    ;Verificacion de bandera C del archivo a leer 
    mov handle,ax               ;Actualizamos nuevo handle    
;Inicio de un ciclo de lectura
leer: 
    ;Lectura del archivo 
    mov bx, handle              ;Bx=(Handle)Manejador del archivo texto
    mov cx, 1                   ;Cx=Numero de bytes deseados a leer
    mov dx, offset leido        ;Dx=Buffer de nuestra cadena a ser cargado(archivo a escribir)
    mov ah, 3Fh                 ;Lectura del archivo de texto     
    int 21h 
    
    jc error                    ;Verificacion de bandera C del archivo leido
    
    cmp ax, 0                   ;Ax quedara en 0 cuando llega a EOF 
    jz FIN                      ;Si es cumple entonces va a fin para cerrar archivo 
    
    mov dl, leido[0]            ;Detectar palabras que terminan con e
    cmp dl, " "                 ;Comparar si es espacio
    jnz mostrar                 ;Si es espacio entonces ir a mostrar 
    
    jmp abajo                   ;Si no es espacio entonces ir a abajo  
    
mostrar: 
    cmp aux, "e"                ;Compara si el anterior es e
    jnz abajo
    inc cont                    ;Si es e entonces incrementar contador

abajo: 
    mov aux, dl                 ;Guardar en aux lo que hay en dl para comparar en la proxima vuelta
    jmp leer                    ;Regresa a la etiqueta leer

FIN: 
    ;Cierre de archivo (handle)                           
    mov bx, handle              ;Bx=(Handle)Manejador del archivo texto
    mov ah, 3Eh                 ;Cierre del manejador de archivo(Handle)
    int 21h
                                                                  
    jc error                    ;Verificacion de bandera C del archivo cerrado
    
    xor ax,ax                   ;Limpiamos registro
    mov dl,cont                 ;Movemos la variable contador a Dl
    add dl,30h                  ;Sumamos 30 para representacion ASCII
    mov ah,2h                   ;Instruccion para exhibir salida
    int 21h   
    
    ;Eliminacion de archivo de la carpeta
    mov dx, offset directorio1  ;Dx=Buffer de nuestra cadena a ser eliminado(archivo a borrar)
    mov ah,41h                  ;Borrar archivo del directorio 
    int 21h
    
    jc error                    ;Verificacion de bandera C del archivo borrado   
        
    ;Eliminacion de la carpeta
    mov dx, offset directorio    ;Dx=Buffer de nuestra cadena a ser eliminado(carpeta a borrar)
    mov ah, 3Ah                  ;Elimina el subdirectorio/carpeta  
    int 21h 
    
    jc error                     ;Verificacion de bandera C de la carpeta borrado    
    error:     
    ret

