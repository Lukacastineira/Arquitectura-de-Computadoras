;2) F10 y Luces ⭐⭐ Escribir un programa que al presionar 
;F10 encienda todas las luces, y al presionarlo
;nuevamente las apague. El programa nunca termina.

             EOI EQU 20H
             IMR EQU 21H
             INT0 EQU 24H

             PB  EQU 31H
             CB EQU 33H

             N_F1O EQU 10

             ORG 40
          IP_F10 DW  RUT_F1O

          ORG 3100H
          INI_PIO: MOV AL, 0
                   OUT CB, AL
                   RET


          ORG 3200H
          RUT_F1O: PUSH AX
                   IN AL, PB
                   NOT AL
                   OUT PB, AL
                   MOV AL, EOI
                   OUT EOI, AL
                   POP AX
                   IRET

          
             ORG 2000H
             CLI
             MOV AL,  11111110B
             OUT IMR, AL
             MOV AL, N_F1O
             OUT INT0, AL   
             STI
             MOV AL, 11111111B
             OUT PB, AL
             CALL INI_PIO
      LAZO:  JMP LAZO
             END