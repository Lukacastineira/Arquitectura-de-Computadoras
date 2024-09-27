;b) ¿Qué deberías modificar en
; a) para mostrar los dígitos (“0” al “9”)? 
   ORG 1000H
MAYUSC DB '0'

           ORG 3000H 
           PUSH AX 
SIGUIENTE: ADD BYTE PTR [BX], 1
           MOV AL, 1
           INT 7
           CMP BYTE PTR [BX], 39H
           JZ FIN
           JMP SIGUIENTE
           POP AX
FIN:       RET

ORG 2000H
mov BX, OFFSET MAYUSC
mov al, 1
int 7
CALL SIGUIENTE 
HLT
END




;¿Y para mostrar todos los carácteres disponibles en el código ASCII? Probar en el simulador.
   ORG 1000H
MAYUSC DB ' '

           ORG 3000H 
           PUSH AX 
SIGUIENTE: ADD BYTE PTR [BX], 1
           MOV AL, 1
           INT 7
           CMP BYTE PTR [BX], 7FH
           JZ FIN
           JMP SIGUIENTE
           POP AX
FIN:       RET

ORG 2000H
mov BX, OFFSET MAYUSC
mov al, 1
int 7
CALL SIGUIENTE 
HLT
END
