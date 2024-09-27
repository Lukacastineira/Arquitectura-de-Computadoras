;1. Recibe un carácter en el registro AL y retorna en AH el valor 0FFh si es
; mayúscula y 0 de lo contrario.



    org 1000h
    CAR DB 'z'
    
    org 3000h
  MAYUSOMINUS:  CMP AL, 'a'
               Js  SIG
                   MOV AH, 0
                   jmp fin
       SIG:    mov ah, 0FFH
       fin:   RET
    org 2000h 
    mov AL, CAR
    CALL MAYUSOMINUS
    HLT
END
