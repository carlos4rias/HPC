EXECS=matrix_mul_MPI
MPICC?=mpicc

all: ${EXECS}

matrix_mul_MPI: matrix_mul_MPI.c
	${MPICC} -o matrix_mul_MPI matrix_mul_MPI.c
	mpirun --machinefile host_file ./matrix_mul_MPI

clean:
	rm ${EXECS}