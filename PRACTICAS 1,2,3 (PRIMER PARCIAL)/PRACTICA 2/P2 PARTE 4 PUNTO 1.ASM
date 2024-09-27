;1) Juego de Luces con Rotaciones ⭐⭐⭐
;Escribir un programa que encienda una luz a la vez, de las ocho conectadas al puerto paralelo del
;microprocesador a través de la PIO, en el siguiente orden de bits:
;0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-..., es decir, 00000001, 00000010,
;00000100, etc. El programa nunca termina. Para ello, deberá utilizar las subrutinas ROTAR_IZQ y

;ROTAR_DER_N, que le permitirán rotar el bit de estado de las luces y generar el juego
;correspondiente.
;Las rotaciones son operaciones que, aunque no parezca, tienen muchas utilidades, como dividir o
;multiplicar por dos de forma rápida, o manipular los bits de un byte, pero no hay una instrucción que

;las implemente directamente. 📄 ROTARIZQ: Escribir una subrutina ROTARIZQ que aplique una rotación hacia la izquierda a los
;bits de un byte almacenado en la memoria. Dicho byte debe pasarse por valor desde el programa
;principal a la subrutina a través de registros y por referencia. No hay valor de retorno, se modifica
;directamente la celda de memoria referenciada.




        PB EQU 31H
        CB EQU 33H
        
        ORG 1000H
        BYT DB 00000001B
        DER DB 7

        ORG 3000H
        INI_PIO:  MOV AL, 0
                  OUT CB, AL          
                  RET
        ORG 3100H 
        ROTARIZQ:    ADD AL, AL
                     ADC AL, 0
                     RET
        ORG 3200H
        ROTARIZQN: PUSH CX
                   AND CX, 7
       SIGOROTIZQ: CMP CX, 0
                   JZ FINROTIZQ
                   CALL ROTARIZQ
                   DEC CX
                   JMP SIGOROTIZQ
      FINROTIZQ:   POP CX
                   RET

        ORG 3300H
       ROTARDERECHA:  PUSH CX
                      NEG CX
                      ADD CX, 8
                      CALL ROTARIZQN
                      POP CX 
                      RET
                  

        ORG 2000H
        CALL INI_PIO
        MOV BX, OFFSET BYT
        MOV AL, [BX]
        MOV CX, 1
  LOOP: OUT PB, AL
        CALL ROTARIZQ
        CMP AL, 128
        JNZ LOOP      
  LOOPDERECHA: OUT PB, AL
               CALL ROTARDERECHA
               CMP AL,1
               JNZ LOOPDERECHA
               JMP LOOP
               INT 0 
               END