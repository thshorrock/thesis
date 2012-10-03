
#include <iostream>
#include <cmath>
#include <fstream>
#include <vector>
#include <map> 
#include <algorithm>
 
#ifdef M_PI // defined by all POSIX systems and some non-POSIX ones
double const pi = M_PI;
#else
double const pi = 4*std::atan(1);
#endif
 
double const degree = pi/180;
 
class linear
{
  double m_current;
  double m_intv;
public:
  linear(double min, double max, size_t points) : m_current(min), m_intv((max-min)/(points)) {}
  double operator()(){ double tmp = m_current; m_current+=m_intv; return tmp; }
};

class sinwave
{
  double m_current;
  double m_intv;
public:
  sinwave(double min, double max, size_t points) : m_current(min), m_intv((max-min)/(points)) {}
  double operator()(){double tmp = 0.5*(std::sin(m_current)+1); m_current+=m_intv; return tmp; }
};

class driving_data 
{
  linear m_time;
  sinwave m_pressure;
public:
  driving_data(double min, double max, size_t points) : m_time(min,max,points), m_pressure(min,max,points) {}
  std::pair<double,double> operator()(){std::pair<double,double> tmp; tmp.first = m_time(); tmp.second = m_pressure(); return tmp; }
};

class range
{
  double m_range;
public:
  range(double time) : m_range (time) {}
  range(double ratio, size_t cycles) : m_range(cycles/ratio) {}
  std::pair<double,double> operator()(double t){std::pair<double,double> ret; ret.first = t-m_range/2; ret.second = t+m_range/2; return ret;}
};

class sampled_pressure
{
  std::map<double,double> m_driving_wave;
  range m_get_range;
  size_t m_number_elements;
  std::map<double,double>::iterator lower, upper;
 public:
  sampled_pressure( std::map<double,double> driving_wave, 
		   const double ratio,
		   const double t,
		   const size_t cycles)
    : m_driving_wave(driving_wave), m_get_range(ratio,cycles), m_number_elements(0)
  {
    double min = m_get_range(t).first;
    double max = m_get_range(t).second;
    //std::cout<<"min = "<<min<<" max = "<<max<<std::endl;

    lower = m_driving_wave.lower_bound( min );
    upper =  m_driving_wave.upper_bound( max ) ;
    m_number_elements =distance(lower,upper);
    //std::cout<<"elements = "<<m_number_elements<<std::endl;
    //std::cout<<"begin    = "<<distance(m_driving_wave.begin(), lower)<<std::endl;

  };
  double operator()()
  {
    //std::cout<<"here ()"<<std::endl;

    //std::cout<<"distance left = "<<distance(lower,upper)<<std::endl;
    //std::cout<<lower->first<<"\t"<<lower->second<<std::endl;
   
    double ret = lower->second; 
    if (lower!=upper) ++lower;
    return ret;
  }
  size_t size() {return m_number_elements;};
  
};



  

int main()
{

  size_t points = 100;
  std::ofstream out;
  
  double ratio_max = 60.0;
  double ratio_intv = ratio_max/points;

  double phi_min = 0.0;
  double phi_max = 2*pi;
  double phi_intv = phi_max / points;

  double min_angle = phi_min - pi;
  double max_angle = phi_max+pi;


  size_t sampling_points = 10000;
  //setup driving data
  driving_data get_driving_data(min_angle, max_angle, sampling_points);
  std::map<double,double> driving_wave; //time, pressure
  for(size_t i=0;i<sampling_points;++i)
    driving_wave.insert(get_driving_data());
  
  
  out.open("driving_wave_test.dat");
  std::map<double,double>::iterator itr = driving_wave.begin();
  while(itr!= driving_wave.end()){
    out<<itr->first<<"\t"<<itr->second<<"\n";
    ++itr;
  }
  out.close();
  
  // out.open("sampled_wave_test.dat");
  // sampled_pressure get_sampled_pressure_test(driving_wave, 10, 0.5*pi, 3 );
  // std::vector<double> sampled_test(get_sampled_pressure_test.size());
  // std::generate(sampled_test.begin(), sampled_test.end(), get_sampled_pressure_test);
  // double p_test = *max_element(sampled_test.begin(), sampled_test.end()) - *min_element(sampled_test.begin(), sampled_test.end());
  // std::map<double,double>::iterator sampleditr = driving_wave.begin();
  // while(itr!= driving_wave.end()){
  //   out<<itr->first<<"\t"<<itr->second<<"\n";
  //   ++itr;
  // }
  // out.close();


  double ratio = 0.1;
  double phi = phi_min;
  //  std::cout<<"here"<<std::endl;

  out.open("FreqRatio1.dat");
  
  size_t cycles = 1;
  while(ratio < ratio_max){
    while(phi< phi_max){
      //  std::cout<<"here1"<<std::endl;
      sampled_pressure get_sampled_pressure(driving_wave, ratio, phi, cycles );
      //std::cout<<"here2"<<std::endl;
       std::vector<double> sampled(get_sampled_pressure.size());
      // std::cout<<"here3"<<std::endl;
      std::generate(sampled.begin(), sampled.end(), get_sampled_pressure);
      //std::cout<<"here4"<<std::endl;
      double p;
      if (sampled.size()>0)
	p = *max_element(sampled.begin(), sampled.end()) - *min_element(sampled.begin(), sampled.end());
      else {
	p =0;
      }

      //std::cout<<phi<<"\t"<<ratio<<"\t"<<p<<std::endl;
      out<<phi<<" \t "<<ratio<<" \t "<<p<<"\n";
      phi+=phi_intv;
    }
    //std::cout<<"END LOOP 1"<<std::endl;
  out<<"\n";
    phi = phi_min;
    ratio+=ratio_intv;
  }
  out<<"\n"; 
  out.close();
  
  out.open("FreqRatio3.dat");
  
  cycles = 3;
  while(ratio < ratio_max){
    while(phi<2*pi){
      sampled_pressure get_sampled_pressure(driving_wave, ratio, phi, cycles );
      std::vector<double> sampled(get_sampled_pressure.size());
      std::generate(sampled.begin(), sampled.end(), get_sampled_pressure);
      double p = *max_element(sampled.begin(), sampled.end()) - *min_element(sampled.begin(), sampled.end());
      
      out<<phi<<"\t"<<ratio<<"\t"<<p<<"\n";
      phi+=phi_intv;
    }
    phi = 0.0;
    ratio+=ratio_intv;
  }
  out<<"\n"; 
  out.close();

  out.open("FreqRatioMaxError.dat");
  //out<<"#File generated by FreqRation.cpp\n #p, omega_i/omega_d";
  while(ratio < ratio_max){
      sampled_pressure get_sampled_pressure1(driving_wave, ratio, 0, 1 );
      sampled_pressure get_sampled_pressure2(driving_wave, ratio, 0, 2 );
      sampled_pressure get_sampled_pressure3(driving_wave, ratio, 0, 3 );
      sampled_pressure get_sampled_pressure4(driving_wave, ratio, 0, 4 );

      std::vector<double> sampled1(get_sampled_pressure1.size());
      std::vector<double> sampled2(get_sampled_pressure2.size());
      std::vector<double> sampled3(get_sampled_pressure3.size());
      std::vector<double> sampled4(get_sampled_pressure4.size());

      std::generate(sampled1.begin(), sampled1.end(), get_sampled_pressure1);
      std::generate(sampled2.begin(), sampled2.end(), get_sampled_pressure2);
      std::generate(sampled3.begin(), sampled3.end(), get_sampled_pressure3);
      std::generate(sampled4.begin(), sampled4.end(), get_sampled_pressure4);
 
      double p1 = *max_element(sampled1.begin(), sampled1.end()) - *min_element(sampled1.begin(), sampled1.end());
      double p2 = *max_element(sampled2.begin(), sampled2.end()) - *min_element(sampled2.begin(), sampled2.end());
      double p3 = *max_element(sampled3.begin(), sampled3.end()) - *min_element(sampled3.begin(), sampled3.end());
      double p4 = *max_element(sampled4.begin(), sampled4.end()) - *min_element(sampled4.begin(), sampled4.end());
      
      out<<ratio<<"\t"<<p1<<"\t"<<p2<<"\t"<<p3<<"\t"<<p4<<"\n";
      ratio+=ratio_intv;
  }

  
  
  out.close();
  return 0;
}
