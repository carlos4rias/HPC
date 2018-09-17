#include <iostream>
#include <vector>
#include <fstream>
#include <thread>

#include "timer.hh"

using namespace std;

void adjust(vector<double> & u, vector<double> & utmp, vector<double> &f,const int & n, const double & h2) {
  for ( int i = 1; i < n; ++i )
      utmp[i] = (u[i - 1] + u[i + 1] + h2 * f[i]) / 2;
  for ( int i = 1; i < n; ++i )
    u[i] = (utmp[i - 1] + utmp[i + 1] + h2 * f[i]) / 2;
}

void jacobi(int nsweeps, int n, vector<double> &u, vector<double> &f) {
  double h = 1.0 / n;
  double h2 = h * h;
  vector<double> utmp(n + 1);
  utmp[0] = u[0];
  utmp[n] = u[n];

  vector<thread> threads(nsweeps >> 1);

  for ( int sweep = 0; sweep < nsweeps; sweep += 2 ) {
    threads[sweep >> 1] = thread(&adjust, ref(u), ref(utmp), ref(f), ref(n), ref(h2));
  }

  for ( auto &thread : threads ) thread.join();
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
