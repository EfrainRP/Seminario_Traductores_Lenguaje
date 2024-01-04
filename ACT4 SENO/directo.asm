.model small 

.data
seno db 80,100,119,135,148,156,160,159,152,142,127,109,90, 70,51,33,18,8,1,0,4,12,25,41,60,80


.code

mov ax,@data
mov ds,ax
mov bx,2
mov al,[bx] 

ret   ; return to the operating system.






