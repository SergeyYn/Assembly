#include <stdio.h>
#include <iostream>
const short len = 255;
typedef unsigned char byte;
extern "C" {
	void Big3sSub(byte* M1, byte* M2, byte* M3, byte* Carry, short len);
	void BigShowN(byte* p1, short p2);
}
int main(){
	byte M1[len],M2[len],M3[len];
	byte* Carry = 0;
	for (int i = 0; i < len; i++)
	{
		M1[i] = 0;
		M2[i] = 2*i;
		M3[i] = i;
	}
	BigShowN(M1, len);
	Big3sSub(M1, M2, M3, Carry, len);

	return 0;
}