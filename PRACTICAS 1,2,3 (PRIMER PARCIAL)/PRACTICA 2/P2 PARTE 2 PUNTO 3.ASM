;3) Subrutina para el envío del carácter y la señal de Strobe ⭐⭐
;El envío de la señal de strobe se puede modularizar en una subrutina para ser reutilizado en distintas
;ocasiones. Implementar una subrutina 📄flanco_ascendente que envía el flanco ascendente (un 0 y luego


;un 1) a través del strobe. Asumir que el PIO ya está configurado correctamente para comunicarse con la
;impresora.


         PA EQU 30H
         CA EQU 32H
         ORG 3000H
FLANCO_ASCENDENTE: IN AL, PA 
                   AND AL , 11111101B
                   OUT PA, AL 
                   IN AL, PA
                   OR AL, 02H
                   OUT PA, AL
                   RET
        ORG 2000H
        END




