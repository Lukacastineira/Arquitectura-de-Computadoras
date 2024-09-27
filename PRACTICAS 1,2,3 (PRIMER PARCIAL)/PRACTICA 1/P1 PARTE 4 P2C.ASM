;C) Modificar el programa anterior para enviar los parámetros A, B y C a 
;través de la pila pero ahora por referencia

org 1000h
A dW 8
B dW 5
C dW 4
D dW ?
org 3000h
      MOV DX, 0
CALC: PUSH BX
mov bx,sp
ADD BX, 8
MOV AX, BX ; BACKUP DE LA PILA 
MOV CX, [BX]
MOV BX, CX 
mov dx, [bx] 
MOV BX, AX
sub bx, 2
MOV AX, BX
MOV CX, [BX]
MOV BX, CX
ADD dx, [bx]
MOV BX, AX
sub bx, 2
MOV CX, [BX]
MOV BX, CX
SUB dx, [bx]
POP BX
RET
org 2000h
mov AX, OFFSET A
push AX
MOV AX, OFFSET B
push AX
MOV AX, OFFSET C
push AX
call CALC
MOV D, DX
pop ax
pop ax
pop ax
hlt
end
