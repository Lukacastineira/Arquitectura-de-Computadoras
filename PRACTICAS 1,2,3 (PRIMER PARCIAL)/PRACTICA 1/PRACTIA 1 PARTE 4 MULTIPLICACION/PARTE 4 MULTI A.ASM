      ORG 1000H 

A DB 5
B DB 3 
RES DW ?
     
     
     ORG 3000H
MUL: CMP AL, 0
     JZ FIN
     CMP AH, 0
     JZ FIN
     ADD AL, A
     DEC AH
     CMP AH, 1
     JNZ MUL
     MOV AH, 0
     JMP FINN     
FIN: MOV AL, 0
FINN:RET     
     ORG 2000H
     MOV AL, A
     MOV AH, B
     MOV CL, 0
     CALL  MUL
     MOV RES, AX
INT 0
END

