// Libraries to control equipment 
#include "analogic.hpp"   
#include "agilent.hpp"    
#include "lecroy.hpp"     
#include "DPR500.hpp"     

using namespace ICR::agilent; using namespace ICR::analogic;
using namespace ICR::lecroy; using namespace ICR::pulser;

int
main  (int ac, char **av)
{

  //Connect to equipment (via serial and ethernet)
  analogic_remote_control analogic("/dev/ttyUSB0");  
  WG33220A<agilent::IP>  driving_pulse("10.0.0.20"); 
  lecroy_64Xi  scope("10.0.0.10");  
  //DPR500 supports different pulser-receivers, use the RPL2 here.
  DPR500                 pulser("/dev/ttyUSB1");
  PulserReceiverFactory  factory;   
  RPL2* imaging_pulse = factory.make_RPL2();      
  pulser.attach_A(imaging_pulse);                 
  pulser.turn_on_A();   

  //delay for driving wave to be coincident with imaging wave
  const double analogic_delay = 28;   // in microseconds
  const size_t repeats = 50;          // of each experiment
  
  //setup the driving voltages to test (volts)
  std::vector<double> driving_voltages;     
  driving_voltages.push_back(80e-3);
  driving_voltages.push_back(100e-3);

  //setup the delays to test (microseconds)
  std::vector<double> agilent_delays;
  agilent_delays.push_back(1000);
  agilent_delays.push_back(500);
    
  //for each of the different driving pressures
  for(size_t dv=0;dv<driving_voltages.size();++dv)
    {
      const double const_driving_voltage = driving_voltages[dv];
      //for each of the different delays
      for(size_t ad=0;ad<agilent_delays.size();++ad){  
	const double agilent_delay = agilent_delays[ad];

	//first experiment
	// Compare the pulses when the imaging wave in turned off.
	no_imaging_compare no_imag(dir.get_directory(), const_driving_voltage, "no_imaging");
	no_imag.setup_analogic(analogic, analogic_delay, agilent_delay);
	no_imag.setup_pulser(pulser, imaging_pulse);
	no_imag.run(driving_pulse,scope,repeats);

	//Second experiment
	//  Imaging wave coencides with the first of the driving pulses
	imaging_on<0> imag0(dir.get_directory(), const_driving_voltage, "imaging_1st");
	imag0.setup_analogic(analogic, analogic_delay, agilent_delay);
	imag0.setup_pulser(pulser, imaging_pulse);
	imag0.run(driving_pulse,scope,repeats);

	//Third experiment
	//  Imaging wave coencides with the second of the driving pulses.
	imaging_on<1> imag1(dir.get_directory(), const_driving_voltage, "imaging_2nd");
	imag1.setup_analogic(analogic, analogic_delay, agilent_delay);
	imag1.setup_pulser(pulser, imaging_pulse);
	imag1.run(driving_pulse,scope,repeats);
      }
    }
    
  analogic.turn_off();
  pulser.turn_off_A();
  driving_pulse.turn_off();
}
