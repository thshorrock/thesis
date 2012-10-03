

  set size 0.8, 0.5
  set ylabel "radius (\$\\mu\$ m)"
  set xlabel "iteration" 
  #set xrange[0:35]
  #set yrange[-0.25: 0.30]
  set term epslatex color solid
  set rmargin 0.1
  set lmargin 0.1
  set tmargin 0.2
  set key samplen 0.2
  set xtic 200
  set ytic 0.5

  set output "param_108_150_av_b_rad.tex"
  set style fill transparent solid 2.0 noborder

  plot "./params_108_150_av_b.txt"  u 0:(exp($4)) w l notitle

  set output
  set term pop

