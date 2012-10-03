
#include <iostream>
#include <cmath>
#include <fstream>
 
#ifdef M_PI // defined by all POSIX systems and some non-POSIX ones
double const pi = M_PI;
#else
double const pi = 4*std::atan(1);
#endif
 
double const degree = pi/180;
 
int main()
{
  size_t points = 300;
  double p_intv = 1.0/points;
  double p = 0.0;
  double t = 0.0;
  double t_intv = 2*pi/points;
  std::ofstream out_1, out_3;
  std::ofstream out2;
  //std::cout<<"p = "<<p<<"p intv  = "<<p_intv<<std::endl;

  out_1.open("FreqRatio1.dat");
  out_3.open("FreqRatio3.dat");
  
  out2.open("FreqRatioMaxError.dat");
  //out<<"#File generated by FreqRation.cpp\n #p, omega_i/omega_d";
  
  double omega_d = 1.0;
  double t_i = 0.0;
  double t_i_intv = pi/points;
  double ratio = 0.1;
  double ratio_max = 60.0;
  double ratio_intv = ratio_max/points;
  
  while(ratio < ratio_max){
    while(t<2*pi){
      
	out_1<<t<<"\t"<<ratio<<"\t"<<
	  std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(1.0/(2*ratio)),2))
	   <<"\n";
      
	out_3<<t<<"\t"<<ratio<<"\t"<<
	  std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(3.0/(2*ratio)),2))
	   <<"\n";
      t+=t_intv;
    }
    t = 0.0;
    ratio+=ratio_intv;
    if (ratio>1.0) {
      out2<<ratio<<"\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(1.0/(2*ratio)),2))
	  << "\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(2.0/(2*ratio)),2))
	  << "\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(3.0/(2*ratio)),2))
	  << "\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(4.0/(2*ratio)),2))
	  << "\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(5.0/(2*ratio)),2))
	  << "\t"<<
	std::sqrt(std::pow(std::cos(omega_d*t)*std::sin(10.0/(2*ratio)),2))
	  <<"\n";
      
      
    }
      out_3<<"\n"; 
      out_1<<"\n"; 
  }
  
  out_1.close();
  out_3.close();
  out2.close();
  return 0;
}
