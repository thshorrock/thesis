

  set size 0.8, 0.5
  set ylabel "{{filter - pass}}"
  set xlabel "frequency (MHz)" 
  set xrange [0:30]

  #set yrange[-1.0: 2.]
  set term epslatex color solid
  set rmargin 0.1
  set lmargin 0.1
  set tmargin 0.2
  set key samplen 0.2
  #set xtic 200
  #set ytic 0.5

  set output "plot_bubble_fit_108_150_av_filter_a_filter.tex"
  set style fill transparent solid 2.0 noborder

  plot 0.6329089749 * exp(-0.5*(x-15.56775505)**2/15.78540462) w l notitle

  set output
  set term pop

