import numpy

def print_matrix(mat):
    for i in mat:
        for j in i:
            print(j, end=', ')
        print('\n')


rows, cols = (1500, 1500)
mat1 = numpy.random.random((rows, cols))
mat2 = numpy.random.random((rows, cols))
print (str(rows) + ', ' + str(cols))
print_matrix (mat1)
print (str(rows) + ', ' + str(cols))
print_matrix (mat2)
# print (mat2)
# numpy.savetxt("in.csv", , delimiter=",")
