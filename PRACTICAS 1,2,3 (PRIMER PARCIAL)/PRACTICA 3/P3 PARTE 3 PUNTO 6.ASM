;6) F10, impresora con HS y dígitos ⭐⭐⭐ Escribir un programa para imprimir en la impresora un conteo
;regresivo en base a un dígito ingresado por teclado. Por ejemplo, si el usuario ingresa “3”, se debe imprimir
;“3 2 1 0”. El programa comienza leyendo un carácter dígito con la subrutina 📄 LEER_DIGITO. Luego espera
;a que el usuario presione F10 para comenzar la impresión, y llama a la subrutina 📄 DESCENDER que la
;implementa. 📄 LEER_DIGITO muestra en pantalla el mensaje “INGRESE UN NUMERO DEL 1 AL 9:” y lee un
;carácter de teclado. Si el carácter ingresado no corresponde al número solicitado, se debe volver a leer un
;carácter hasta que el usuario ingrese efectivamente un número del 1 al 9. 📄 DESCENDER recibe el dígito por valor y por la pila, y envía a la impresora en forma descendente
;desde el número ingresado hasta el “0”, utilizando el Handshake por Consulta de Estado.

                       EOI EQU 20H
                       IMR EQU 21H
                       INT0 EQU 24H
                       INT2 EQU 26H

                       DATO EQU 40H
                       ESTADO EQU 41H

                       N_F10 EQU 10
                       N_HANDSHAKE EQU 15

                       ORG 40 
                  IP_F10 DW RUT_F10

                       ORG 60
                  IP_HANDSHAKE DW DESCENDER

                       ORG 1000H
                  MSJ1 DB "INGRESE UN NUMERO DEL 1 AL 9",10
                  FIN1 DB ?
                  CHAR DB ?
                  FIN2 DB ?


                       ORG 3000H 
                       LEER_DIGITO: MOV BX, OFFSET CHAR
                                    MOV AL, OFFSET FIN2- OFFSET CHAR 
                             LEER:  INT 6
                                    CMP CHAR, 30H
                                    JS LEER
                                    CMP CHAR, 3AH
                                    JNS LEER
                                    RET

                      ORG 3200H
                      DESCENDER: MOV BX, SP
                                 ADD BX, 2
                                 MOV BL, [BX]
                      POLL:      IN AL, ESTADO 
                                 AND AL, 1
                                 JNZ POLL
                                 MOV AL, BL
                                 OUT DATO, AL
                                 DEC BL
                                 CMP BL, 2FH
                                 JZ FINNN
                                 JMP POLL
                      FINNN:     MOV AL, EOI
                                 OUT EOI, AL
                                 IRET

                      
                     


                      ORG 3400H 
                      RUT_F10: MOV CX, 0
                               MOV CL, CHAR
                               PUSH CX
                               CALL DESCENDER
                               MOV AL, EOI
                               OUT EOI, AL
                               IRET
                       
                       ORG 2000H
                       CLI
                       MOV AL, 11111010B
                       OUT IMR, AL
                       MOV AL, N_F10
                       OUT INT0, AL 
                       MOV AL, N_HANDSHAKE
                      OUT INT2, AL
                       IN AL, ESTADO
                      AND AL, 01111111B
                        OUT ESTADO, AL
                       STI
                       MOV AL, OFFSET FIN1 - OFFSET MSJ1
                       MOV BX, OFFSET MSJ1
                       INT 7  
                       CALL LEER_DIGITO
             LOOP:     JMP LOOP          
                       INT 0       
                       END