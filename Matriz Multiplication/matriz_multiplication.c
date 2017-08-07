#include<stdio.h>
#include<stdlib.h>

#define line_buffer 2048


void* init_matriz (int rows, int cols) {
  return malloc (sizeof (int[rows][cols]));
}

void* read_matriz (FILE *fr, int *n_row, int *n_col) {
  fscanf(fr, "%d", n_row);
  fscanf(fr, "%d", n_col);
  int rows = *n_row;
  int cols = *n_col;
  int (*matriz)[cols] = init_matriz(rows, cols);
  int cv = 0, i, j = 0;
  
  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++) {
      fscanf(fr, "%d,", &cv);
      matriz[i][j] = cv;
    }
  }

  return matriz;
}

void* multiply_matrices(int ra, int ca, int rb, int cb, int A[][ca], int B[][cb]) {
  int (*result)[cb] = init_matriz(ra, cb);
  int i, j, k, cell_result;
  
  for (i = 0; i < ra; i++) {
    for (k = 0; k < cb; k++) {
      cell_result = 0;
      for (j = 0; j < ca; j++) {
        cell_result += A[i][j] * B[j][k];
      }
      result[i][k] = cell_result;
    }
  }
  return result;
}

void write_result(int rows, int cols, int matriz[][cols]) {
  FILE *fw = fopen("resulting_matrix", "w");
  int i, j;
  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++) 
      fprintf(fw, "%d ", matriz[i][j]);
    fprintf(fw, "\n");
  }
  fclose(fw);
}

void print_matriz(int rows, int cols, int matriz[][cols]) {
  int i, j;
  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++) printf("%d ", matriz[i][j]);
    printf("\n");
  }
}


int main () {
  int rows_a, rows_b, cols_a, cols_b, i, j;
  FILE *fr;
  
  // reading the first file
  fr = fopen("ma", "r");
  int (*matriz_A)[] = read_matriz(fr, &rows_a, &cols_a);
  //print_matriz(rows_a, cols_a, matriz_A);
  fclose(fr);
  
  // reading the second file
  fr = fopen("mb", "rb");
  int (*matriz_B)[] = read_matriz(fr, &rows_b, &cols_b);
  //print_matriz(rows_b, cols_b, matriz_B);
  fclose(fr);
  
  //multiplying the matrices
  int (*result)[] = multiply_matrices(rows_a, cols_a, rows_b, cols_b, matriz_A, matriz_B);
  write_result(rows_a, cols_b, result);
  return 0;
}
