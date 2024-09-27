;6) F10 con Timer

;a) Conteo regresivo ⭐⭐: Escribir un programa que implemente un conteo regresivo a partir de un valor
;(de 1 a 9) ingresado desde el teclado. El conteo debe comenzar al presionarse la tecla F10. El tiempo
;transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo. Por ejemplo, si se
;ingresa el valor 7, cuando se apreta F10 debe mostrarse en pantalla “7 6 5 4 3 2 1 0” en los 7 segundos
;siguientes

;Pista: Una vez leído el dígito se puede activar solamente la interrupción F10, y cuando se invoque la
;subrutina F10 activar el Timer para que a partir de ese momento se muestre el conteo regresivo.
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
               NUM DB ?

               ORG 3000H
               RUT_F10:   PUSH AX
                          MOV AL, 11111100B
                          OUT IMR, AL
                          MOV AL, N_TIMER
                          OUT INT1, AL
                          MOV AL, 1
                          OUT COMP, AL
                          MOV AL, 0
                          OUT CONT, AL
                          MOV AL, EOI
                          OUT EOI, AL
                          POP AX
                          IRET
              ORG 3200H
               RUT_TIMER:PUSH AX
                         PUSH BX
                         MOV AL, 1
                         MOV BX, OFFSET NUM
                         INT 7
                         DEC NUM
                         CMP NUM, 2FH
                         JZ FIN
                         MOV AL, 0
                         OUT CONT, AL
                FIN:     MOV AL, EOI
                         OUT EOI, AL  
                         POP BX
                         POP AX
                         IRET
               
         
               ORG 2000H
               CLI
               MOV AL, 11111110B
               OUT IMR, AL
               MOV AL, N_F10
               OUT INT0, AL
               STI
               MOV AL, 1
               MOV BX, OFFSET NUM
               INT 6
        LAZO:  CMP NUM, 2FH
               JZ FIN1
               JMP LAZO
       FIN1:   MOV AL, 11111111B
               OUT IMR, AL
               INT 0
               END

