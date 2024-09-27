;5) Timer, tres usos: periódico infinito, periódico finito, y única vez ⭐⭐


;a) Escribir un programa que muestra el mensaje “Vamos las interrupciones!” una vez cada 2 segundos y
;no termine nunca.


;b) Modificar a) para que termine a los 10 segundos.


;c) Modificar a) para que solo imprima una vez, a los 10 segundos, y luego termine.


;d) Desafío: Modificar a) para que el primer mensaje se imprima luego de 1 segundo, el segundo luego de 2
;segundos, el tercero luego de 3, y así sucesivamente, hasta que se espere 255 en el último mensaje, y el
;programa termine,



            EOI EQU 20H
            IMR EQU 21H
            INT1 EQU 25H
            CONT EQU 10H
            COMP EQU 11H
            N_TIMER EQU 10

            ORG 40
         IP_TIMER DW RUT_TIMER

         ORG 1000H
         MSJ DB "VAMOS LAS INTERRUPCIONES",10
         FIN DB ?
         TERMINA DB 1

         ORG 3000H
         RUT_TIMER:  PUSH AX
                     PUSH BX
                     MOV BX, OFFSET MSJ
                     MOV AL, OFFSET FIN - OFFSET MSJ
                     INT 7
                     INC TERMINA
                     MOV AL, TERMINA
                     OUT COMP, AL
                     CMP AL, 0
                     JNZ SIGUE
                     MOV AL, 0FFH
                     OUT IMR, AL
       SIGUE:        MOV AL, EOI
                     OUT EOI, AL
                     MOV AL, 0
                     OUT CONT, AL
                     POP BX
                     POP AX
                     IRET
                     

            ORG 2000H
            CLI
            MOV AL, 11111101B 
            OUT IMR, AL
            MOV AL, N_TIMER
            OUT INT1, AL
            MOV AL, TERMINA
            OUT COMP, AL
            MOV AL, 0
            OUT CONT, AL
            STI
    LOOP:  CMP TERMINA, 0
           JNZ LOOP
     FIN1:  INT 0
            END



     ;       EOI EQU 20H
  ;          IMR EQU 21H
   ;         INT1 EQU 25H
  ;          CONT EQU 10H
   ;         COMP EQU 11H
   ;         N_TIMER EQU 10

   ;         ORG 40
   ;      IP_TIMER DW RUT_TIMER
;
   ;      ORG 1000H
   ;      MSJ DB "VAMOS LAS INTERRUPCIONES",10
   ;      FIN DB ?
    ;     TERMINA DB 0

   ;      ORG 3000H
   ;      RUT_TIMER:  PUSH AX
      ;               PUSH BX
     ;                MOV BX, OFFSET MSJ
       ;              MOV AL, OFFSET FIN - OFFSET MSJ
     ;                INT 7
     ;                INC TERMINA
     ;               MOV AL, 0FFH
      ;               OUT IMR, AL
      ;               MOV AL, EOI
       ;              OUT EOI, AL
     ;;                MOV AL,0
     ;                OUT CONT, AL
      ;               POP BX
      ;               POP AX
      ;               IRET
                     

     ;       ORG 2000H
     ;       CLI
    ;;        MOV AL, 11111101B 
    ;        OUT IMR, AL
     ;       MOV AL, N_TIMER
     ;       OUT INT1, AL
    ;        MOV AL, 10
    ;        OUT COMP, AL
     ;       MOV AL, 0
     ;       OUT CONT, AL
    ;        STI
  ;  LOOP:  CMP TERMINA, 0
  ;          JZ LOOP
  ;   FIN1:  INT 0
  ;          END



   ;         EOI EQU 20H
  ;          IMR EQU 21H
  ;          INT1 EQU 25H
 ;           CONT EQU 10H
 ;           COMP EQU 11H
 ;           N_TIMER EQU 10
;
 ;           ORG 40
;         IP_TIMER DW RUT_TIMER
;
;         ORG 1000H
;         MSJ DB "VAMOS LAS INTERRUPCIONES",10
;         FIN DB ?
 ;        TERMINA DB 0

;         ORG 3000H
   ;      RUT_TIMER:  PUSH AX
  ;                   PUSH BX
    ;                 MOV BX, OFFSET MSJ
      ;               MOV AL, OFFSET FIN - OFFSET MSJ
     ;                INT 7
        ;             INC TERMINA
    ;                 MOV AL, EOI
       ;              OUT EOI, AL
       ;              POP BX
      ;               POP AX
       ;              IRET
                     

       ;     ORG 2000H
   ;         CLI
     ;       MOV AL, 11111101B 
   ;         OUT IMR, AL
  ;          MOV AL, N_TIMER
   ;         OUT INT1, AL
   ;         MOV AL, 2
  ;          OUT COMP, AL
   ;         MOV AL, 0
    ;        OUT CONT, AL
  ;          STI
;    LOOP:  CMP TERMINA, 5
 ;          MOV AL,0
 ;         OUT CONT, AL
 ;          JNZ LOOP
 ;    FIN1:  INT 0
  ;          END





 ; EOI EQU 20H
  ;          IMR EQU 21H
  ;          INT1 EQU 25H
  ;          CONT EQU 10H
   ;         COMP EQU 11H
   ;         N_TIMER EQU 10
;
   ;         ORG 40
   ;      IP_TIMER DW RUT_TIMER

  ;       ORG 1000H
  ;       MSJ DB "VAMOS LAS INTERRUPCIONES",10
   ;      FIN DB ?

   ;      ORG 3000H
   ;      RUT_TIMER:  PUSH AX
   ;                  PUSH BX
     ;                MOV BX, OFFSET MSJ
      ;               MOV AL, OFFSET FIN - OFFSET MSJ
      ;               INT 7
     ;                MOV AL, EOI
     ;                OUT EOI, AL
    ;                 POP BX
     ;                POP AX
    ;                 IRET
                     
;
    ;        ORG 2000H
    ;        MOV AL, 11111101B 
   ;         OUT IMR, AL
     ;       MOV AL, N_TIMER
    ;        OUT INT1, AL
   ;         MOV AL, 2
     ;       OUT COMP, AL 
  ;  LOOP:   MOV AL, 0
     ;;       OUT CONT, AL
     ;       JMP LOOP
     ;       INT 0
     ;       END


