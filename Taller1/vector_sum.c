//usage, $ ./exec < vector_in > vector_out
#include<stdio.h>
#include<stdlib.h>

int main() {
  float *v1, *v2, * it;
  int n, i;
  while (scanf("%d", &n) == 1) {
    printf("%d\n", n);
    v1 = malloc(sizeof (float) * n);
    v2 = malloc(sizeof (float) * n);
    for (i = 0, it = v1; i < n; i++) {
      scanf("%f,", it);
      it++;
    }
    for (i = 0, it = v2; i < n; i++) {
      scanf("%f,", it);
      it++;
    }
    for ( i = 0; i < n; i++) printf("%f,", v1[i] + v2[i]);
    printf("\n");
  }
  return 0;
}
