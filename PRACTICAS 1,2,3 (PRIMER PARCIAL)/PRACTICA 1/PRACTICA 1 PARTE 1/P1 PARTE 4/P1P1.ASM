;a) Escribir un programa que muestre en pantalla las letras mayúsculas (“A” a la “Z”).
;Pista: Podés buscar los códigos de la “A” y la “Z” en una tabla de códigos ascii. No utilizar un vector.
;Usar una sola variable de tipo db, e incrementar el valor de esa variable antes de imprimir


   ORG 1000H
MAYUSC DB 'A'

           ORG 3000H 
           PUSH AX 
SIGUIENTE: ADD BYTE PTR [BX], 1
           MOV AL, 1
           INT 7
           CMP BYTE PTR [BX], 5AH
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