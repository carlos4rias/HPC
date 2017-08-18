CC=g++ -std=c++11
C=gcc
LIBS=-fopenmp

all: matrix generator run

matrix: matrix_multiplication.c
	$(C) matrix_multiplication.c -o matrix.out $(LIBS)

generator: gen.cc
	$(CC) gen.cc -o generator.out -Wall

run:
	./generator.out > ma.in
	./generator.out > mb.in
	time ./matrix.out > matrix_output.out
