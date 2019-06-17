#include <stdio.h>
int A[7];
int d;
int main() {
	int i;
	d = 1;
	i = 0;
	while (i <= 6) {
		A[i] = i | d;
		d += A[i];
		if (d > 10)
			A[i] = 127 - i;
		i++;

	}
	for (i = 0; i < 7; i++)
		printf("%d ", A[i]);
	printf("\n");
	return 0;
}