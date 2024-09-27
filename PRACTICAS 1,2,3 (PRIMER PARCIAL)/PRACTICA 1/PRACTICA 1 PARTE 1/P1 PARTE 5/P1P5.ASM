;5) Acceso con contraseña ⭐⭐ Escribir un programa que solicite el ingreso de una contraseña de 4
;caracteres por teclado, sin visualizarla en pantalla. En caso de coincidir con una clave predefinida (y
;guardada en memoria) que muestre el mensaje "Acceso permitido"; caso contrario mostrar el mensaje
;"Acceso denegado", y volver a pedir que se ingrese una contraseña. Al 5to intento fallido, debe mostrarse el
;mensaje “Acceso BLOQUEADO” y terminar el programa.


   ORG 1000H
CONTRASENA DB "hola"
FIN1 DB ?
MSJ1 DB "ACCESO PERMITIDO",10
MSJ2 DB "ACCESO DENEGADO",10
MSJ3 DB "ACCESO BLOQUEADO",10
ACCESO DB   ?

          
           ORG 3000H  
determinar:    push bx
               push ax
               push dx
               push cx
               mov dl, 0
               mov al, 4
               mov bx, offset  acceso
       loop:   int 6
               inc bx
               dec al
               jnz loop
               mov ax, 0
      loop2:   mov bx, offset CONTRASENA 
               add bx, ax
               mov cl, [bx]
               mov bx, offset ACCESO
               add bx, ax
               cmp cl, [bx]
               JNZ incorrecto  
                 inc ax
                 cmp ax, 4
                 jnz loop2
                 jmp correcto 
  incorrecto:  inc dl
               cmp dl, 5
               jz bloqueado 
               MOV AL, 16
               MOV BX, OFFSET MSJ2
               INT 7  
               mov al, 4
               mov bx, offset  acceso
               jmp loop
  bloqueado:   MOV Al, 17
               MOV BX, OFFSET MSJ3
               INT 7
               JMP FIN            
  CORRECTO:   MOV AL, 17
              MOV BX, OFFSET MSJ1
              INT 7
       FIN:   pop cx
              pop dx
              pop ax 
              pop bx
              RET
ORG 2000H
CALL DETERMINAR 
INT 0
END