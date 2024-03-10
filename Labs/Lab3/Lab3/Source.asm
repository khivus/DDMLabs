.686
.model flat, stdcall

.stack 100h

.data

of dd 0.5
sides dd 3, 4, 5

sum dd ?
mul_temp dd ?

p dd ?
s dd ?

.code
ExitProcess PROTO STDCALL :DWORD
Start:

xor eax, eax ; reset registers
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov eax, sides[0]
add eax, sides[4] ; a + b
add eax, sides[8] ; a + b + c
mov sum, eax ; sum = a + b + c

call fpu_usage
jmp exit

fpu_usage proc

	finit ; initialization for FPU
	fld of ; 0.5 -> st0
	fild sum ; 0.5 -> st1, sum -> st0
	fmulp ; 1/2 * sum
	fstp p

	mov ebx, 0 ; index counter

	sub_and_mul_loop:
		fld p
		fild sides[ebx*4] ; a, b or c side
		fsubp ; p - a and p - b and p - c

		cmp ebx, 0 ; mul_temp is empty
		je skip_first

		fld mul_temp
		fmulp ; multiply on fly

		skip_first:
		fstp mul_temp
		
		inc ebx
		cmp ebx, 3
		jb sub_and_mul_loop ; end of loop

	fld mul_temp
	fld p
	fmulp ; p * (p-a)(p-b)(p-c)
	fsqrt ; sqrt(^)
	fistp s ; final answer in int

	ret

fpu_usage endp

exit:
Invoke ExitProcess, s
End Start