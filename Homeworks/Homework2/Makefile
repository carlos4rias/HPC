PYTHON=python3
C=gcc
LIBS=-fopenmp
time = time

all: matrix generator run

matrix: matrix_mul.c
	$(C) matrix_mul.c -o matrix_mul.out $(LIBS)
	$(C) matrix_mul_OMP.c -o matrix_mul_OMP.out $(LIBS)

generator: gen.py
	$(PYTHON) gen.py > matrix_in.csv

run:
	./matrix_mul.out < matrix_in.csv > matrix_out.csv
	./matrix_mul_OMP.out < matrix_in.csv > matrix_out_OMP.csv
