;B. ⭐⭐ Pasando los parámetros por referencia desde el programa principal a través de registros, y
;devolviendo el resultado a través de un registro por valor.

      
      
      ORG 1000H 

A DW 5
B DW 3 
RES DW ?
     
     
     ORG 3000H
MUL: MOV BX, [BX]
     MOV AX, BX ;AX A
     MOV BX, DX
     MOV BX, [BX]; BX B     
LOOP:CMP AX, 0
     JZ FIN
     CMP BX, 0
     JZ FIN
     ADD AX, 5
     DEC BX
     CMP BX, 1
     JNZ LOOP
     MOV BX, 0
     JMP FINN     
FIN: MOV AX, 0
FINN:RET     
     ORG 2000H
     MOV BX, OFFSET A
     MOV DX, OFFSET B
     MOV CL, 0
     CALL  MUL
     MOV RES, AX
INT 0
END

