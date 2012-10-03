set isosample 40,40

set nosurface
set cont
set view 0,0
set ticslevel 0
set cntrparam levels discrete 0.01, 0.025, 0.05, 0.1, 0.20


set term table
set output "FreqRatioContours_3.dat"
splot "./FreqRatio3.dat"  w lines
set output
set term x11

set size square;
set size 0.6,0.6;

set term mp tex  magnification .8
set output "FreqRatioContour3.mp"

set xtics ("0" 0 ,  "$\\pi/2$" 1.571, "$\\pi$" 3.142,"$3\\pi/2$" 4.7123, "$2\\pi$" 6.284)
set ytics 10
set ylabel "$\\omega_i/\\omega_d$"
set yrange [0:50]

set label "1\\%" at 2.0,48
set label "2.5\\%" at 2.5, 40
set label "5\\%"  at 2.7, 24.5
set label "10\\%" at 2.55, 11.3
set label "20\\%" at  2.55,5.0

plot "FreqRatioContours_3.dat" using 1:2 with lines notitle

set output
set term x11