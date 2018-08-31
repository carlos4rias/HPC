PYTHON=python3
C=g++
LIBS=-fopenmp
time = time
NUMBERS := $(shell seq 1000000 1000000 20000000)

all: matrix run

matrix:
	$(C) montecarlo_seq.cc -o montecarlo_seq.out $(LIBS)
	$(C) montecarlo_omp.cc -o montecarlo_omp.out $(LIBS)

run:
	$(shell rm montecarlo_seq.json)
	$(shell rm montecarlo_omp.json)
	$(shell echo "[" >> montecarlo_seq.json)
	$(shell echo "[" >> montecarlo_omp.json)
	$(foreach i, $(NUMBERS), $(shell ./montecarlo_seq.out $(i) >> montecarlo_seq.json))
	$(foreach i, $(NUMBERS), $(shell ./montecarlo_omp.out $(i) >> montecarlo_omp.json))
	$(shell echo "]" >> montecarlo_seq.json)
	$(shell echo "]" >> montecarlo_omp.json)