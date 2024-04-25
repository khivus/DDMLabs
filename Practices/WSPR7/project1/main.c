#include <8052.h>
#include <htc.h>
 
int flag, brrr, rrrb;

void imp(unsigned int cnt)
{
	unsigned int cnt2 = cnt;
	do{ 
		if (cnt != 0) {cnt--; P1 = 0x0;}
		else {
			P1 = brrr; 
			rrrb++;
			if (rrrb >= 10) {
				rrrb = 0;
				brrr += 0x1;
				if (brrr == 0xFF) break;
			}
		}

	} while (TF2 == 0);
	TF2 = 0; 
	if (P00 == 1) {flag = 1;}
	if (P01 == 1) {flag = 0;}
}

void main()
{
	flag = 0;
	brrr = 0x0;

	P1 = 0xFE; 
	RCAP2H = 0x4; 
	RCAP2L = 0x1; 
 
	T2CON &= 0xFC;
	ET2 = 1; 
	EA = 1; 
	T2CON |= 0x4; 

	while(1)
	{
		if (flag == 1) {imp(2415);}
		//else imp(100);
		else imp(1725);
		
		brrr = 0x0;
		rrrb = 0;
		if (P00 == 1) {flag = 1;}
		if (P01 == 1) {flag = 0;}
	}
}

