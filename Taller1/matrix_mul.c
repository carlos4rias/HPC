#include<stdio.h>
#include<stdlib.h>

void print_matrix(float *mat, int rows, int cols) {
  int i, j;
  printf("%d, %d\n", rows, cols);
  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++)
      printf("%f, ", mat[i * cols + j]);
    printf("\n");
  }
}

void multiply_matrix(float *mat1, int r1, int c1, float *mat2, int r2, int c2, float * res) {
  int pos_matrix1, pos_matrix2;
  float acc;
  int i, j, k;
  for (i = 0; i < r1; i++) {
    for (j = 0; j < c2; j++) {
      acc = 0;
      for (k = 0; k < c1; k++) {
        pos_matrix1 = i * c1 + k;
        pos_matrix2 = c2 * k + j;
        acc += mat1[pos_matrix1] * mat2[pos_matrix2];
      }
      res[i * c2 + j] = acc;
    }
  }
}

int main() {
  float *mat1, *mat2, *it, *res;
  int sr1, sr2, sc1, sc2, i, j;
  while (scanf("%d, %d", &sr1, &sc1) == 2) {

    mat1 = malloc(sizeof (float) * sr1 * sc1);
    for (i = 0, it = mat1; i < sr1 * sc1; i++) scanf("%f,", it++);


    scanf("%d, %d", &sr2, &sc2);
    mat2 = malloc(sizeof (float) * sr2 * sc2);
    for (i = 0, it = mat2; i < sr2 * sc2; i++) scanf("%f,", it++);
    if (sc1 != sr2) {
      printf("invalid matrices\n");
      break;
    }
    res = malloc(sizeof (float) * sr1 * sc2);

    multiply_matrix(mat1, sr1, sc1, mat2, sr2, sc2, res);
    print_matrix(res, sr1, sc2);
    // printf("\n");
    // print_matrix(mat1, sr1, sc1);
  }
  return 0;
}
