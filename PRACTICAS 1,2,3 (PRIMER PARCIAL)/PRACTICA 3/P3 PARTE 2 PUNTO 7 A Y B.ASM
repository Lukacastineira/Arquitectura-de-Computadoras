      EOI EQU 20H
           IMR EQU 21H
           INT2 EQU 26H
           DATO EQU 40H
           ESTADO EQU 41H
           N_HAND EQU 10

           ORG 40
        IP_HAND  DW RUT_HAND

        ORG 1000H
        MSJ  DB "UNIVERSIDAD NACIONAL DE LA PLATA"
        FIN  DB ?

        ORG 3000H

       RUT_HAND:  PUSH AX
                  MOV AL, [BX]
                  OUT DATO, AL
                  INC BX
                  DEC CL
                  CMP CL, 0
                  JNZ SEGUIR
                  MOV AL, 0FFH
                  OUT IMR, AL
       SEGUIR:    MOV AL, EOI
                  OUT EOI, AL
                  POP AX
                  IRET

                IRET
           ORG 2000H
           CLI
           MOV AL, 11111011B
           OUT IMR, AL
           MOV AL, N_HAND
           OUT INT2, AL
           MOV BX, OFFSET MSJ
           MOV CL, OFFSET FIN- OFFSET MSJ

           IN AL, ESTADO
           OR AL, 10000000B
           OUT ESTADO, AL
           STI
     LOOP: JMP LOOP
           INT 0
           END