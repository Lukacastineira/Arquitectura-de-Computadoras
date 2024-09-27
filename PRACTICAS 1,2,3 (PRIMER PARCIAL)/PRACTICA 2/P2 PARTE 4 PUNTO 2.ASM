;2) CriptoLlaves (Llaves, Luces):⭐⭐⭐
;Escriba un programa de VonSim que permita jugar al CriptoLlaves. El usuario debe adivinar un patrón secreto
;de 8 bits que está almacenado en la memoria del programa. Para ello, debe manipular las llaves hasta que el
;patrón de bits de las llaves sea exactamente igual al del patrón secreto. Como ayuda para el usuario, si el estado
;de una llave acierta al bit correspondiente, el programa debe prender el led correspondiente. Por ejemplo, si el
;patrón es 0100 0101 y las llaves están en el estado 1110 0100, deben prenderse las luces de los bits 1, 2, 3, 4 y 6.
;Como no acertó a todos los bits, el usuario no ha adivinado el patrón y debe continuar jugando.
;El programa termina cuando el usuario acierta todos los bits del patrón, mostrando en pantalla el mensaje
;"GANASTE".


      PA EQU 30H
      PB EQU 31H
      CA EQU 32H
      CB EQU 33H


      ORG 1000H
      PATRON DB 10101010B
      MSJ DB "GANASTE"
      FIN DB ?

      ORG 3000H

      INIPIO:  MOV AL, 0FFH
               OUT CA, AL
               MOV AL, 01010101B
               OUT CB, AL
               RET
     
      ORG 3100H
      POLLING: IN AL, PA
               OUT PB, AL
               CMP AL, PATRON
               JZ FIN1
               JMP POLLING
     FIN1:     MOV AL, OFFSET FIN - OFFSET MSJ
               MOV BX, OFFSET MSJ
               INT 7
               RET
               

      
      ORG 2000H
      CALL INIPIO
      CALL POLLING
      INT 0
      END
