;4) F10, lectura e Impresora con PIO ⭐⭐⭐ Escribir un programa que debe mostrar en pantalla el mensaje
;“PRESIONE F10 PARA COMENZAR” y una vez que el usuario presiona F10, leer de teclado un mensaje de
;10 caracteres. Este mensaje debe luego ser enviado a través de la pila a una subrutina para imprimirse en la
;impresora mediante el PIO. La configuración del PIO también debe hacerse en una subrutina aparte.
                          EOI EQU 20H
                          IMR EQU 21H
                          INT0 EQU 24H

                          PA EQU 30H
                          PB EQU 31H
                          CA EQU 32H
                          CB EQU 33H

                          N_F10 EQU 10


                          ORG 40 
                      IP_F10 DW  RUT_F10

                          ORG 1000H
                          MSJ1 DB "PRESIONE F10 PARA COMENZAR",10
                          FIN1 DB  ?
                          MSJ2 DB  ?,?,?,?,?,?,?,?,?,?
                          FIN2 DB  ?

                          ORG 3000H
                      INI_PIO: MOV AL, 11111101B 
                               OUT CA, AL
                               MOV AL, 0
                               OUT CB, AL
                               RET
                          ORG 3100H
                  POLLING:      PUSH AX
                          POLL: IN AL, PA
                                AND AL,1
                                JNZ POLL
                                POP AX
                                RET
                         
                          ORG 3200H
                          STROBE0: IN AL, PA
                                   AND AL, 11111101B
                                   OUT PA, AL 
                                   RET
                          ORG 3300H
                          STROBE1: IN AL, PA
                                   OR AL, 00000010B
                                   OUT PA, AL
                                   RET

                          ORG 3400H
                          IMPRIMIR: 
                                    MOV BX, SP
                                    ADD BX, 2
                                    MOV BX, [BX]
                                    MOV CL, OFFSET FIN2 - OFFSET MSJ2
                     SEGUIR:        CALL POLLING 
                                    MOV AL, [BX]
                                    OUT PB, AL
                                    CALL STROBE1
                                    CALL STROBE0
                                    INC BX
                                    DEC CL
                                    CMP CL, 0
                                    JNZ SEGUIR
                                    RET
                                    
                               
                          ORG 3500H
                      RUT_F10:MOV BX, OFFSET MSJ2
                              MOV AL, OFFSET FIN2 - OFFSET MSJ2
                      LEER:   INT 6
                              INC BX
                              DEC AL
                              JNZ LEER
                              MOV BX, OFFSET MSJ2
                              PUSH BX
                              CALL IMPRIMIR
                              POP BX
                              MOV AL, EOI
                              OUT EOI, AL
                              IRET

                          ORG 2000H
                          CALL INI_PIO
                          MOV AL, OFFSET FIN1 - OFFSET MSJ1
                          MOV BX, OFFSET MSJ1
                          INT 7
                          CLI
                          MOV AL, 11111110B
                          OUT IMR, AL
                          MOV AL, N_F10
                          OUT INT0, AL
                          STI
                    LOPPING: JMP LOPPING
                          INT 0
                          END