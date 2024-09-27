;⭐⭐ Pasando los parámetros por valor desde el programa principal a través de registros, y
;devolviendo el resultado a través de un registro por referencia.


      
      
      ORG 1000H 

A DB 5
B DB 3 
RES DW ?
     
     
     ORG 3000H
MUL: PUSH CX   
LOOP:CMP AL, 0
     JZ FIN
     CMP AH, 0
     JZ FIN
     ADD AL, A
     DEC AH
     CMP AH, 1
     JNZ LOOP
     MOV BX, 0
     JMP FINN     
FIN: MOV AL, 0
FINN:MOV AH, 0
     MOV RES, AX
     MOV  BX, OFFSET RES
     POP CX
     RET     
     ORG 2000H
     MOV AL,  A
     MOV AH,  B
     MOV CL, 0
     CALL  MUL
     MOV BX, [BX]
INT 0
END
