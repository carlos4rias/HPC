import numpy
import sys

n = int(sys.argv[1])
# print (sys.argv)

def print_matrix(mat):
    for i in mat:
        for j in i:
            print(j, end=', ')
        print('\n')


rows, cols = (n, n)
mat1 = numpy.random.random((rows, cols))
mat2 = numpy.random.random((rows, cols))
print (str(rows) + ', ' + str(cols))
print_matrix (mat1)
print (str(rows) + ', ' + str(cols))
print_matrix (mat2)
# print (mat2)
# numpy.savetxt("in.csv", , delimiter=",")
