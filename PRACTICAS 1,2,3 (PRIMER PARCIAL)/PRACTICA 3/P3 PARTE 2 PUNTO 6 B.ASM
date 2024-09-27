;6) F10 con Timer

;b) Conteo regresivo con pausa ⭐⭐ Escribir un programa que cuente de forma regresiva desde 9 hasta 0,
;mostrando el tiempo en pantalla.. Luego de que termine de contar, si se presiona F10 debe comenzar de
;nuevo la cuenta desde 9 hasta 0. Además, si en algún momento se presiona la tecla F10 durante el
;conteo, el mismo debe pausarse, y reanudarse sólo cuando se presiona nuevamente F10.
;Pista: Utilizar un flag de estado “PAUSA” que se controla mediante la tecla F10, y que la subrutina
;del timer puede consultar para saber si debe decrementar el contador y mostrar en pantalla.

               EOI  EQU 20H
               IMR EQU 21H
               INT0 EQU 24H
               INT1 EQU 25H
               CONT EQU 10H
               COMP EQU 11H


               N_F10 EQU 10
               N_TIMER EQU 15

               ORG 40
               IP_F10 DW RUT_F10

               ORG 60
                IP_TIMER DW RUT_TIMER

               ORG 1000H
               NUM DB "9",10
               PAUSA DB 0
               CONTEO DB 0
               
               ORG 3000H
               RUT_F10:   PUSH AX
                          CMP CONTEO, 1
                          JNZ NO_SEGUIR
                          MOV CONTEO, 0
                          MOV AL, 0
                          OUT CONT, AL
                          MOV AL, 0FCH
                          JMP SEGUIR
                          
                NO_SEGUIR: CMP PAUSA, 0
                           JZ PAUSARR
                           MOV PAUSA, 0
                           MOV AL, 0FCH
                           JMP SEGUIR 
                           
                PAUSARR:   MOV PAUSA, 1
                           MOV AL, 0
                           OUT CONT, AL
                           MOV AL, 1111110B
                           
                 SEGUIR:  OUT IMR, AL
                          MOV AL, EOI
                          OUT EOI, AL
                          POP AX
                          IRET
              ORG 3200H
               RUT_TIMER:PUSH AX
                         PUSH BX
                         MOV AL, 2
                         MOV BX, OFFSET NUM
                         INT 7
                         CMP NUM, 30H
                         JNZ SEGUI
                         MOV AL, 0FEH
                         OUT IMR, AL
                         MOV AL, 0
                         OUT CONT, AL
                         MOV CONTEO, 1
               SEGUI:    DEC NUM
                         MOV AL, 0
                         OUT CONT, AL
                         MOV AL, EOI
                         OUT EOI, AL  
                         POP BX
                         POP AX
                         IRET
               
         
               ORG 2000H
               CLI
                MOV AL, 0FCH
                OUT IMR, AL
                MOV AL, N_F10
                OUT INT0, AL
                MOV AL, N_TIMER
                OUT INT1, AL
                MOV AL, 0
                OUT CONT, AL
                MOV AL, 1
                OUT COMP, AL
               STI
        LAZO:  CMP NUM, 2FH
               JZ RESET
               JMP LAZO
        RESET: ADD NUM, 10
               JMP LAZO
               INT 0
               END


