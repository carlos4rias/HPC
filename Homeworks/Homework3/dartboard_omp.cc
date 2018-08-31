#include <iostream>
#include <random>
#include <cmath>
#include <omp.h>

using namespace std;

int main(int argc, char ** argvs) {
  random_device rd;
  mt19937 gen(rd());
  uniform_real_distribution<double> real_dist(0.0, 1.0);
  if (argc != 2) {
    cout << "Use: executable #of_experiments" << endl;
    return 0;
  }

  int tries = atoi(argvs[1]), success = 0;
  int i = 0;
  double start_t = omp_get_wtime();
  #pragma omp parallel for private(i) schedule(dynamic) reduction(+: success)
  for ( i = 0; i < tries; i++ ) {
    double x = real_dist(gen);
    double y = real_dist(gen);
    success += x * x + y * y < 1.0 ? 1 : 0;
  }
  double end_t = omp_get_wtime();
  cout << "{\n" << "\"data\": " << tries << ",\n";
  cout << "\"time\": " << end_t - start_t << ",\n";
  cout << "\"approximation\" :" << (4.0 * success) / tries << "\n},\n";

  return 0;
}