;4) Luces, llaves y opciones ⭐⭐⭐Escribir un programa que deberá utilizar las luces y llaves. El programa
;revisa el estado de las llaves, y evalúa estos tres casos:


;A. Verificar si todas llaves están apagadas. Si es así, mostrar en pantalla el mensaje “Fin de programa” y
;finalizar el mismo. Caso contrario, hacer tanto B como C.


;B. Actualizar las luces a su estado opuesto. Por ejemplo, si las llaves están en el estado “00011010” las
;luces tendrán el estado “11100101”.


;C. Si la primera llave (la del bit menos significativo) está prendida, mostrar en pantalla el mensaje
;“Arquitectura de Computadoras: ACTIVADA” .
;El programa sólo termina en el caso A. En los casos B y C, debe volver a revisar el estado de las llaves y evaluar
;los 3 casos otra vez.
;Las funciones ”A”, “B” y “C” deben implementarse utilizando tres subrutinas independientes. La subrutina A
;debe devolver 1 si hay que finalizar el programa y 0 de lo contrario.

                  PA EQU 30H
                  PB EQU 31H
                  CA EQU 32H
                  CB EQU 33H

                  ORG 1000H
                  MSJ_FIN DB "Fin de Programa"
                  FIN1 db ?
                  MSJ_C DB "Arquitectura de Computadoras: ACTIVADA", 10
                  FIN_C DB ?

                  ORG 3000H
                  INI_PIO:  MOV AL, 0FFH
                            OUT CA, AL
                            MOV AL, 0
                            OUT CB, AL
                            RET
                  ORG 3100H
                  A: PUSH BX
                     IN AL, PA
                     CMP AL, 0
                     JNZ FIN
                     MOV AL, OFFSET FIN1 - OFFSET MSJ_FIN
                     MOV BX, OFFSET MSJ_FIN
                     INT 7
                     MOV AL,0
                 FIN:POP BX
                     RET

                 ORG 3200H 
                 B: IN AL, PA
                    NOT AL 
                    OUT PB, AL
                    RET

                 ORG 3300H
                 C: PUSH AX
                    PUSH BX
                    IN AL, PA
                    AND AL, 00000001B
                    CMP AL, 00000001B
                    JNZ FINC
                     MOV AL, OFFSET FIN_C - OFFSET MSJ_C
                     MOV BX, OFFSET MSJ_C
                     INT 7
                FINC: POP BX
                      POP AX
                      RET
                  ORG 2000H
                  CALL INI_PIO
          LOOP:   CALL A
                  CMP AL, 0
                  JZ FIN5
                  CALL B
                  CALL C
                  JMP LOOP
         FIN5:    INT 0
                  END
                  