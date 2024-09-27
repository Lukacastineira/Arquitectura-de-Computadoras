;5) Uso de la impresora a través del HAND-SHAKE. ⭐⭐
;El HANDSHAKE es un dispositivo diseñado específicamente para interactuar con la impresora mediante el
;protocolo centronics. Por este motivo, no requiere enviar la señal de flanco ascendente manualmente; en
;lugar de eso, al escribir un valor en su registro DATA, el mismo HANDSHAKE manda el flanco ascendente.
;Ejecutar los programas configurando el simulador VonSim con los dispositivos “Impresora (Handshake)”
;a) Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora a través del
;HAND-SHAKE. La comunicación se establece por consulta de estado (polling). Para ello, implementar
;la subrutina imprimir_caracter_hand que funcione de forma análoga a imprimir_caracter pero con el
;handshake en lugar del PIO.
;b) ¿Qué diferencias encuentra con el ejercicio anterior? ¿Cuál es la ventaja en utilizar el HAND-SHAKE
;con respecto al PIO para comunicarse con la impresora? ¿Esta ventaja también valdría para otros
;dispositivos, como las luces?



        IMR EQU 21H
        INT2 EQU 26H
        DATO EQU  40H
        ESTADO EQU 41H
        
        ORG 1000H
        MSJ DB ?,?,?,?,?,?,?,?
        FIN DB ?

        ORG 3000H
        INI_HAND: IN AL, ESTADO
                  AND AL, 01111111B  ;OR AL, 10000000B SI ES POR INTERRUPCION
                  OUT ESTADO, AL
                  RET
        ORG 3100H
        POLL:     IN AL, ESTADO
                  AND AL, 00000001B
                  JNZ POLL 
                  RET
                  
       ORG 3400H                   
       IMPRIMIR_CARACTER: PUSH AX
                          CALL POLL  ;SACO SI ESTA ACTIVADA LA INTERRUPCION
                          POP AX
                          OUT DATO, AL
                          RET
                          

        ORG 2000H
        CALL INI_HAND   
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN - OFFSET MSJ
  LAZO: INT 6
        MOV AL, [BX]
        CALL IMPRIMIR_CARACTER
        INC BX
        DEC CL
        JNZ LAZO
  LOOOP: JMP LOOOP
        INT 0
        END