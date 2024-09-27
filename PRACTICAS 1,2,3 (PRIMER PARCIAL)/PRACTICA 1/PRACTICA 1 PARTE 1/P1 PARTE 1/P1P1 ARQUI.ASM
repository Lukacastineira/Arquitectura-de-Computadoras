;1. Contar letras ⭐ Escribir un programa que dado un string llamado MENSAJE, almacenado en la
;Memoria de datos, cuente la cantidad de veces que la letra ‘a’ (minúscula) aparece en MENSAJE y lo
;almacene en la variable CANT. Por ejemplo, si MENSAJE contiene “Hola, Buenas Tardes”, entonces
;CANT debe valer 3.



    org 1000h
    MENSAJE DB "hola buenas tardes", 0
    CANT DW  ?
    org 3000h
   CONTARCAR:  CMP BYTE PTR [BX], 67h 
          JNZ SIG 
               INC CX
   SIG:        INC BX 
           CMP BYTE PTR [BX], 0
           JZ FIN
           JMP CONTARCAR
   FIN:     RET
    org 2000h 
    mov BX,   OFFSET MENSAJE
    MOV CX, 0
    CALL CONTARCAR
    MOV CANT, CX
    HLT
END
