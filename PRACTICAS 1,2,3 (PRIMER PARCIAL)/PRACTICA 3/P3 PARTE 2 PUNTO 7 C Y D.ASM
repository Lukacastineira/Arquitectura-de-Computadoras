;7) Impresión con HANDSHAKE mediante interrupciones ⭐⭐


;a) Escribir un programa que imprime “UNIVERSIDAD NACIONAL DE LA PLATA” en la impresora a
;través del HAND-SHAKE. El envío de los caracteres se realiza por interrupciones emitidas desde el
;HAND-SHAKE cada vez que detecta que la impresora se desocupa.


;b) Probar el programa utilizando:

;1) Una velocidad de reloj del 100%, y una velocidad de impresión del 25%

;2) Una velocidad de reloj del 25%, y una velocidad de impresión del 100%
;¿En qué caso sería mejor utilizar consulta de estado en lugar de interrupciones?

;c) Modificar a) de modo que el string a imprimir se lea desde teclado. El string a leer tiene una longitud
;fija de 10 caracteres, y se lee de forma completa antes de comenzar la impresión. Tener en cuenta
;entonces que las interrupciones deben esperar a que se ingrese todo el string.

;d) Modificar b) de modo que cuando se presione F10 se cancele la impresión. En tal caso, deben
;desactivarse las interrupciones del HANDSHAKE para evitar que se envíen más caracteres a imprimir.

           EOI EQU 20H
           IMR EQU 21H
           INT0 EQU 24H
           INT2 EQU 26H
           DATO EQU 40H
           ESTADO EQU 41H
           N_HAND EQU 10
           N_F10 EQU 15

           ORG 40
        IP_HAND  DW RUT_HAND

        ORG 60
        IP_F10 DW RUT_F10

        ORG 1000H
        MSJ  DB ?,?,?,?,?,?,?,?,?,?
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

      ORG 3200H
      RUT_F10: PUSH AX
               MOV AL, 11111111B
               OUT IMR, AL
               MOV AL, EOI
               OUT EOI, AL
               POP AX
               
               IRET


                IRET
           ORG 2000H
           MOV BX, OFFSET MSJ
           MOV AL, OFFSET FIN- OFFSET MSJ
 LOOP1:     INT 6 
           INC BX
           DEC AL
           JNZ LOOP1
           
           CLI
           MOV AL, 11111010B
           OUT IMR, AL
           MOV AL, N_F10
           OUT INT0, AL
           MOV AL, N_HAND
           OUT INT2, AL
           MOV BX, OFFSET MSJ
           MOV CL, OFFSET FIN- OFFSET MSJ

           IN AL, ESTADO
           OR AL, 10000000B
           OUT ESTADO, AL
           STI
     LOOP: IN AL, IMR
           CMP AL, 0FFH
           JNZ LOOP
           INT 0
           END