PYTHON=python3
C=gcc
LIBS=-fopenmp
time = time
NUMBERS := $(shell seq 250 250 1000)

all: matrix generator run

matrix: matrix_mul.c
	$(C) matrix_mul_OMP_seq.c -o matrix_mul_seq.out $(LIBS)
	$(C) matrix_mul_OMP.c -o matrix_mul_OMP.out $(LIBS)


generator: gen.py
	$(foreach i, $(NUMBERS), $(PYTHON) gen.py > matrix_in_$(i).csv  $(i);)

run:
	$(foreach i, $(NUMBERS), $(shell ./matrix_mul_seq.out < matrix_in_$(i).csv > matrix_out_seq_$(i).csv))
	
	$(foreach i, $(NUMBERS), $(shell ./matrix_mul_OMP.out < matrix_in_$(i).csv > matrix_out_omp_$(i).csv))