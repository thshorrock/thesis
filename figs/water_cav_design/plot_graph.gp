set ylabel "number density (normalised)"
set xlabel "bubble radius (microns)"

set size 0.8, 0.7
set xrange [0:15]
set tmargin 2

set term epslatex  color
set output "sonovue_sizes.tex" 
plot "./master_sizer_test.dat" u 2:3 w l title "15:08", \
     "./master_sizer_test.dat" u 2:4 w l title "17:39", \
     "./master_sizer_test.dat" u 2:5 w l title "20:10", \
     "./master_sizer_test.dat" u 2:6 w l title "22:41", \
     "./master_sizer_test.dat" u 2:7 w l title "25:12", \
     "./master_sizer_test.dat" u 2:8 w l title "27:44" lc 9
set output
set term pop
