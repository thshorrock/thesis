set size 0.8, 0.8
omega =1
#vmax  = 0.5
w(t) = omega * t
doppler(t, vmax) = sqrt( (1 + vmax*sin(w(t))  )/(1 - vmax*sin(w(t)) ) )
set xrange [0:2*pi]
set ylabel "{/Symbol w}_b/{/Symbol w}_i"
set xlabel "{/Symbol f} (radians)"

plot doppler(x, 0.1) t "Mach 0.10", doppler(x,0.25) t "Mach 0.25", doppler(x,0.5) t "Mach 0.50", doppler(x,0.75) t "Mach 0.75", doppler(x,0.9) t "Mach 0.90"

set output "doppler_bw.eps"
set term postscript eps enhanced mono 
replot

set output "doppler_colour.eps"
set term postscript eps enhanced color solid
replot

set output
set term x11
replot

