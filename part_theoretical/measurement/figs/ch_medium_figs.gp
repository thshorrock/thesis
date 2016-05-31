#set xlabel "time ($\\mu s$)"

set yrange[-0.011: 0.011]
set xrange[0:pi]
unset xtics
unset ytics

set xlabel 'distance'
set ylabel 'particle speed'

#set ylabel "radius ($\\mu m$)"

set size square
set size 0.7

set term mp color solid tex  magnification .8
set output "ch_medium_nonlinear_pulse.mp"
set trange[0*pi:1 * pi]
y(t) = 0.01 * sin(2*t)
x1(t) = t + y(t) * 1.2 * t
x2(t) = x1(t + 5*pi) - 5 * pi

set parametric
#plot t, y(t)  w line t 'pulse', x2(t),y(t) w line t 'echo'
plot t, y(t)  w line t 'pulse'


set term mp color solid tex  magnification .8
set output "ch_medium_nonlinear_echo.mp"
plot  x2(t),y(t) w line t 'echo'