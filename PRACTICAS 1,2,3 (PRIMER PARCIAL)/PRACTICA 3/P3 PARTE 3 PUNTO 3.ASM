;3) Ruleta, F10 y azar ⭐⭐ Escribir un programa que permita seleccionar un dígito al azar para jugar a la
;ruleta. Para eso, el programa principal debe iterar continuamente, cambiando un valor de un registro desde
;el ‘0’ hasta el ‘9’ (y volviendo al ‘0’ luego del ‘9’). Cuando se presiona F10, la letra queda “seleccionada” en
;base al valor del registro, y debe mostrarse de inmediato en la pantalla. Luego el programa termina
           EOI EQU 20H
           IMR EQU 21H
           INT0 EQU 24H
           N_F10  EQU 10
           ORG 40
      IP_F10 DW RUT_F10

           ORG 1000H
           NUM DB "0"
           ORG 3000H
           RUT_F10:  PUSH AX
                     MOV AL, 1
                     MOV BX, OFFSET NUM
                     INT 7
                     MOV NUM, 19
                     MOV AL, EOI
                     OUT EOI, AL
                     POP AX
                     IRET
           ORG 2000H
           CLI
           MOV AL, 0FEH
           OUT IMR, AL
           MOV AL, N_F10
           OUT INT0, AL
           STI
    LOOP:  MOV BX, OFFSET NUM
           MOV AL, 1
           INT 7
           CMP NUM, 19
           JZ FIN1
           INC NUM
           CMP NUM, 3AH
           JNZ LOOP
           MOV NUM, 30H
           JMP LOOP
    FIN1:  INT 0
           END