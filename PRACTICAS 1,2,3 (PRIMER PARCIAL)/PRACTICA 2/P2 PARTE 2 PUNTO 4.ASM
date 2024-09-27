;4) Uso de la impresora a través de la PIO ⭐⭐
;Ejecutar los programas configurando el simulador VonSim con los dispositivos “Impresora (PIO)”. En esta
;configuración, el puerto de datos de la impresora se conecta al puerto PB del PIO, y los bits de busy y strobe
;de la misma se conectan a los bits 0 y 1 respectivamente del puerto PA


;Imprimir letra fija Escribir un programa para imprimir la letra “A” utilizando la impresora a través de
;la PIO. Recordar que el programa deberá esperar hasta que el bit de busy esté apagado, luego enviar el
;carácter, y luego enviar el flanco ascendente a través de la señal de strobe. Modularizar el programa en
;4 subrutinas:


;📄 ini_pio: Inicializa el PIO configurando los registros CA y CB según corresponde a strobe, busy y
;puerto de datos


;📄 poll: Consulta el bit busy de la impresora, e itera hasta esté en 0. Cuando está en 0 la subrutina
;retorna sin devolver ninǵun valor


;📄 flanco_ascendente: Igual que la subrutina implementada en el ejercicio anterior


;📄 imprimir_caracter: Recibe un carácter a imprimir en AL, y utilizando poll y flanco_ascendente,
;realiza todos los pasos necesarios para enviar a la impresora el carácter


        PA EQU 30H
        PB EQU 31H
        CA EQU 32H
        CB EQU 33H

        ORG 1000H
        CHAR DB 1

        ORG 3000H
        INI_PIO:  MOV AL, 11111101B
                  OUT CA, AL
                  MOV AL, 11111111B
                  OUT CB, AL
                  RET
        ORG 3100H
        POLL:     IN AL, PA
                  AND AL, 00000001B
                  JNZ POLL 
                  RET 
       ORG 3200H
       FLANCO_ASCENDENTE: IN AL, PA
                          AND AL, 11111101B
                          OUT PA, AL
                          IN AL, PA
                          OR AL, 02H
                          OUT PA, AL
                          RET
       ORG 3300H                   
       IMPRIMIR_CARACTER: PUSH AX
                          CALL POLL 
                          POP AX
                          OUT PB, AL
                          CALL FLANCO_ASCENDENTE 
                          RET
                          

        ORG 2000H
        CALL INI_PIO
        MOV AL, CHAR
        CALL IMPRIMIR_CARACTER
        INT 0
        END