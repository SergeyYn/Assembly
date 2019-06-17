#include <stdio.h>
int A[7];
int d;
int main() {
	int i;
	d = 1;
	i = 0;
	while (i <= 6) {
		_asm {
			; 9    : 		A[i] = i | d;

				mov	 eax, i
				or eax, d; d
				mov	 ecx, i
				mov	 A[ecx * 4], eax

				; 10   : 		d += A[i];

				mov	 eax, i
				mov	 ecx, d; d
				add	 ecx, A[eax * 4]
				mov	 d, ecx; d

				; 11   : 		if (d > 10)
				cmp	 d, 10; d, 0000000aH
				jle	 SHORT $LN7main

				; 12   : 			A[i] = 127 - i;

				mov	 eax, 127; 0000007fH
				sub	 eax, i
				mov	 ecx, i
				mov	 A[ecx * 4], eax
				$LN7main :

			; 13   : 		i++;

				mov	 eax, i
				add	 eax, 1
				mov	 i, eax
		}
	}
	for (i = 0; i < 7; i++)
		printf("%d ", A[i]);
	printf("\n");
	return 0;
}
