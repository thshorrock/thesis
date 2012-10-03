#!/bin/bash
#                 TABLE
#J. Phys. Chem., 1956, 60 (4), pp 504–505
#                      I1
#VAPOR  PRESSURE PERFLUORO-~~-PENTANE
#  Pressureb   Temp.,   
# mm. a t 0     OC.    
echo "   347.56      9.67   
   395.99     12.70   
   447.94   15.68  
   497.16     18.25  
   547.68     20.69  
   624.20     24.10  
   743.95    28.74   
   940.5      35.28  
  1149.0     41.12
1357.4    46.09
 1574.5    50.80
 1809.6    55.31
1801.0    54.94
1789.5    54.93
1976.2    58.28
2175.3    60.76
2391.5    64.79" >  perfluoropentane_vapour_pressure.dat

#J. Chem. Eng. Data, 1967, 12 (4), pp 481–485
# n-CiF:? Liquid Perfluoro-n-pentane
#temp  mm meaured mm calc errorbetween two
echo "221.17          9.28               9.37   -0.92
226.36         14.00              13.88     0.85
240.16         36.49              35.95     1.47
250.66         67.95              68.40   -0.66
259.91        113.33             114.64   -1.16
271.76        207.78             209.17   -0.67
280.70        318.64             316.41     0.70
286.13        402.17             400.74     0.36
289.75        467.09             466.35     0.16
294.25        558.38             559.54   -0.21
297.19        628.37             627.99     0.06
297.59        635.40             637.79   -0.38
302.32        764.92             763.09     0.24
303.00        783.75             782.58     0.15" | awk '{tK = $1-273.15;} {print $2, tK  }' >  perfluoropentane_vapour_pressure2.dat

cat perfluoropentane_vapour_pressure.dat > perfluoropentane_vapour_combo.dat
cat perfluoropentane_vapour_pressure2.dat >> perfluoropentane_vapour_combo.dat
cat perfluoropentane_vapour_combo.dat | sort -g -k2  | awk '{tK = $2+273.15; mm = $1*1e-2/7.5006} {print  tK, mm  }' > perfluoropentane_vapour_combo.dat

cat perfluoropentane_vapour_pressure.dat | sort -g -k2  | awk '{tK = $2+273.15; mm = $1*1e-2/7.5006} {print  tK, mm  }' > perfluoropentane_vapour_pressure.dat
cat perfluoropentane_vapour_pressure2.dat | sort -g -k2  | awk '{tK = $2+273.15; mm = $1*1e-2/7.5006} {print  tK, mm  }' > perfluoropentane_vapour_pressure2.dat

gnuplot<<EOF
set size 0.7
set size square
set term epslatex 

#hard sphere pressure
eta(rho) = pi*rho*d**3/6.0
ph(rho) = kB*T*rho*(1+eta(rho) +eta(rho)**2 - eta(rho)**3)/(1-eta(rho))**3
alpha = 1
int(rho) = -0.5*alpha*rho**2

set output "perfluoropentane_vp.tex"
set xlabel "temperature (\${}^\\\circ\$C)
set ylabel "vapour pressure (bar) "
plot "./perfluoropentane_vapour_pressure.dat" u  2:(\$1*1e-2/7.5006) notitle
set output
set term pop
EOF
epstopdf perfluoropentane_vp.eps
