.686
.model flat, stdcall

.stack 100h

.data
x dw 0d5a9h
nx dw ?
y dw 31ffh
z dw 5555h
i dw 0
l dw ?
m dw ?
r dw ?

.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0

mov ax, x
sub ax, 1 ; X - 1
mov nx, ax

mov ax, y
mov bx, i

nx_add_y_loop: ; Loop 3 times
add ax, nx ; Add X' to Y
add bx, 1 ; Iterator
cmp bx, 3
jb nx_add_y_loop

mov l, ax

mov ax, nx
or ax, z ; M=X' or Z
mov m, ax

cmp ax, 10E8h ; if M>10E8
ja mbigger ; skip else

sub ax, 211fh ; if M<=10E8
mov r, ax
jmp part3 ; skip mbigger part

mbigger: ; if M>10E8 part
mov ax, m
add ax, 01d0h
mov r, ax

part3:
; idk what is it


exit:
Invoke ExitProcess, 1
End Start