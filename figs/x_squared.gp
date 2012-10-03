

set parametric
set samples 10000
#plot the first graph
#plot t, t**2
delta = 0.5
omega = 1

normal(t) = sqrt(1 + 4 * t**2 )
#normal_two(t) = t* (1 + 2* t**2) #(1 + 4*t - 4 * t**2 )
#argument1(t) = t* (1 + 2* t**2) #  t* (1 + 6 * t**2) /normal_two(t)  #(1 + 4 * t**2)#/normal_two(t)
#argument2(t) = t**2 # t**2
#w1(t) = 2* pi*omega * argument1(t) #*(1 + 4* t**2)
#w2(t) = 2* pi*omega * argument2(t)
Deltat(t) = 0.25 *( log(2*t+normal(t))  + 2*t*normal(t))
w(t) =  2* pi*omega * Deltat(t)
e1(t,delta) = t-2*t*delta*sin(w(t))/normal(t)  #* (1+ 2* t**2)
e2(t,delta) = (t**2+delta*sin(w(t))/normal(t) )

no_pi_x = 1.5
no_pi_y = 3
set border 0

set key outside top
set format x ""
set format y ""
unset tics
set xrange [-no_pi_x*pi:no_pi_x*pi]
set yrange  [-1:(2*no_pi_y*pi-1)]



plot t, 0 title "C", t, t**2 title "C'", e1(t,0.2), e2(t,0.2) title "C''"

set size square 0.5

set output "x_squared_bw.eps"
set term postscript eps enhanced mono 
replot

set output "x_squared_colour.eps"
set term postscript eps enhanced color solid
replot

set output
set term x11
replot

