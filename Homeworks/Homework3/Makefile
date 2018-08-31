PYTHON=python3
C=g++
LIBS=-fopenmp
time = time
NUMBERS := $(shell seq 1000000 1000000 20000000)

all: matrix run

matrix:
	$(C) dartboard_seq.cc -o dartboard_seq.out $(LIBS)
	$(C) dartboard_omp.cc -o dartboard_omp.out $(LIBS)

run:
	$(shell rm dartboard_seq.json)
	$(shell rm dartboard_omp.json)
	$(shell echo "[" >> dartboard_seq.json)
	$(shell echo "[" >> dartboard_omp.json)
	$(foreach i, $(NUMBERS), $(shell ./dartboard_seq.out $(i) >> dartboard_seq.json))
	$(foreach i, $(NUMBERS), $(shell ./dartboard_omp.out $(i) >> dartboard_omp.json))
	$(shell echo "]" >> dartboard_seq.json)
	$(shell echo "]" >> dartboard_omp.json)