#include <iostream>
#include <thread>
#include <vector>
#include <mutex>
#include <random>
using namespace std;

typedef vector<vector<double>> Matrix;

void multiply_row(int i, int sz, Matrix &A, Matrix &B, Matrix &C, mutex &mt) {
  for (int j = 0; j < sz; j++) {
    for (int k = 0; k < sz; k++) {
      mt.lock();
      C[i][j] += A[i][k] * B[k][j];
      mt.unlock();
    }
  }
}

void print_matrix(string name, Matrix &A) {
  cout << "Matrix " << name << endl;
  for (auto i : A) {
    for (auto j: i) cout << j << " ";
    cout << endl;
  }
  cout << endl;
}

int main(int argc, char ** argv) {
  if (argc != 2) {
    cout << "Use: executable matrix_size" << endl;
    return 0;
  }
  random_device rd;
  mt19937 gen(rd());
  uniform_real_distribution<> real_dist(1.0, 2.0);
  int n = atoi(argv[1]);
  Matrix A(n, vector<double>(n, 0));
  Matrix B(n, vector<double>(n, 0));
  Matrix C(n, vector<double>(n, 0));

  mutex write_cell;

  for (auto &i : A) for (auto &j : i) j = real_dist(gen);
  for (auto &i : B) for (auto &j : i) j = real_dist(gen);
  
  cout << "Matrix size " << n << endl;
  print_matrix("A", A);
  print_matrix("B", B);

  vector<thread> threads;
  
  for (int i = 0; i < n; i++) {
    threads.emplace_back(thread(&multiply_row, i, n, ref(A), ref(B), ref(C), ref(write_cell)));
  }

  for (auto &thread : threads) thread.join();
  print_matrix("Resulting Matrix", C);
  
  return 0;
}