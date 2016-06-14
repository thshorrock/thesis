set  xlabel "time ($\\mu s$)"
set xrange[0: 11]

set ylabel "radius ($\\mu m$)"

set size square
set size 0.7

set term mp color solid tex  magnification .8
set output "bubble_ch4_rad.mp"
#set yrange[1.2:3.4]
plot "filtered_0_125_RKM_radius.dat" w line notitle



set term mp color solid  tex  magnification .8
set output "bubble_ch4_ipressure.mp"
set ylabel "incident pressure (MPa)"
#set yrange[0:15]
plot "filtered_0_125_RKM_incident_pressure.dat" w line notitle
     
set term mp color  solid tex  magnification .8
set output "bubble_ch4_out_pressure.mp"
set ylabel "generated pressure (MPa)"
#set yrange[0:22]
plot "non_filtered_0_125_RKM_pressure_generated_without_nearfield.dat" w line notitle 

set term mp color  solid tex  magnification .8
set output "bubble_ch4_out_filtered_pressure.mp"
set ylabel "generated pressure (filtered) (MPa)"
#set yrange[0:22]
plot "filtered_0_125_RKM_pressure_generated_without_nearfield.dat"  w line notitle 

set xrange[*:*]
set yrange[*:*]


set term mp color  solid tex  magnification .8
set output "bubble_ch4_small_phasor.mp"
set xlabel "radius ($\\mu m$)"
set ylabel "wall speed ($ms^{-1}$)"
plot "< paste  between_0_01_RKM_radius.dat ./between_0_01_RKM_velocity.dat"   using 2:4  w l notitle 
 
set term mp color  solid tex  magnification .8
set output "bubble_ch4_large_phasor.mp"
set xlabel "radius ($\\mu m$)"
set ylabel "wall speed ($ms^{-1}$)"
plot "< paste  between_0_125_RKM_radius.dat ./between_0_125_RKM_velocity.dat" using 2:4  w l notitle 


set term mp color  solid tex  magnification .8
set output "bubble_ch4_small_phase.mp"
set xlabel "time ($\\mu s$) "
 set xrange[4.8:5.4]
set ytics ("0" 0, "-$\\pi\\over 2$" -pi/2, "$-\\pi$" -pi, "-$3\\pi\\over 2$" -3 * pi/2, "$-2\\pi$" -2*pi)

set ylabel "phase" 11.0,0.0 
plot "between_0_01_RKM_phases.dat" w l notitle 
 
set term mp color  solid tex  magnification .8
set output "bubble_ch4_large_phase.mp"
set xlabel "time ($\\mu s$)"
set ytics ("0" 0, "$-\\pi$" -pi, "$-2\\pi$" -2*pi, "$-3\\pi$" -3 * pi, "-4$\\pi$" -4*pi)
set ylabel "phase" 4.0,0.0 
plot "./between_0_125_RKM_phases.dat"  w l notitle 
 

 set xrange[*:*]
set ytics auto;

set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i0_1.mp"
set xlabel "radius ($\\mu m$)"
set ylabel "wall speed ($ms^{-1}$)" 0.0,0.0 
plot "< paste  between_0_125_RKM_radius.dat ./between_0_125_RKM_velocity.dat" using 2:4  w l t "without imaging wave" , \
     "< paste  between_0_125_i0_1_RKM_radius.dat ./between_0_125_i0_1_RKM_velocity.dat" using 2:4  w l  t "with imaging wave"


 
set ytics auto;
set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i0_1_phase.mp"
 set xrange[4.8:5.4]
set xlabel "time ($\\mu s$)"
set ytics ("0" 0, "$-\\pi$" -pi, "$-2\\pi$" -2*pi, "$-3\\pi$" -3 * pi, "-4$\\pi$" -4*pi)
set ylabel "phase" 4.0,0.0 
plot "./between_0_125_RKM_phases.dat"  w l t "without imaging wave" , \
     "./between_0_125_i0_1_short_RKM_phases.dat" w l  t "with imaging wave"
 
 set xrange[*:*]
set ytics auto;

set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i0_5.mp"
set xlabel "radius ($\\mu m$)"
set ylabel "wall speed ($ms^{-1}$)" 0.0,0.0 
plot "< paste  between_0_125_RKM_radius.dat ./between_0_125_RKM_velocity.dat" using 2:4  w l t "without imaging wave" , \
     "< paste  between_0_125_i0_5_RKM_radius.dat ./between_0_125_i0_5_RKM_velocity.dat" using 2:4  w l  t "with imaging wave"


 set xrange[4.8:5.4]
set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i0_5_phase.mp"
set xlabel "time ($\\mu s$)"
set ylabel "phase" 4.0,0.0 
set ytics ("0" 0, "$-\\pi$" -pi, "$-2\\pi$" -2*pi, "$-3\\pi$" -3 * pi, "-4$\\pi$" -4*pi)
plot "./between_0_125_RKM_phases.dat"  w l t "without imaging wave" , \
     "./between_0_125_i0_5_short_RKM_phases.dat" w l  t "with imaging wave"
 
 
 set xrange[*:*]
set ytics auto;


set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i1_0.mp"
set xlabel "radius ($\\mu m$)"
set ylabel "wall speed ($ms^{-1}$)" 0.0,0.0 
plot "< paste  between_0_125_RKM_radius.dat ./between_0_125_RKM_velocity.dat" using 2:4  w l t "without imaging wave" , \
     "< paste  between_0_125_i1_0_RKM_radius.dat ./between_0_125_i1_0_RKM_velocity.dat" using 2:4  w l t "with imaging wave"

     
set xrange[4.8:5.4]
set term mp color  solid tex  magnification .8
set output "bubble_ch4_between_0_125_i1_0_phase.mp"
set xlabel "time ($\\mu s$)"
set ylabel "phase" 4.0,0.0 
set ytics ("0" 0, "$-\\pi$" -pi, "$-2\\pi$" -2*pi, "$-3\\pi$" -3 * pi, "$-4\\pi$" -4*pi)
plot "./between_0_125_RKM_phases.dat"  w l t  "without imaging wave" , \
     "./between_0_125_i1_0_short_RKM_phases.dat" w l  t "with imaging wave"
 

set term x11
set output



     
#plot "bubble_0.5_KM_velocity.dat" w line title "optically measure", \
#     "bubble_0.5_RKM_velocity.dat" w line title "acoustically measured"

 #    plot "< paste bubble_0.5_KM_radius.dat bubble_0.5_KM_velocity.dat" using 2:4  w l, \
 #    "< paste bubble_0.5_RKM_radius.dat bubble_0.5_RKM_velocity.dat" using 2:4  w l