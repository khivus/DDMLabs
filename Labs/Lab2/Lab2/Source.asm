.686
.model flat, stdcall

.stack 100h

.data
x dw 1
nx dw ?
y dw 31ffh
z dw 5555h
i dw 0
ones_counter dw ?
l dw ?
m dw ?
r dw ?

.code
ExitProcess PROTO STDCALL :DWORD
Start:

xor eax, eax ; reset registers
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov ax, x
sub ax, 1 ; X - 1
mov nx, ax

mov ax, y

nx_add_y_loop: ; Loop 3 times
add ax, nx ; Add X' to Y
inc i ; Increment iterator
cmp i, 3 ; If i < 3
jb nx_add_y_loop ; jump back

mov l, ax

mov ax, nx
or ax, z ; M=X' or Z
mov m, ax

cmp ax, 1038h ; if M>10E8
ja mbigger ; Jump to mbigger

add ax, 01d0h ; M + 01d0
jmp part3 ; skip mbigger

mbigger: ; if M>10E8
sub ax, 211fh ; M - 211f

part3:
mov r, ax
mov bx, r
bsf ax, bx ; Find first ones
cmp ax, 3 ; If ones in last 4 bits
ja ones_counter_even ; Jump to last part

dec ax
mov bx, ax
mov ax, r

check_bit:
inc bx ; Bit counter
cmp bx, 4
je count_ones
bt ax, bx ; check each bit
jc inc_counter ; if 1
jnc check_bit ; if 0

inc_counter:
inc ones_counter
jmp check_bit

count_ones:
mov ax, ones_counter
mov bx, 2
div bx ; check if even or odd
cmp dx, 1 
jne ones_counter_even ; Jump if even

mov ax, r
mov bx, 2
div bx ; R / 2
jmp end_of_eva ; skip ones_counter_even

ones_counter_even:
mov ax, r
xor ax, 0f91h ; R xor 0f91

end_of_eva:
mov r, ax

exit:
Invoke ExitProcess, r
End Start