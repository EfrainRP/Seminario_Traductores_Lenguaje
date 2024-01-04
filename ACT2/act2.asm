        org  100h	; set location counter to 100h
        jmp inicio

inicio: mov al, 7Ah ;               al =  0111 1010 = 122
        neg al      ;      AL = NEG AL = 1000 0110 =  134
        
        ret        ;retorno el control al sistema operativo