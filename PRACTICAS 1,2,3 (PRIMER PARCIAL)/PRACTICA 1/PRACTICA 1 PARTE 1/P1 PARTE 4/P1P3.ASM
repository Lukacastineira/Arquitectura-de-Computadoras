   ORG 1000H
MAYUSC DB 'A',10

           ORG 3000H 
           PUSH AX 
SIGUIENTE: MOV AL, 2
           INT 7
           CMP BYTE PTR [BX], 5AH
           JZ FIN
             ADD BYTE PTR [BX], 1
           JMP SIGUIENTE
           POP AX
FIN:       RET

ORG 2000H
mov BX, OFFSET MAYUSC
CALL SIGUIENTE 
HLT
END