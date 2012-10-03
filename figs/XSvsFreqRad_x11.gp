set dgrid3d 100,100
#set pm3d map
set xrange[0.1:6.9]
set yrange[0.1:29.9]
#set term mp color tex  magnification .8
#set output "XSvsFreqRad.mp"
set ylabel "frequency (MHz)"
set xlabel "equilibrium radius, $r_0$ ($\\mu m$)"
set cblabel "$\\sigma/(\\pi r_0^2)$"
set palette gray
set zrange [0:400]
#set logscale cb
splot "/mirror/progs/cpp/icr-10.06/thesis_data/c2/freq_radius/pmc01.dat" u 2:1:4 w l

#w pm3d notitle
#set output
#set term x11