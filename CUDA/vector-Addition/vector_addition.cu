#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// CUDA kernel, each thread takes care of one element of c
__global__ void vec_addition(double *a, double *b, double *c, int n) {
  //get the global thread ID
  int id = blockIdx.x * blockDim.x + threadIdx.x;

  //be sure that id is less than n
  if (id < n)
    c[id] = a[id] + b[id];
}

int main(int argc, char* argv[]) {
  int n = 10, i;

  //host io vectors
  double *h_a;
  double *h_b;
  double *h_c;

  //device io vectors
  double *d_a;
  double *d_b;
  double *d_c;

  size_t bytes = n * sizeof(double);

  //allocating memory for each vector on host
  h_a = (double *)malloc(bytes);
  h_b = (double *)malloc(bytes);
  h_c = (double *)malloc(bytes);

  //allocating memory for each vector on GPU
  cudaMalloc(&d_a, bytes);
  cudaMalloc(&d_b, bytes);
  cudaMalloc(&d_c, bytes);

  for (i = 0; i < n; i++) {
    h_a[i] = i + 1;
    h_b[i] = n - i;
  }

  //copy host vectors to device
  cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice);

  int blockSize, gridSize;

  //number of threads in each thread block
  blockSize = 256;

  //number of thread blocks in grid
  gridSize = (int)ceil((float)n / blockSize);

  //executing the kernel
  vec_addition<<<gridSize, blockSize>>>(d_a, d_b, d_c, n);

  //copy array solution to host
  cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost);

  int sum = 0;
  for (int i = 0, i < n; i++) sum += h_c[i];

  printf("the result is: %d\n", sum);

  //release device memory this is very important
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  //release host memory
  free(h_a);
  free(h_b);
  free(h_c);

  return 0;
}
