;5) Timer y Luces ⭐⭐ Escribir un programa que debe leer el estado de las llaves y enviarlo a una subrutina.
;La subrutina debe llamarse LUCES12 y recibe el estado por referencia a través de la pila. Si el estado indica
;que la llave 7 (la de más a la izquierda) está prendida entonces debe encender todas las luces por 12
;segundos y luego apagar todas las luces. En caso contrario no debe hacer nada.


               EOI EQU 20H
               IMR EQU 21H
               INT1 EQU 25H

               PB EQU 31H
               CB EQU 33H
               CONT EQU 10H
               COMP EQU 11H
               
               N_TIMER EQU 10 

               ORG 40
          IP_TIMER DW RUT_TIMER 

          
               ORG 3000H
              INI_PIO:  PUSH AX
                        MOV AL, 0
                        OUT CB, AL
                        POP AX
                        RET
 
               ORG 3100H
               LUCES12: PUSH AX
                        PUSH BX
                        MOV BX, SP
                        ADD BX, 2
                        MOV BX, [BX]
                        AND BX, 10000000B
                        JNZ FIN
                        MOV AL, 11111111B
                        OUT PB, AL
                        MOV AL, 0
                        OUT CONT, AL
                        MOV AL, 12
                        OUT COMP, AL
              FIN:      POP BX
                        POP AX
                        RET

              ORG 3200H
              RUT_TIMER:  PUSH AX
                          MOV AL, 0
                          OUT PB, AL
                          MOV AL, EOI
                          OUT EOI, AL
                          POP AX
                          IRET


               ORG 1000H 
          

               ORG 2000H
               CALL INI_PIO
               CLI
               MOV AL, 11111101B 
               OUT IMR, AL
               MOV AL, N_TIMER
               OUT INT1, AL
               STI
               MOV AL, 0
               IN AL, PB 
               PUSH AX 
               CALL LUCES12
        LOOP:  AND AL, 10000000B
               JNZ FINNN
               IN AL, CONT 
               CMP AL, 12
               JZ FINNN
               JMP LOOP
       FINNN:  INT 0
               END