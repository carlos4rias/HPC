PYTHON=python3
C=g++
LIBS=-fopenmp -pthread
time = time
NUMBERS := 100 1000 10000 100000

all: matrix run

matrix:
	$(C) jacobi_seq.cc -o jacobi_seq.out $(LIBS)
	$(C) jacobi_threads.cc -o jacobi_threads.out $(LIBS)
	$(C) jacobi_parallel.cc -o jacobi_parallel.out $(LIBS)

run:
	$(shell rm jacobi_seq.json)
	$(shell rm jacobi_threads.json)
	$(shell rm jacobi_parallel.json)

	$(shell echo "[" >> jacobi_seq.json)
	$(foreach i, $(NUMBERS), \
		$(foreach j, $(NUMBERS), \
			$(shell ./jacobi_seq.out $(i) $(j) >> jacobi_seq.json) \
		) \
	)
	$(shell echo "]" >> jacobi_seq.json)

	$(shell echo "[" >> jacobi_threads.json)
	$(foreach i, $(NUMBERS), \
		$(foreach j, $(NUMBERS), \
			$(shell ./jacobi_threads.out $(i) $(j) >> jacobi_threads.json) \
		) \
	)
	$(shell echo "]" >> jacobi_threads.json)

	$(shell echo "[" >> jacobi_parallel.json)
	$(foreach i, $(NUMBERS), \
		$(foreach j, $(NUMBERS), \
			$(shell ./jacobi_parallel.out $(i) $(j) >> jacobi_parallel.json) \
		) \
	)
	$(shell echo "]" >> jacobi_parallel.json)
