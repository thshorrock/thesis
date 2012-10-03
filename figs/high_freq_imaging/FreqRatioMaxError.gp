
set xtics 10
set yrange [0:50]


set size square
set size 0.75,0.75


set term mp color solid tex  magnification .8
set output "FreqRatioContourMaxError.mp"

set logscale

set ylabel "$\\omega_i/\\omega_d$" 2.5, 0.0
set xlabel "Range (\\%)"

set key below
set xrange [1:100]
set yrange [0.1:50]


plot "./FreqRatioMaxError.dat" u ($2*100):1 w line t "1 cycle", \
     "./FreqRatioMaxError.dat" u ($3*100):1 w line t "2 cycles", \
     "./FreqRatioMaxError.dat" u ($4*100):1 w line t "3 cycles", \
     "./FreqRatioMaxError.dat" u ($5*100):1 w line t "4 cycles" #, \
  #   "./FreqRatioMaxError.dat" u ($6*100):1 w line t "5 cycles" #, \
#     "./FreqRatioMaxError.dat" u ($7*100):1 w line t "10 cycles"

set output
set term x11