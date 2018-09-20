#include <iostream>
#include <vector>
#include <fstream>
#include <omp.h>
#include "timer.hh"

using namespace std;

void jacobi(int nsweeps, int n, vector<double> &u, vector<double> &f) {
  double h = 1.0 / n;
  double h2 = h * h;
  vector<double> utmp(n + 1);
  utmp[0] = u[0];
  utmp[n] = u[n];

  for ( int sweep = 0; sweep < nsweeps; sweep += 2 ) {
    #pragma omp parallel for schedule(dynamic)
    for ( int i = 1; i < n; ++i )
      utmp[i] = (u[i - 1] + u[i + 1] + h2 * f[i]) / 2;
    
    #pragma omp parallel for schedule(dynamic)
    for ( int i = 1; i < n; ++i )
      u[i] = (utmp[i - 1] + utmp[i + 1] + h2 * f[i]) / 2;
  }
}

void write_solution(int n, vector<double> &u, const char* fname) {
  double h = 1.0 / n;
  ofstream output;

  output.open (fname);
  for ( int i = 0; i <= n; ++i )
    output << i * h << " " << u[i] << endl;
  output.close();
}

int main (int argc, char** argv) {
  int n = (argc > 1) ? atoi(argv[1]) : 100;
  int nsteps = (argc > 2) ? atoi(argv[2]) : 100;
  char* fname = (argc > 3) ? argv[3] : NULL;
  double h = 1.0 / n;

  vector<double> u(n + 1), f(n + 1);

  #pragma omp parallel for shared(f, h) schedule(dynamic)
  for ( int i = 0; i <= n; ++i )
    f[i] = i * h;
  
  {
    Timer tmt("\"Elapsed time:\"");
    jacobi(nsteps, n, u, f);
    cout << "{" << endl;
    cout << "\"N\": " << n << "," << endl;
    cout << "\"Steps\": " << nsteps << "," << endl;
  }
  cout << "}," << endl;

  if ( fname ) write_solution(n, u, fname);

  return 0;
}
