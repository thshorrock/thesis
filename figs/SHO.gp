
set term epslatex
set output "c4_SHO.tex"
set size 0.7
visc = 1e-3
st = 0.07280
rho = 1000
kappa = 1.0
c = 1480
p =  0.1013e6
pe(r) = p + 2.0* st / r

m(r) = r*(1+4.0*visc/(rho*c*r))
lambda(r) = (4.0*visc/(rho*r) + 3.0*kappa*pe(r) / (rho*c)  - 2.0*st/(r*rho*c))/m(r)
wr(r)   =  sqrt((1.0/(rho*r))* (3.0*kappa*pe(r) - 2.0* st / r)/m(r))

beta(r,w) = atan( lambda(r) * wr(r)/ ((w*2*pi*1e6)**2 - wr(r)**2))

rad0 = 100e-9
rad1 = 300e-9
rad2 = 1e-6
set ytics ( "-$\\pi$/2" - pi/2, "-\\pi" -pi, "-3$\\pi$/2" -1.5*pi, "-2$\\\pi$" -2pi)
#set y2tics () #( "-$\\pi$/2" - pi/2, "-\\pi" -pi, "-3$\\pi$/2" -1.5*pi, "-2$\\\pi$" -2pi)
set ytics add (-0.18,  -0.63)
#set y2tics add (-0.38)
set yrange [-2*pi:0]
set key bottom left 
set xrange[0.25:50]
set logscale x
set samples 100000
plot beta(rad0,x)<0 ? beta(rad0,x): beta(rad0,x)-2*pi title "100nm", \
beta(rad1,x)<0 ? beta(rad1,x): beta(rad1,x)-2*pi t "300nm", \
 beta(rad2,x)<0 ? beta(rad2,x): beta(rad2,x)-2*pi t "1000nm"

 set output
set term pop
epstopdf ./c4_SHO.eps