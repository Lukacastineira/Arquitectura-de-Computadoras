;B) Idem el inciso anterior, pero los valores A, B y C se reciben mediante pasaje de parámetros por valor
;a través de la pila. El resultado se devuelve de igual forma por el registro dl y por valor.

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
mov dx, [bx]
sub bx, 2
ADD dx, [bx]
sub bx, 2
SUB dx, [bx]
POP BX
RET
org 2000h
mov AX, A
push AX
MOV AX, B
push AX
MOV AX, C
push AX
call CALC
MOV D, DX
pop ax
pop ax
pop ax
hlt
end
