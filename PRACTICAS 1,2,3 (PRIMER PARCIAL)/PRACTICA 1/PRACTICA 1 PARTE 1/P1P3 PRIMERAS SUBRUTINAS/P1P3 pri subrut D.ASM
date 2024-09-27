;4. Convertir string a minúscula ⭐ 
;Escribir un programa que convierta todos los carácteres de un string
;MENSAJE a minúscula.
;Por ejemplo, si MENSAJE contiene “Hola, Buenas Tardes”, 
;luego de ejecutar el
;programa debe contener “hola, buenas tardes”.



       ORG 1000H 
        MENSAJE DB "Hola, Buenas Tardes"
        FIN1 DB 0
        
        ORG 3000H
CONVERT:  CMP BYTE PTR [BX], 61H
          JNC SEGUIR
          CMP BYTE PTR [BX], 41H
          JC SEGUIR
             ADD BYTE PTR [BX], AH
SEGUIR:   ADD BX, 1
          CMP BYTE PTR [BX], 0
          JZ FIN     
          JMP CONVERT
   FIN:    RET
        
        ORG 2000H
        MOV AH, 61H
        SUB AH, 41H
        MOV  BX, OFFSET MENSAJE
        CALL CONVERT
        MOV bx, offset mensaje
        MOV AL, 19
        INT 7 
        HLT
    END
