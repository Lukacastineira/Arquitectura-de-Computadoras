;3. Convertir carácter a minúscula ⭐ 
;Escribir un programa que convierta un carácter de mayúsculas a minúsculas. 
;El carácter está almacenado en la variable C. 
;Asumir que el carácter es una mayúscula. Pista: 
;Las mayúsculas y las minúsculas están en el mismo orden en el ASCII, 
;y por ende la distancia entre, 
;por ejemplo, la “A” y la “a” es la misma que la distancia entre 
;la “Z” y la “z”.



        ORG 1000H 
        C DW 'B'
        RES DW ?

        
        ORG 3000H
CONVERT:  CMP CL, 61H
        JS  SIG
           JMP FIN
   SIG: ADD CX, AX
   FIN:    RET
        
        ORG 2000H
        MOV AX, 61H
        SUB AX, 41H
        MOV CX, C
        CALL CONVERT
        MOV C, CX
        HLT
    END
        