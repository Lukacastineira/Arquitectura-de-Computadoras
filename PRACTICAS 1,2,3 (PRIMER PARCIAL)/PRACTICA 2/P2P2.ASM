;2) Uso de las luces y las llaves a través del PIO. ⭐⭐
;Ejecutar los programas con el simulador VonSim utilizando los dispositivos “Llaves y Luces” que conectan
;las llaves al puerto PA del PIO y a las luces al puerto PB.

;a) Patrón de Luces Fijo Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo
;las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse.

;b) Verificar Llave Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es
;así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo
;importa el valor de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se
;manejan con las teclas 0-7.

;c) Control de luces mediante llaves Escribir un programa que permite encender y apagar las luces
;mediante las llaves. El programa no deberá terminar nunca, y continuamente revisar el estado de las
;llaves, y actualizar de forma consecuente el estado de las luces. La actualización se realiza simplemente
;prendiendo la luz i, si la llave i correspondiente está encendida (valor 1), y apagándola en caso
;contrario. Por ejemplo, si solo la primera llave está encendida, entonces solo la primera luz se debe
;quedar encendida.

      


;   PB EQU 31h
;   CB EQU 33H
;  
;      ORG 2000H
;      mov al, 00000000B
;      out CB, al
;      mov al, 11000011b
;      out PB, AL
;LAZO: JMP LAZO
;      int 0
;      end


;    PA EQU 30H
;   CA EQU 32H
;       ORG 1000H
;       MSJ1 DB "Llave Prendida"
;       FIN1 DB  ?
;       MSJ2 DB "Llave Apagada"
;       FIN2 DB  ?
;       ORG 2000H
;       MOV AL, 0FFH
;       OUT CA, AL
;       IN AL, PA
;   AND AL, 10000000B
;       CMP AL, 0
;       JZ  APAGADA
;       MOV BX, OFFSET MSJ1
;       MOV AL, OFFSET FIN1-OFFSET MSJ1
;       INT 7
;       JMP FIN
;APAGADA: MOV BX, OFFSET MSJ2
;          MOV AL, OFFSET FIN2-OFFSET MSJ2
;          INT 7
;  FIN: INT 0 
;       END
    PA EQU 30H
    PB EQU 31H
    CA EQU 32H
    CB EQU 33H

        ORG 2000H
        MOV AL, 0FFH
        OUT CA, AL
        MOV AL, 0
        OUT CB, AL
   LOOP: IN AL, PA
         OUT PB, AL
         JMP LOOP
        END

