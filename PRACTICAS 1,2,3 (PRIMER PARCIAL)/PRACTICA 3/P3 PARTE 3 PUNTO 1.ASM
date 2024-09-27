;1) Imprimir mensaje leído, longitud arbitraria ⭐. Escribir un programa que solicite ingresar caracteres por
;teclado y los almacene en la memoria. Al presionar la tecla F10, se envían a la impresora a través de la PIO.
; No es necesario mostrar los caracteres en la pantalla

        EOI EQU 20H
        IMR EQU 21H
        INT0 EQU 24H
        
        PA EQU 30H
        PB EQU 31H
        CA EQU 32H
        CB EQU 33H
        
        N_F10 EQU 10

        ORG 40
    IP_F10 DW RUT_F10
    
   
        ORG 1000H
        MSJ  DB  ?,?,?,?
        FIN  DB  ?
        ORG 3000H

        POLL:  PUSH AX
                IN AL, PA
                AND AL, 11111111B
                JNZ POLL
                POP AX
                RET
        ORG 3100H
       STROBE0: PUSH AX
                 IN AL, PA
                AND AL, 11111101B
                OUT PA, AL
                POP AX
                RET
      ORG 3200H
      STROBE1: PUSH AX
               IN AL, PA
                OR AL, 00000010
                OUT PA, AL
                POP AX
                RET
      ORG 3300H
       IMPRIMIR_CARACTER: PUSH AX
                          CALL POLL
                          POP AX
                          OUT PB, AL
                          CALL STROBE1
                          CALL STROBE0
                          RET
         ORG 3500H
        INI_PIO: MOV AL, 11111101B
                 OUT CA, AL
                 MOV AL, 0
                 OUT CB, AL
                 RET       

                          
       ORG 3400H                  
        RUT_F10:PUSH AX
                MOV AL, 0FFH
                OUT IMR, AL   
       SEGUIR:  MOV AL, [BX]
                CALL IMPRIMIR_CARACTER
                INC BX
                DEC CL
                CMP CL, 0
                JNZ SEGUIR
                MOV AL, EOI
                OUT EOI, AL
                POP AX
                IRET

        ORG 2000H
        
        CLI
        MOV AL, 11111110B
        OUT IMR, AL
        MOV AL, N_F10
        OUT INT0, AL
        STI
        
        MOV AL, OFFSET FIN - OFFSET MSJ
        MOV BX, OFFSET MSJ
LEER:   INT 6
        INC BX 
        DEC AL
        CMP AL, 0
        JNZ LEER
        
        CALL INI_PIO
        CALL STROBE0
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN-OFFSET MSJ
  LOOP: JMP LOOP
        INT 0
        END