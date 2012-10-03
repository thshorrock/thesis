set isosample 40,40

set nosurface
set cont
set view 0,0
set ticslevel 0
set cntrparam levels discrete 0.01, 0.025, 0.05, 0.1, 0.20

set term table
set output "FreqRatioContours.dat"
splot "./FreqRatio.dat"  w lines
set output
set term x11


set size 0.6,0.6;

set term mp tex  magnification .8
set output "FreqRatioContour.mp"

set xtics ("0" 0 ,  "$\\pi/2$" 1.571, "$\\pi$" 3.142,"$3\\pi/2$" 4.7123, "$2\\pi$" 6.284)
set ytics 10
set ylabel "$\\omega_i/\\omega_d$"

set label "1\\%" at 2.97,46.6
set label "2.5\\%" at 2.85, 18.0
set label "5\\%"  at 2.97, 8.46
set label "10\\%" at 2.9, 3.4
set label "20\\%" at 2.9,1.0

plot "FreqRatioContours.dat" using 1:2 with lines notitle

set output
set term x11