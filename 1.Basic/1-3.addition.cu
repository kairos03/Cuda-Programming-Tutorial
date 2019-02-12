#include <stdio.h>

__global__ void add(int *a, int *b, int *c){
	*c = *a + *b;
}

int main(void) {
	int a, b, c;		// host copies of a, b, c
	int *d_a, *d_b, *d_c;	// device copies of a, b, c
	int size = sizeof(int);
	
	// device space allocation
	cudaMalloc((void **) &d_a, size);
	cudaMalloc((void **) &d_b, size);
	cudaMalloc((void **) &d_c, size);

	// set up inputs
	a = 2;
	b = 7;
	
	// copy inputs
	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

	// excute add
	add<<<1,1>>>(d_a, d_b, d_c);

	// copy result
	cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

	// print result
	printf("%d\n", c);

	// Cleanup
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	return 0;
}
