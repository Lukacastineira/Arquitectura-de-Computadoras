;3. 📄 A_MINUS ⭐ Recibe un carácter mayúscula en AL y lo devuelve como minúscula


    org 1000h
    CAR DB 'A'
    
    org 3000h 
               
  MAYUSOMINUS: CMP AL, 'a'
               JNS  FIN
                   ADD AL, DL 
       fin:    RET
    org 2000h 
    mov AL, CAR
    MOV DL, 'a'
    SUB DL, 'A'
    CALL MAYUSOMINUS
    HLT
END
