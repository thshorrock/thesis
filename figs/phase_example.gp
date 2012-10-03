set dgrid3d 59,19
set pm3d map
set xrange[0.1:3.5]
set yrange[8.5:12]
set zrange [0:160]
set cbrange [0:160]

set size square 0.9, 1.0

set term mp  color tex  magnification .8
set output "phase_example_a.mp"
set ylabel "frequency (MHz)"
#set y2label "velocity ($ms^{-1}$)"
set xlabel "equilibrium radius, $r_0$ ($\\mu m$)"
set cblabel "$\\sigma / (\\pi r^2)$"
set palette gray
#set logscale cb
#set colorbox vert user origin 0.9,0.1 size 0.04,.8

splot "./phase_example.dat"  u 2:1:3  w pm3d notitle

set output
set term x11

# narrow the plot somewhatet
set size  0.85, 1.0
set lmargin 0
#reset origin
set origin 0.15,0.0
set ylabel "frequency (MHz)"

set term mp  color tex  magnification .8
set output "phase_example_c.mp"
set multiplot

set dgrid3d 59,35
#unset colorbox
#unset xtic
#unset ytic
splot "./phase_example.dat" u 2:1:($3/(pi*$2*$2)) w pm3d notitle
#set pm3d map
unset dgrid3d
unset pm3d
#set origin 0.1, 0.1
set view map
set palette defined (0 "red",  160 "yellow")
splot "./phase_example_b_sort.dat" u 2:4:($5/(pi*$2*$2)) w l lc palette notitle

##now move back and plot just the velocity axis
set origin 0.0,0
 set yrange [-222:296]
 set ytics 100
set ytics nomirror 30
unset xtics
unset xlabel
set ylabel "velocity ($ms^{-1}$)"
set border 2
splot -1 notitle

unset multiplot
set output
set term x11#


unset dgrid3d
set term mp  color tex  magnification .8
set output "phase_example_b.mp"
set view 44,49
set ticslevel 0
set xlabel "radius ($\\mu m$)"
set zlabel "$\\sigma$"
splot "./phase_example_b_sort.dat" u 2:4:5 w l lc palette notitle#

set output
set term x11
