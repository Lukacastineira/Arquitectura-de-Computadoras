;b) Imprimir mensaje fijo Escribir un programa para imprimir el mensaje 
;“ORGANIZACION Y
;ARQUITECTURA DE COMPUTADORAS” utilizando la impresora a través de la PIO.
;Utilizar la subrutina imprimir_caracter del inciso anterior.


        PA EQU 30H
        PB EQU 31H
        CA EQU 32H
        CB EQU 33H

        ORG 1000H
        MSJ DB "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
        FIN DB ?

        ORG 3000H
        INI_PIO:  MOV AL, 11111101B
                  OUT CA, AL
                  MOV AL, 11111111B
                  OUT CB, AL
                  RET
        ORG 3100H
        POLL:     IN AL, PA
                  AND AL, 00000001B
                  JNZ POLL 
                  RET 
       ORG 3200H
       STROBE0: IN AL, PA
                AND AL, 11111101B
                OUT PA, AL
                RET
       ORG 3300H
       STROBE1: IN AL, PA
                OR AL, 02H
                OUT PA, AL
                RET
                  
       ORG 3400H                   
       IMPRIMIR_CARACTER: PUSH AX
                          CALL POLL 
                          POP AX
                          OUT PB, AL
                          CALL STROBE1
                          CALL STROBE0
                          RET
                          

        ORG 2000H
        CALL INI_PIO
        CALL STROBE0
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN - OFFSET MSJ
  LAZO: MOV AL, [BX]
        CALL IMPRIMIR_CARACTER
        INC BX
        DEC CL
        CMP CL, 0
        JNZ LAZO
        INT 0
        END