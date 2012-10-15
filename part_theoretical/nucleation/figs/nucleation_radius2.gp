
set key samplen 1
set size 0.7
set term epslatex solid color
set output "nucleation_radius.tex"
u = 1.66053878283e-27
A = 6.0221417930e23
uA = u*A
R = 8.31447215 # gas constant
T = 298



#P in bar, T in kelvin 300. - 421.8
Apfb = 	4.14250	
Bpfb = 982.586
Cpfb = 	-33.624
Mrpfb = (238.0268 / 1e3)/A
Mpfb =238.0268/1e3 # molar mass kgs per mole
#print Mpfp
rhopfb =  1.497*1e3 #kg/m3 at 25 298 Yaws
sigmapfb = 11.093e-3 # Yaws dynes/cm
#6.20963	2354.731	7.559



#P in bar, T in kelvin 300. - 421.8
Apfp = 	4.38423
Bpfp = 1257.758
Cpfp = -13.231
Mrpfp = (288.0343 / 1e3)/A
Mpfp =288.0343 /1e3 # molar mass kgs per mole
#print Mpfp
rhopfp = 1.62 * 1000  #kg/m3 at 25 298 Sakka 2005
sigmapfp = 9.89e-3 # dynes/cm Sakka2005
#6.20963	2354.731	7.559

Awater = 6.20963
Bwater =2354.731
Cwater =7.559
#Awater =5.40221
#Bwater =1838.675	
#Cwater =-31.737
Mrwater = (18.0153 / 1e3)/A #mass of 1 particle in kgs
#Mrwater2 = 18*u
Mwater = 18.0153 / 1e3  #  mass kgs of 1 mole
rhowater = 1000  #kg/m3 at 25 298
sigmawater = 72.14e-3
bar2SI = 1e5 

#print "mr water1 ", Mrwater, "kg"
#print "mr water2 ", Mrwater2, "kg"

logp( A, B, C) =   A - (B / (T + C)) # Antoines equation
#print logp( Apfp, Bpfp, Cpfp)
pinfty ( A, B, C)= 10**(logp(A,B,C)  ) *bar2SI 
#print sigmapfp / pinfty( Apfp, Bpfp, Cpfp)*1e9

KT(T) = T*1.3806503e-23

molecular_volume(M,rhoL) = (M/rhoL)/A #kg/mol / kg /m^3 / number of moleucles in mole

pvap(pL, A, B, C, M, rhoL) = pinfty ( A, B, C) * exp(molecular_volume(M,rhoL) * (pL-pinfty ( A, B, C)) / (KT(T)))

astar(pL, A, B, C, M, rhoL, sigma) = sigma / (pvap( pL, A, B, C, M, rhoL) - pL )

rhov(pL, A, B, C, M, rhoL,Mr) = pvap(pL, A, B, C, M, rhoL)*(Mr/KT(T))


#J0(pL, A, B, C, M, rhoL, sigma, mass) = ((rhov(pL, A, B, C, M, rhoL,mass))**2/rhoL)*sqrt(sigma/mass)
J0(pL, A, B, C, M, rhoL, sigma, mass) = (rhoL/mass)*sqrt(sigma/mass) / 1e6 #per cm cubed

DeltaG(pL, A, B, C, M, rhoL, sigma) = 16.0*pi*sigma**3/(3*(pvap(pL, A, B, C, M, rhoL)-pL)**2)

J(pL, A, B, C, M, rhoL, sigma, mass) = J0(pL, A, B, C, M, rhoL, sigma, mass)*exp(-DeltaG(pL, A, B, C, M, rhoL, sigma)/KT(298))

volume(pL, A, B, C, M, rhoL, sigma) = 4*pi*(astar(pL, A, B, C, M, rhoL, sigma))**3/3


number(pL, A, B, C, M, rhoL, sigma) = pvap(pL, A, B, C, M, rhoL)*volume(pL, A, B, C, M, rhoL, sigma) / KT(298)

#plot pvap(x,  Apfp, Bpfp, Cpfp, Mpfp, rhopfp), \
# pvap(x,  Awater, Bwater, Cwater, Mwater, rhowater)
set xrange[0.0:-2]
set yrange[0:100]
set xlabel "negative pressure (MPa)"
set ylabel "critical radius (nm)"

#set size square

set lmargin 3
set rmargin 1
set tmargin 0.1
set bmargin 3
#print sigmapfp / pvap(0, Apfp, Bpfp, Cpfp, Mpfp, rhopfp)*1e9

plot astar(x*1e6, Apfb, Bpfb, Cpfb, Mpfb, rhopfb, sigmapfb)*1e9 title "perfluorobutane", \
astar(x*1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp)*1e9 title "perfluoropentane", \
     astar(x*1e6, Awater, Bwater, Cwater, Mwater, rhowater, sigmawater)*1e9 title "water"
     set output
     set term pop
     set term epslatex solid color 
     set output "nucleation_number.tex"

     set size 0.7
     set yrange[0:200]
     set key bottom left
     set key width -5
     set ylabel "critical number of molecules"

#set size square
set lmargin 4
set rmargin 1
set tmargin 0.1
set bmargin 3
     
plot number(x*1e6, Apfb, Bpfb, Cpfb, Mpfb, rhopfb, sigmapfb) title "perfluorobutane", \
     number(x*1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp) title "perfluoropentane", \
     number(x*1e6, Awater, Bwater, Cwater, Mwater, rhowater, sigmawater) title "water"


     set output
     set term pop
     set term epslatex solid color
     set output "c2_cnt_nucleation_rate.tex"

     ##set key box
     set key width -5
    set lmargin 10
set rmargin 1
set tmargin 0.1
set bmargin 3 
print "vapour density of water ", rhov(-1e6, Awater, Bwater, Cwater, Mwater, rhowater,  Mrwater)
print "liquid density of water ",rhowater


print "vapour density of pfp ", rhov(-1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp,  Mrpfp)
print "liquid density of pfp ",rhopfp

print "pvap water ", pvap(-1e6, Awater, Bwater, Cwater, Mwater, rhowater)
print "pliq water ", -1e6
#print DeltaG(-1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp )/KT(298)
print "J0 pfp = ",J0(-1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp, Mrpfp)
print "J0 water = ", J0(-1e6, Awater, Bwater, Cwater, Mwater, rhowater, sigmawater, Mrwater)
set xrange[1:200]
set yrange[1e-40:1e50]
set key  top left
set format y "$10^{%L}$"
set logscale y
set logscale x
set ylabel "nucleation rate (\$\\centi\\meter^{-3}\\second^{-1}\$)" offset 6,0

set yzeroaxis lt -1
#set yrange[-20:10e40]
#set logscale y
#plot pvap(x*1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp) title "perfluoropentane"
plot J(-x*1e6, Apfb, Bpfb, Cpfb, Mpfb, rhopfb, sigmapfb,Mrpfb) title "perfluorobutane", \
J(-x*1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp,Mrpfp) title "perfluoropentane",     \
J(x*1e6, Awater, Bwater, Cwater, Mwater, rhowater, sigmawater, Mrwater) title "water"
#plot   DeltaG(x*1e6, Awater, Bwater, Cwater, Mwater, rhowater, sigmawater)/KT(298) title "water"
     
     set output
     set term pop

print "perfluorcarbon molecular volume  =", molecular_volume(Mpfp,rhopfp)  #kg/mol / kg /m^3 / number of moleucles in mole
#print pvap(-1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp)
#print astar(-1e6, Apfp, Bpfp, Cpfp, Mpfp, rhopfp, sigmapfp)*1e9 