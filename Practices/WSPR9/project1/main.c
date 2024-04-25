#include <8051.h>

void main()
{
	int i;

	while(1){
		for (i=0; i<64; i++) P2 = 0;
		for (i=0; i<192; i+=3) P2 = 255-i;
		for (i=0; i<64; i++) P2 = 63;
		for (i=0; i<64; i++) P2 = 63+i;
		for (i=0; i<64; i++) P2 = 0;
	}
}