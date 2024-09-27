;E. ⭐⭐⭐ Pasando los parámetros por referencia desde el programa principal a través de la pila, y
;devolviendo el resultado a través de un registro por valor
      
      
      ORG 1000H 

A DB 5
B DB 3 
RES DW ?
     
     
     ORG 3000H
MUL: 
     MOV BX, SP
     ADD BX, 2
     MOV AX, [BX]
LOOP:CMP AL, 0
     JZ FIN
     CMP AH, 0
     JZ FIN
     ADD AL, A
     DEC AH
     CMP AH, 1
     JNZ LOOP
     MOV AH, 0
     JMP FINN     
FIN: MOV AL, 0
FINN:MOV AH, 0
     MOV RES, AX
     RET     
     ORG 2000H
     MOV AL, A
     MOV AH, B
     PUSH AX
     CALL  MUL
     POP DX
INT 0
END
