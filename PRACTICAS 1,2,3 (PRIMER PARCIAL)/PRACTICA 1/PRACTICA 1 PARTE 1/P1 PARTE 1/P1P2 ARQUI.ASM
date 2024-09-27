;2. Es mayúscula ⭐ Escribir un programa que determine si un carácter
;(un string de longitud 1) es una letra mayúscula. 
;El carácter está almacenado en la variable C, 
;y el resultado se guarda en la variable RES de 8 bits. 
;Si C es mayúscula,  debe almacenarse el valor 0FFh en RES
; de lo contrario, debe almacenarse 0.
;Pista: Los códigos de las mayúsculas son todos consecutivos. 
;Buscar en la tabla ASCII
;los caracteres mayúscula, 
;y observar qué valores ASCII tienen la ‘A’ y la ‘Z’


        ORG 1000H 
        C DB 'Z'
        RES DB ?

        
        ORG 3000H
COMPARA:  CMP BYTE PTR [BX], 61H
        JS  SIG
            MOV CX, 0
           JMP FIN
   SIG: MOV CX, 0FFH
   FIN:    RET
        
        ORG 2000H
        MOV BX,OFFSET C
        CALL COMPARA
        MOV RES, CL
        HLT
    END
        