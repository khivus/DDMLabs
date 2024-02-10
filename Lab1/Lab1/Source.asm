.686
.model flat,stdcall

.stack 100h

.data
x dw 103
y dw 12
nx dw ?
ny dw ?
m dw ?

.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov ax, 0 ; Set ax value to 0
mov bx, x ; Pass value from x to bx
sub ax, bx ; Subtruction bx from ax 
mov nx, ax ; Pass value from ax to nx

mov ax, 0 ; Set ax value to 0
mov bx, y ; Pass value from y to bx
sub ax, bx ; Subtruction bx from ax 
mov ny, ax ; Pass value from ax to ny

mov ax, ny ; Pass value from ny to ax
mov bx, 4 ; Set bx value to 4
imul ax, bx ; Multiply ax by bx (4*Y')

mov bx, ax ; Pass value from ax to bx
mov ax, nx ; Pass value from nx to ax
sub ax, bx ; Subtruction ax from bx (X'-4*Y')

mov bx, ny ; Pass value from ny to bx
xor ax, bx ; Xor ax and bx ((X'-4*Y') xor Y')

mov m, ax ; Pass value from ax to m

exit:
Invoke ExitProcess, m
End Start


