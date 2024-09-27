;1. 📄 CONTAR_CAR ⭐ Recibe la dirección de comienzo de un string en BX, su longitud en AL, y el
;carácter a contar en AH. Retorna en CL la cantidad de veces que aparece el carácter.


    org 1000h
    MENSAJE DB "hola buenas tardes", 0
    F db ?
    CAR db 'O'
    CANT DW  ?
    org 3000h
  CONTARCAR:  CMP BYTE PTR [BX], AH
               JNZ SIG 
                 INC CX
   SIG:          INC BX 
           CMP BYTE PTR [BX], 0
           JZ FIN
           JMP CONTARCAR
   FIN:     RET
    org 2000h 
    mov BX,   OFFSET MENSAJE
    MOV AL, OFFSET F-OFFSET MENSAJE
    MOV AH, CAR
    MOV CL, 0
    CALL CONTARCAR
    MOV CANT, CX
    HLT
END
