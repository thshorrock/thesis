
verbatimtex
%&latex
%\documentclass{article}
\documentclass[10pt]{/home/tom/thesis/mythesis} 
\input{/home/tom/latex/input/packages.tex}
\usepackage[T1]{fontenc}
\usepackage{textcomp}
\usepackage[minionint,mathlf]{MinionPro}
\begin{document}
\LARGE
etex


%verbatimtex \input '/home/tom/latex/input/packages' etex
%verbatimtex \input amsmath  etex

numeric std_pen_size;
std_pen_size := 0.3pt;

pickup pencircle scaled std_pen_size;

numeric pi; pi := 3.1415926;
numeric radian; radian := 180/pi; % 2pi*radian = 360 ;

vardef arcsind primary x = angle((1+-+x,x)) enddef;
vardef arccosd primary x = angle((x,1+-+x)) enddef;
vardef sin primary x = (sind(x*radian)) enddef;
vardef cos primary x = (cosd(x*radian)) enddef;
vardef tan primary x = (sin(x)/cos(x))  enddef;
vardef tand primary x = (sind(x)/cosd(x)) enddef;
vardef exp primary x = ((mexp 256)**x) enddef;



def draw_transducer(expr tip, h, l, weight) =
  begingroup
    save frac, pnt, line;
    numeric frac; %length height percent for middle line
    pair pnt[];
    path line[];
    
    frac := .80;
    
    pnt0 := tip - (l, h/2);
    pnt1 := tip - (0, h/2);
    pnt2 := tip + (0, h/2);
    pnt3 := tip - (l,-h/2);

    pnt4 := tip - ((1-frac)*l, h/2);
    pnt5 := tip - ((1-frac)*l,-h/2);

    line0 := pnt0--pnt1--pnt2--pnt3--cycle;
    line1 := pnt4--pnt5;
 
    draw line0 withcolor weight*white;;
    draw line1 withcolor weight*white;;
    
  endgroup
enddef;


def draw_mirror(expr tip, h, l, weight) =
  begingroup
    save no_lines,pnt, line;
    numeric no_lines;
    pair pnt[];
    path line[];
    
    no_lines = abs(h/l);
    
    pnt0 = tip + (0, h/2);
    pnt[1+no_lines] =  pnt0 + (l,-l);
    draw pnt0-- pnt[1+no_lines] withcolor weight*white;
    for i = 1 upto no_lines:
      pnt[i]            = pnt[i-1] - (0, l);
      pnt[i+1+no_lines] = pnt[i+no_lines] - (0, l);
      draw pnt[i]--pnt[i+1+no_lines] withcolor weight*white;
    endfor
    
    draw pnt0 -- pnt[no_lines] withcolor weight*white;
    
  endgroup
enddef;

def draw_axis(expr orig, h, w, do_label) =
  begingroup

    save pnt, line;
    
    pair pnt[];
    path line[];
    
    
    pnt0 = orig;
    pnt1 = orig+(w,0);
    pnt2 = orig+(0,h);

    drawarrow pnt0--pnt1;
    drawarrow pnt0--pnt2;
    
    if (do_label=1) :
      label.bot(btex optical-space etex, pnt1 );
      label.top(btex $c \times$optical-time etex, pnt2);
      %label.llft(btex $0$ etex, pnt0);
    fi
  
  endgroup
enddef;

def angle_between(expr A,B) =
  begingroup
    save m_angle, ret;
    save m_intercept ;
    pair m_intercept ;
    m_intercept = extend_path(A) intersectionpoint extend_path(B);
    numeric m_angle[], ret;
    %show "angle0 = " ;
    m_angle0 = angle(point 1 of A - m_intercept);
    %show m_angle0;
    m_angle1 = angle(point 1 of B - m_intercept);
    %show "angle1 = " ;
    %show m_angle1;
    ret = -(m_angle1 - m_angle0);
    %show "angle";
    %show ret;
    ret
  endgroup
enddef;



def extend(expr A, B) =
  begingroup

    save m_angle, large_number, extended;
    numeric m_angle;
    numeric large_number;
    path extended;
    large_number = 100u;
    m_angle = angle(B-A);
    %show m_angle;
    extended = (xpart(A)- large_number*cosd(m_angle),ypart(A) - large_number*sind(m_angle) ) -- (xpart(A)+ large_number*cosd(m_angle),ypart(A) + large_number*sind(m_angle) );
    
    extended
  endgroup
enddef;

def extend_by(expr A, B, by_this_much) =
  begingroup

    save m_angle, extended, newend;
    numeric m_angle;
    path extended;
    pair newend[];
    m_angle = angle(B-A);

    newend0 = (xpart(A)-(by_this_much-1)*abs(B-A)*cosd(m_angle),ypart(A) - (by_this_much-1)*abs(B-A)*sind(m_angle) );
    newend1 = (xpart(A)+ by_this_much*abs(B-A)*cosd(m_angle),ypart(A) + (by_this_much)*abs(B-A)*sind(m_angle) );
    %show m_angle;
    extended = newend0 -- newend1 ;
    
    extended
  endgroup
enddef;
def extend_path(expr p) =
  begingroup
    save pntP, pLong;
    pair pntP[];
    path pLong;
    pntP[0] = point 0 of p;
    pntP[1] = point 1 of p;
    pLong = extend(pntP0, pntP1);
    pLong
  endgroup
enddef;

def extend_path_by (expr p, by_this_much) =
  begingroup
    save pntP, pLong;
    pair pntP[];
    path pLong;
    pntP[0] = point 0 of p;
    pntP[1] = point 1 of p;
    pLong = extend_by(pntP0, pntP1, by_this_much);
    pLong
  endgroup
enddef;

def sqrt_path(expr p, unit_pair) =
  begingroup
    save pntP, return_point, scaled_length;
    pair pntP[], return_point;
    numeric scaled_length;

    pntP[0] = point 0 of p;
    pntP[1] = point 1 of p;
    scaled_length = arclength(pntP1--pntP0)/arclength(unit_pair--pntP0);
%    show "scaled length = ";
%    show scaled_length;
    return_point = point (1.0/sqrt(scaled_length)) of p;
    return_point
    
  endgroup
enddef;



def parallel(expr pnt, A, B) =
  begingroup
    
    
    save m_angle, large_number, extended;
    numeric m_angle;
    numeric large_number;
    path extended;
    large_number = 100u;
    m_angle = angle(B-A);
    %show m_angle;
    extended = (xpart(pnt)- large_number*cosd(m_angle),ypart(pnt) - large_number*sind(m_angle) ) -- (xpart(pnt)+ large_number*cosd(m_angle),ypart(pnt) + large_number*sind(m_angle) );

    extended
    
  endgroup
enddef;

def arcproject(expr the_line, distance) =
  begingroup
    save m_angle, p, pntP, pntPPrime, m_shift;
    
    numeric m_angle;
    path p;
    pair pntP[], pntPPrime[];
    pair m_shift;
    
    pntP0 = point 0 of the_line;
    pntP1 = point 1 of the_line;
    
    m_angle = 90 - angle(pntP1-pntP0);
    m_shift = distance*(cosd m_angle, -sind m_angle);

    pntPPrime0 = pntP0+m_shift;
    pntPPrime1 = pntP1+m_shift;

    p = pntPPrime0--pntPPrime1;

    p
     
  endgroup
enddef;


      


def horizontal(expr pnt) =
  begingroup
    save h;
    path h;
    h = extend_path(pnt -- (pnt + (1u,0)));
%    h = parallel(pnt, (0,0), (1u,0));
    h
    
  endgroup
enddef;


def obs_spatial_intercept(expr the_observer,  pntA, pntB ) =
  begingroup
    save big_path, intp;
    
    pair intp;
    path big_path;
    big_path = extend(pntA, pntB);
    intp = big_path intersectionpoint the_observer;

    draw big_path withcolor blue;
    intp
    
    
  endgroup
enddef;

def light_out(expr at) =
  begingroup

    save light_path;    path light_path;
    
    light_path = parallel(at, (0,0), (1u,1u));
    light_path
    
  endgroup

enddef;

def light_ret(expr at)=
  begingroup

    save light_path;    path light_path;
    
    light_path = parallel(at, (0,0), (-1u,1u));
    light_path
    
  endgroup

enddef;

def light_out_intp(expr the_obs, pnt) =
  begingroup
    save light, intp;
    path light;
    pair intp;

    light = light_out(pnt);
    intp  = extend_path(the_obs) intersectionpoint light;
    intp
  endgroup
enddef;

def light_ret_intp(expr the_obs, pnt) =
  begingroup
    save light, intp;
    path light;
    pair intp;

    light = light_ret(pnt);
    intp  = extend_path(the_obs) intersectionpoint light;
    intp
    
  endgroup
enddef;



def light_out_first_path(expr the_obs, the_obj, m_point) =
  begingroup
    %pnt is on the outward path, and light going out first
    save pnt, light;
    pair pnt[]; path light;
    pnt0 = light_out_intp(the_obs, m_point);
    pnt1 = light_out_intp(the_obj, m_point);
    pnt2 = light_ret_intp(the_obs, pnt1);
    light = pnt0--pnt1--pnt2;
    light
  endgroup
enddef;

def light_out_second_path(expr the_obs, the_obj, m_point) =
  begingroup
    %pnt is on the outward path, and light outwards second. I.e 'returning' first i.e. moving towards the left
    save pnt, light;
    pair pnt[]; path light;
    pnt2 = light_out_intp(the_obj, m_point);
    pnt1 = light_out_intp(the_obs, m_point);
    pnt0 = light_ret_intp(the_obj, pnt1);
    light = pnt0--pnt1--pnt2;
    light
  endgroup
enddef;

def light_ret_first_path(expr the_obs, the_obj, m_point) =
  begingroup
    save pnt, light;
    pair pnt[]; path light;
    pnt0 = light_ret_intp(the_obj, m_point);
    pnt1 = light_ret_intp(the_obs, m_point);
    pnt2 = light_out_intp(the_obj, pnt1);
    light = pnt0--pnt1--pnt2;
    light
  endgroup
enddef;

def light_ret_second_path(expr the_obs, the_obj, m_point) =
  begingroup
    save pnt, light;
    pair pnt[]; path light;
    pnt2 = light_ret_intp(the_obs, m_point);
    pnt1 = light_ret_intp(the_obj, m_point);
    pnt0 = light_out_intp(the_obs, pnt1);
    light = pnt0--pnt1--pnt2;
    light
  endgroup
enddef;

def timelike(expr the_obs, m_point) =
  begingroup
    
    save m_path;
    path m_path;
    m_path = parallel(m_point, point 0 of the_obs, point 1 of the_obs);
    m_path %return
    
  endgroup
enddef;


def spatial(expr the_obs,the_obj, m_point) =
  begingroup
    save pntObs, pntObj, full_obs, full_obj, pnt, spatial, spatial_path;
    pair pntObs[], pntObj[];
    pntObs[0] = point 0.1 of the_obs;
    pntObs[1] = point 1 of the_obs;
    pntObj[0] = point 0.1 of the_obj;
    pntObj[1] = point 1 of the_obj;

    path full_obs, full_obj;
    full_obs = parallel(pntObs0, pntObs0, pntObs1);
    full_obj = parallel(pntObj0, pntObj0, pntObj1);
    
    pair test_obj;
    test_obj = horizontal(pntObs0) intersectionpoint the_obj;
    
    pair pnt[], spatial[];

    
    if(xpart(pntObs0) < xpart(test_obj)) :
      pnt0 = light_out_intp(the_obs,pntObs0 );
      pnt1 = light_out_intp(the_obj,pntObs0 );
      pnt2 = light_ret_intp(the_obs, pnt1);
      spatial0 = 1/2[pnt0,pnt2];
    spatial1 = pnt1;
    elseif (xpart(pntObs0) = xpart(test_obj)) :
      %will have a problem
      show "There is a problem";  
    else :
      pnt0 = light_ret_intp(the_obj,pntObs0);
      pnt1 = light_ret_intp(the_obs,pntObs0);
      pnt2 = light_out_intp(the_obj, pnt1);
      spatial0 = 1/2[pnt0,pnt2];
    spatial1 = pnt1;
    fi

    %spatial0 = 1/2[pnt0,pnt2];
    %spatial1 = pnt1;

    path spatial_path;
    spatial_path = parallel(m_point,spatial0,  spatial1);
    spatial_path
  endgroup
enddef;




def arcspatialproject(expr the_line, distance, the_obs,the_obj) =
  begingroup
    save m_angle, p, pntP, pntPPrime, m_shift;
    
    numeric m_angle;
    path p;
    pair pntP[], pntPPrime[];
    pair m_shift;
    
    pntP0 = point 0 of the_line;
    pntP1 = point 1 of the_line;

    pntPPrime0 = (pntP0 + distance*unitvector((point 1 of  spatial(the_obs,the_obj, pntP0)) - (point 0 of  spatial(the_obs,the_obj, pntP0)  )));
    pntPPrime1 = (pntP1 + distance*unitvector((point 1 of  spatial(the_obs,the_obj, pntP1)) - (point 0 of  spatial(the_obs,the_obj, pntP1)  )));
    
    p = pntPPrime0--pntPPrime1;

    p
     
  endgroup
enddef;




def draw_hyperbola(expr  theta_max, the_pnt) = 
  begingroup
    %plot(  ( 0.5*(exp(α0)-exp(-α0)), 0.5*(exp(α0)+exp(-α0))),start->P.x, stop->O.x   )
    save pnt, npoints, theta,  theta_step, marc;
    pair pnt[];
    numeric theta[];
    numeric theta_step;
    path marc;

  pickup pencircle scaled 1pt;
    
    npoints = 1000;
    theta_step = 2* theta_max / npoints;
    theta0 = -theta_max;
    pnt0 =  o+ abs(the_pnt-o)*( 0.5*(exp(theta[0])-exp(-theta[0])), 0.5*(exp(theta[0])+exp(-theta[0])));
    for i = 1 upto npoints:
      theta[i] = -theta_max + i*theta_step;
      pnt[i] = o+ abs(the_pnt-o)*( 0.5*(exp(theta[i])-exp(-theta[i])), 0.5*(exp(theta[i])+exp(-theta[i])));
      draw pnt[i-1]..pnt[i] withcolor green;
    endfor
      
  pickup pencircle scaled std_pen_size;
  endgroup
enddef;




def draw_geometry(expr  theta_max, the_line, interval) = 
  begingroup
 
    save pnt, npoints, thseta,  theta_step, grad_fix,grad;
    numeric lambda[];
    numeric lambdas[];
    pair pnt[];
    numeric theta[];
    numeric grad_fix, grad[];
    numeric theta_step;
    
  pickup pencircle scaled 1pt;
  %  grad_fix = tand(angle_between(obs0, the_line)) ;
  %show "angle is :";
  %show angle_between(extend_path(obs0),extend_path(the_line))/radian;
  %show "end angle is";
%  grad_fix = 1;
  save angle_fix;
  numeric angle_fix;
  angle_fix = abs(angle_between(extend_path(obs0),extend_path(the_line))/radian);
  if angle_fix < 0.01 :
    %tan 90  blows up 
    %will need to make adjustments later
  else :
  grad_fix = tand( -angle_between(horizontal(o),extend_path(the_line))) ;
  fi
  
% grad_fix = tan(obs0, the_line) ;
  npoints = 1000;
  save theta_range;
  numeric theta_range;
  theta_range =  pi/3; %pi/6
    theta_step = theta_range / npoints ; %2* theta_max / npoints;
    theta0 = theta_max - 0.5*angle_between(extend_path(obs0),extend_path(the_line))/radian - theta_range/2 ;
    
   grad0 =  tan(theta0);
    numeric lambda[];
    numeric lambdas[];
    numeric scalef[];
    for i = 1 upto npoints:
      theta[i] = theta0  + i*theta_step;
      
      
      if abs(theta[i]- pi/2 ) > 0.001 :
	%This is enough to get a continuous looking line without it blowing up
	grad[i] = tan(theta[i]);
	if angle_fix < 0.01 :
	  if abs(pi/2 - theta[i]) > 0.006 :
	    lambdas[i] = (grad[i]*grad[i])/( (grad[i]*grad[i] - 1 )  ) ;
	    lambda[i] = sqrt(lambdas[i]);
	  else:
	  %approximate the lambda
	    lambdas[i] = 1.0 ;
	    lambda[i] = sqrt(lambdas[i]);
	  fi
	  draw o+ lambda[i]*(interval/grad[i],interval) withcolor green;
	  
	else:  	
	  if abs(pi/2 - theta[i]) > 0.04 :
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix* (1 - 1/(grad[i]*grad[i]) )  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(grad_fix*interval/(grad_fix*grad[i]-1),grad_fix*grad[i]*interval/(grad_fix*grad[i]-1)) withcolor green;
	    
	  elseif abs(pi/2 - theta[i]) > 0.006 :
	  %numerically unstable approximate the grad*grad*interval
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix* (1 - 1/(grad[i]*grad[i]) )  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(grad_fix*interval/(grad_fix*grad[i]-1),interval*(1+1/(grad_fix*grad[i]))) withcolor green;
	    
	  else :
	  %approximate the lambda
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(grad_fix*interval/(grad_fix*grad[i]-1),interval*(1+1/(grad_fix*grad[i]))) withcolor green;
	  fi
	%tan theta blows up
	fi
      fi


    endfor

      
  pickup pencircle scaled std_pen_size;
  endgroup
enddef;




def draw_geometry_horizontal(expr  theta_max, the_line, interval) = 
  begingroup
    save pnt, npoints, thseta,  theta_step, grad_fix,grad;
    save lambda, lambdas;
    save theta_range;
    pair pnt[];
    numeric theta[];
    numeric grad_fix, grad[];
    numeric theta_step;
    numeric theta_range;
    numeric lambda[];
    numeric lambdas[];
    
    pickup pencircle scaled 1pt;
    save angle_fix;
    numeric angle_fix;
    angle_fix = abs(angle_between(extend_path(obs0),extend_path(the_line))/radian);
    if angle_fix < 0.01 :
    %tan 90  blows up 
    %will need to make adjustments later
    else :
      grad_fix = tand( -angle_between(horizontal(o),extend_path(the_line))) ;
    fi
    
    npoints = 1000;
    theta_range =  pi/3; %pi/6
    theta_step = theta_range / npoints ; %2* theta_max / npoints;
    theta0 = theta_max - 0.5*angle_between(extend_path(obs0),extend_path(the_line))/radian - theta_range/2 ;
    
    grad0 =  tan(theta0);
    
    
    for i = 1 upto npoints:
      theta[i] = theta0  + i*theta_step;
      
      if abs(theta[i]- pi/2 ) > 0.001 :
	%This is enough to get a continuous looking line without it blowing up
	grad[i] = tan(theta[i]);
	if angle_fix < 0.01 :
	  if abs(pi/2 - theta[i]) > 0.006 :
	    lambdas[i] = (grad[i]*grad[i])/( (grad[i]*grad[i] - 1 )  ) ;
	    lambda[i] = sqrt(lambdas[i]);
	  else:
	  %approximate the lambda
	    lambdas[i] = 1.0 ;
	    lambda[i] = sqrt(lambdas[i]);
	  fi
	  draw o+ lambda[i]*(interval,interval/grad[i]) withcolor green;
	else:  
	  if abs(pi/2 - theta[i]) > 0.04 :
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix* (1 - 1/(grad[i]*grad[i]) )  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(grad_fix*grad[i]*interval/(grad_fix*grad[i]-1),grad_fix*interval/(grad_fix*grad[i]-1)) withcolor green;
	  elseif abs(pi/2 - theta[i]) > 0.006 :
	  %numerically unstable approximate the grad*grad*interval
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix* (1 - 1/(grad[i]*grad[i]) )  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(interval*(1+1/(grad_fix*grad[i])),grad_fix*interval/(grad_fix*grad[i]-1)) withcolor green;
	    
	  else :
	  %approximate the lambda
	    lambdas[i] = ( (grad_fix - 1/grad[i])/( grad_fix  ) );
	    lambda[i] = sqrt(lambdas[i]);
	    draw o+ lambda[i]*(interval*(1+1/(grad_fix*grad[i])),grad_fix*interval/(grad_fix*grad[i]-1)) withcolor green;
	  fi
	  
	%tan theta blows up
	fi
      fi

    endfor
  pickup pencircle scaled std_pen_size;
  endgroup
enddef;











numeric u; %scale
u = 2mm;
pair o;
o := (10u,10u);

numeric ahlength;
ahlength = 4bp; % usually 4

numeric interval, shear, shearprime;


interval = 25u;
shear = interval*.72;
shearprime = shear*0.6 ;

path obs[], obj[];
obs0 := (o )  -- ( o + (0,2*interval));
obj0 := (o + (interval, 0u))  -- ( o + (interval,2*interval));

obs1 := (o )  -- ( o + (shear,2*interval)) ;
obj1 := (o + (interval, 0) )  -- ( o + (shear+interval,2*interval));


obs2 := (o )  -- ( o + (shearprime,2*interval)) ;
obj2 := (o + (interval, 0) )  -- ( o + (shearprime+interval,2*interval));


pair pntDPrime[],pntPrime[], pnt[], time[], timePrime[],timeDPrime[], projTimePrime[],projTimeDPrime[], projXPrime[],projXDPrime[];;

pair pntDRPrime[], timeDRPrime[], projTimeDRPrime[];

pnt0 = light_out_intp(obs0,  point 0 of obs0 );
pnt1 = light_out_intp(obj0,  point 0 of obs0 );
pnt2 = light_ret_intp(obs0,  pnt1 );

pntPrime0 = light_out_intp(obs1,  point 0 of obs1 );
pntPrime1 = light_out_intp(obj1,  point 0 of obs1 );
pntPrime2 = light_ret_intp(obs1,  pntPrime1 );


pntDPrime0 = light_out_intp(obs2,  point 0 of obs2 );
pntDPrime1 = light_out_intp(obj2,  point 0 of obs2 );
pntDPrime2 = light_ret_intp(obs2,  pntDPrime1 );

pntDRPrime0 = pntPrime0;
pntDRPrime1 = pntPrime1;
pntDRPrime2 = pntPrime2;

time0 = pnt0;
time1 = extend_path(obs0) intersectionpoint horizontal(pnt1);
time2 = pnt2;

timePrime0 = pntPrime0;
timePrime1 = extend_path(obs1) intersectionpoint spatial(obs1, obj1, pntPrime1);
timePrime2 = pntPrime2;


timeDPrime0 = pntDPrime0;
timeDPrime1 = extend_path(obs2) intersectionpoint spatial(obs2, obj2, pntDPrime1);
timeDPrime2 = pntDPrime2;



timeDRPrime0 = pntDRPrime0;
timeDRPrime1 = extend_path(obs2) intersectionpoint spatial(obs1, obj1, pntDPrime1);
timeDRPrime2 = pntDRPrime2;
   
   
projTimePrime0 = extend_path(obs0) intersectionpoint horizontal(timePrime0);
projTimePrime1 = extend_path(obs0) intersectionpoint horizontal(timePrime1);
projTimePrime2 = extend_path(obs0) intersectionpoint horizontal(timePrime2);

projXPrime0= extend_path(obs0) intersectionpoint horizontal(pntPrime1);
projXPrime1= extend_path(obs1) intersectionpoint horizontal(pntPrime1);


projTimeDPrime0 = extend_path(obs2) intersectionpoint spatial(obs2, obj2,timePrime0);
projTimeDPrime1 = extend_path(obs2) intersectionpoint spatial(obs2, obj2,timePrime1);
projTimeDPrime2 = extend_path(obs2) intersectionpoint spatial(obs2, obj2,timePrime2);
%Reciprical graph
projTimeDRPrime0 = extend_path(obs2) intersectionpoint spatial(obs1, obj1,timePrime0);
projTimeDRPrime1 = extend_path(obs2) intersectionpoint spatial(obs1, obj1,timePrime1);
projTimeDRPrime2 = extend_path(obs2) intersectionpoint spatial(obs1, obj1,timePrime2);

projXDPrime0= extend_path(obs0) intersectionpoint horizontal(pntDPrime1);
projXDPrime1= extend_path(obs1) intersectionpoint horizontal(pntDPrime1);
projXDPrime2= extend_path(obs2) intersectionpoint horizontal(pntDPrime1);


   show "speed of obs1 = " ;
   show (shear / (2*interval) ) * 1482.3 ;
  
   show "speed of obs2 = " ;
   show (shearprime / (2*interval) ) * 1482.3 ;

   show "tau- = " ;
   show abs(o - o);
   show "tau(x) = " ;
   show "  xpart= " ;
   show (xpart(timeDPrime1 - o) / interval)/2;
   show "  ypart= " ;
   show (ypart(timeDPrime1 - o) / interval)/2;
   show "tau(tauprime(xprime)) = " ;
   show "  xpart= " ;
   show (xpart(projTimeDPrime1 - o) / interval)/2;
   show "  ypart= " ;
   show (ypart(projTimeDPrime1 - o) / interval)/2;

   
   show "  acoustic:" ;
   show (abs(timePrime1 - o) / interval)/2;
   show (abs(timePrime1 - o) / interval) *(1000 / (2*1.4823));
   show "tau(x^\prime) = ";
   show (abs(projTimeDPrime1 - o) / interval)/2;
   show (abs(projTimeDPrime1 - o) / interval) *(1000 / (2*1.4823));
   show "tau^prime(x) = " ;
   show (abs((spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1) - o) / interval)/2;
   show (abs((spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1) - o) / interval) *(1000 / (2*1.4823));
   show "tau^prime(x^\prime) = ";
   show (abs(timeDPrime1 - o) / interval)/2 ;
   show (abs(timeDPrime1 - o) / interval) *(1000 / (2*1.4823));
   
   show "tau^+ = ";
   show (abs(timePrime2 - o)/ interval) /2;
   show (abs(timePrime2 - o)/ interval) *(1000 / (2*1.4823));
   show "tau^prime+ = " ;
   show (abs(timeDPrime2 - o) / interval)/2 ;
   show (abs(timeDPrime2 - o) / interval) *(1000 / (2*1.4823));
   show "k^2= ";
   show (abs(projTimeDPrime1 - o) / interval)/(abs(time1 - o) / interval);
   show "k^2 prime= ";
   show (abs(timePrime1 - o) / interval)/(abs((spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1) - o) / interval);
   show " ";
   

path bounding[];
bounding0 := (-30u,-5u)--(70u,-5u)--(70u,20u)--(-30u, 20u)--cycle;
bounding1 := (-30,0)--(70u,0u)--(70u,80u)--(-30u, 80u)--cycle;


  
beginfig(0);
  pickup pencircle scaled std_pen_size;

  save trans_height, sound_trans, sound_mirror, midpnt, arrow_pnt;
  
  numeric trans_height;

  pair sound_trans[];
  pair sound_mirror[];
  pair midpnt[];
  pair arrow_pnt[];

  trans_height := 3u;
  
  draw_transducer( o , trans_height  , 6u , 0);
  draw_mirror ( o + (interval,0u) , 10u, 1u, 0);
  
  sound_trans0 = o + (0,trans_height/3 - trans_height/2);
  sound_trans1 = o + (0,2*trans_height/3 - trans_height/2);
  sound_mirror0 = o + (interval,trans_height/3 - trans_height/2);
  sound_mirror1 = o + (interval,2*trans_height/3 - trans_height/2);
  midpnt0 = 1/3[sound_trans0,sound_mirror0];
  midpnt1 = 2/3[sound_trans1,sound_mirror1];
  
  arrow_pnt0 = o + (0,-trans_height/3 - trans_height/2 - 5u);
  arrow_pnt1 = o + (interval,-trans_height/3 - trans_height/2 - 5u);
  
  drawarrow sound_trans0--midpnt0 withcolor red;
  draw midpnt0--sound_mirror0 withcolor red;
  drawarrow sound_mirror1 -- midpnt1 withcolor red;
  draw midpnt1--sound_trans1 withcolor red;
  
  drawdblarrow arrow_pnt0--arrow_pnt1;
  
  label.ulft(btex transducer etex, o +(-6u,trans_height ) ); % 1/2[o, ( o + (0, 2.0*interval))] );
  label.urt(btex reflector etex, ( o + (interval+1u, 5u) ) );
  label.bot(btex $\tfrac{1}{2}\metre$ etex, 1/2[arrow_pnt0,arrow_pnt1]);
  
  setbounds currentpicture to bounding0;
 % clip currentpicture to bounding0;
endfig;


beginfig(1);
  pickup pencircle scaled std_pen_size;

  save trans_height,   sound_trans, sound_mirror, midpnt, vel, arrow_pnt;
  
  numeric trans_height;

  pair sound_trans[];
  pair sound_mirror[];
  pair midpnt[];
  pair arrow_pnt[];
  pair vel[];

  trans_height := 3u;
  
  draw_transducer( o , trans_height  , 6u, 0.5 );
  draw_transducer( o+ (shear,0u) , trans_height  , 6u, 0 );
  draw_mirror ( o + (interval,0u) , 10u, 1u, 0.5);
  draw_mirror ( o + (interval+shear,0u) , 10u, 1u, 0);
  
  
  sound_trans0 = o + (0,trans_height/3 - trans_height/2);
  sound_trans1 = o + (shear,2*trans_height/3 - trans_height/2);
  sound_mirror0 = o + (interval+shear,trans_height/3 - trans_height/2);
  sound_mirror1 = o + (interval+shear,2*trans_height/3 - trans_height/2);
  midpnt0 = 1/2[sound_trans0,sound_mirror0];
  midpnt1 = 1/2[sound_trans1,sound_mirror1];
  
  
  arrow_pnt0 = o + (shear,-trans_height/3 - trans_height/2 - 5u);
  arrow_pnt1 = o + (shear+interval,-trans_height/3 - trans_height/2 - 5u);
  
  drawarrow sound_trans0--midpnt0 withcolor red;
  draw midpnt0--sound_mirror0 withcolor red;
  drawarrow sound_mirror1 -- midpnt1 withcolor red;
  draw midpnt1--sound_trans1 withcolor red;

  
  drawdblarrow arrow_pnt0--arrow_pnt1;

  
  vel0 = o + (shear/interval , 7u );
  vel1 = o + (shear/interval + shear , 7u );
  draw vel0;
  draw vel1;
  
  drawarrow vel0--vel1;
  label.top(btex $v$ etex, (1/2[vel0,vel1] ));

  label.ulft(btex transducer etex, o +(-6u,trans_height ) ); % 1/2[o, ( o + (0, 2.0*interval))] );
  label.urt(btex reflector etex, ( o + (interval+1u+shear, 5u) ) );
  label.bot(btex $\tfrac{1}{2}\metre$ etex, 1/2[arrow_pnt0,arrow_pnt1]);
  
  setbounds currentpicture to bounding0;
  %clip currentpicture to bounding0;
  
endfig;



beginfig(2);
  pickup pencircle scaled std_pen_size;
  
  save lp;  path lp;
  
  
  draw_axis( (o + (-25u, 2*interval-10u)),10u, 10u, 1);
  
  lp = light_out_first_path(obs0,obj0, point 0 of obs0);
  draw extend_path_by(obs0, 1.1);
  draw extend_path_by(obj0, 1.1);
  draw lp withcolor red;
  
  
  label.rt(btex $x$ etex, pnt1 );
  label.lft(btex $\tau^-$ etex, o );
  label.lft(btex $\tau^+$ etex, (o+(0,2*interval)) );

  label.urt(btex transducer etex,( o + (0,2.2*interval)) ); % 1/2[o, ( o + (0, 2.0*interval))] );
  label.urt(btex reflector etex, ( o + (interval,2.0*interval)) );

  label.top(btex $\rho(x) = \tfrac{1}{2}\metre$ etex, 1/2[time1,pnt1] );
  label.lft(btex $\tau(x)$ etex, time1 );
  draw time1--pnt1 withcolor blue;
  
  
  
  pickup pencircle scaled 2pt;
  draw time1; draw time0; draw time2;
  
  pickup pencircle scaled std_pen_size;

  setbounds currentpicture to bounding1;
  %clip currentpicture to bounding1;

endfig;

beginfig(3);

  
   pickup pencircle scaled std_pen_size;
  
   save   lp;
   path lp;
   
   draw_axis( (o + (-20u, 2*interval-10u)),10u, 10u, 1);
  
   pickup pencircle scaled 1pt;
   draw extend_path_by(obs0, 1.1) dashed withdots scaled 0.25;
   pickup pencircle scaled std_pen_size;
   draw extend_path_by(obs1, 1.1);
   draw extend_path_by(obj1, 1.1);
   
   lp = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp withcolor red;
   

   pickup pencircle scaled 1pt;
   draw projTimePrime2 -- timePrime2 dashed withdots scaled 0.25;
   draw time2 -- 1/2[time2, (xpart(timePrime2), ypart(time2))]  dashed withdots scaled 0.25;

   draw projTimePrime1 -- timePrime1 dashed withdots scaled 0.25;
   draw time1 -- 1/2[time1, (xpart(timePrime1), ypart(time1))]  dashed withdots scaled 0.25;
   pickup pencircle scaled std_pen_size;
     
%    save ahlength;
%    numeric ahlength;
%    ahlength = 1.5bp; % usually 4
    drawdblarrow 1/2[projTimePrime2,timePrime2] -- 1/2[time2,(xpart(timePrime2), ypart(time2))]  ;
   
   
    drawdblarrow 1/2[projTimePrime1,timePrime1] -- 1/2[time1,(xpart(timePrime1), ypart(time1))]  ;
   

   label.rt(btex $x^\prime$ etex, pntPrime1 );
   label.llft(btex $\tau^{\prime-}$ etex, time0  );
   label.ulft(btex $\tau^{\prime+}$ etex,projTimePrime2  ) ;
   label.llft(btex $\tau^{+}$ etex,time2  ) ;

   label.urt(btex transducer etex, point 0.97 of (extend_path_by(obs1, 1.1))); 
   label.urt(btex ruler etex,  point 0.9 of  extend_path_by(obj1, 1.1)); 
    %clip currentpicture to bounding1;
   
   label.top(btex $\tfrac{1}{2}\metre$ etex, 1/2[projXPrime1,pntPrime1] );
   drawdblarrow projXPrime1--pntPrime1;
    
   label.bot(btex $\rho(x^\prime)$ etex, 1/2[timePrime1,pntPrime1] );
   drawdblarrow timePrime1--pntPrime1;
 
   
   label.ulft(btex $\tau^\prime(x^\prime)$ etex, projTimePrime1 );
   label.llft(btex $\tau(x)$ etex, time1 );
   

   pickup pencircle scaled 2pt;
   draw projTimePrime1;
   draw time1;
   pickup pencircle scaled std_pen_size;

   
   setbounds currentpicture to bounding1;
 endfig;


beginfig(4);

  
   pickup pencircle scaled std_pen_size;
  
   save bleach;
   numeric bleach;
   bleach = 0.85;
   
   save lp;
   path lp[];
   
  draw_axis( (o + (-25u, 2*interval-10u)),10u, 10u, 1);
  
  
   draw extend_path_by(obs0, 1.15) withcolor bleach*white; % dashed withdots scaled 0.25;
   draw extend_path_by(obj0, 1.15) withcolor bleach*white;
   
   
   lp0 = light_out_first_path(obs0,obj0, point 0 of obs1);
   draw lp0 withcolor bleach[red,  (1,1,1)] ;
   draw time1--pnt1 withcolor  bleach[blue,  (1,1,1)] ;

   
   draw extend_path_by(obs1, 1.2);
   draw extend_path_by(obj1, 1.2);

   draw extend_path_by(obs2, 1.15);
   draw extend_path_by(obj2, 1.15);
   lp1 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp1 withcolor red;
   lp2 = light_out_first_path(obs2,obj2, point 0 of obs2);
   draw lp2 withcolor red;

   
 
   label.rt(btex $x^\prime$ etex, pntPrime1 );
   label.rt(btex $x$ etex, pntDPrime1 );
   label.lft(btex $\tau^{-} = \tau^{\prime-}$ etex, time0  );
   label.lft(btex $\tau^{\prime+}$ etex,timePrime2  ) ;
   label.lft(btex $\tau^{+}$ etex,timeDPrime2  ) ;
   
   label.urt(btex $T$ etex, point 1 of extend_path_by(obs2,1.05));
   label.urt(btex $T^\prime$ etex, point 1 of extend_path_by(obs1,1.15));
   label.urt(btex $R$ etex, point 1 of extend_path_by(obj2,1.05));
   label.urt(btex $R^\prime$ etex, point 1 of extend_path_by(obj1,1.15));
   
%   label.ur
   
   label.top(btex transducer paths etex, 1/2[point 1 of extend_path_by(obs0, 1.2),point 1 of extend_path_by(obs1, 1.1) ] ); 
   label.top(btex reflector paths etex, 1/2[ point 1 of extend_path_by(obj0, 1.2),point 1 of extend_path_by(obj1, 1.1) ]); 
 
   label.urt(btex $\tau^\prime(x^\prime)$ etex rotated
     angle_between(spatial(obs1,obj1, o ), horizontal(o))
     , 0.0[timePrime1,pntPrime1] );
   draw timePrime1--pntPrime1 withcolor blue;
 
   label.llft(btex $\tau(x)$ etex, timeDPrime1  );  %1/2[timeDPrime1,pntDPrime1]
   draw timeDPrime1--pntDPrime1 withcolor blue;

   

   label.ulft(btex $\tau(\tau^\prime(x^\prime)) = k^2\tau(x)$ etex,projTimeDPrime1); %1/2[projTimeDPrime1,timePrime1] );
   
   pickup pencircle scaled 1pt;
   draw projTimeDPrime1--timePrime1 dashed withdots scaled 0.25;
   pickup pencircle scaled std_pen_size;
   %label.rt(btex $\Delta$ etex,1/10[projTimeDPrime1+(1mm,0),timeDPrime1+(1mm,0)]); %1/2[projTimeDPrime1,timePrime1] );
   %drawdblarrow arcspatialproject(projTimeDPrime1--timeDPrime1,2.6mm, obs2, obj2  );
   
   
   pickup pencircle scaled 2pt;
   draw projTimeDPrime1;
   draw timeDPrime1;
   draw timePrime1;
   %draw (obs1 intersectionpoint (timeDPrime1--pntDPrime1));
   %draw time1;
   pickup pencircle scaled std_pen_size;

   
   setbounds currentpicture to bounding1;
 endfig;

beginfig(5);

  
   pickup pencircle scaled std_pen_size;
  
   save bleach;
   numeric bleach;
   bleach = 0.85;
   
   save lp;
   path lp[];
   
  draw_axis( (o + (-25u, 2*interval-10u)),10u, 10u, 1);
  

  
   draw extend_path_by(obs0, 1.15) withcolor bleach*white; % dashed withdots scaled 0.25;
   draw extend_path_by(obj0, 1.15) withcolor bleach*white;
   
   
   lp0 = light_out_first_path(obs0,obj0, point 0 of obs1);
   draw lp0 withcolor bleach[red,  (1,1,1)] ;
   draw time1--pnt1 withcolor  bleach[blue,  (1,1,1)] ;

   
   draw extend_path_by(obs1, 1.2);
   draw extend_path_by(obj1, 1.2);

   draw extend_path_by(obs2, 1.15);
   draw extend_path_by(obj2, 1.15);
   lp1 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp1 withcolor red;
   lp2 = light_out_first_path(obs2,obj2, point 0 of obs2);
   draw lp2 withcolor red;

 
   label.rt(btex $x^\prime$ etex, pntPrime1 );
   label.rt(btex $x$ etex, pntDPrime1 );
   label.lft(btex $\tau^{-} = \tau^{\prime-}$ etex, time0  );
   label.lft(btex $\tau^{\prime+}$ etex,timePrime2  ) ;
   label.lft(btex $\tau^{+}$ etex,timeDPrime2  ) ;
   

   label.urt(btex $T$ etex, point 1 of extend_path_by(obs2,1.05));
   label.urt(btex $T^\prime$ etex, point 1 of extend_path_by(obs1,1.15));
   label.urt(btex $R$ etex, point 1 of extend_path_by(obj2,1.05));
   label.urt(btex $R^\prime$ etex, point 1 of extend_path_by(obj1,1.15));
   

   
   label.top(btex transducer paths etex, 1/2[point 1 of extend_path_by(obs0, 1.2),point 1 of extend_path_by(obs1, 1.1) ] ); 
   label.top(btex reflector paths etex, 1/2[ point 1 of extend_path_by(obj0, 1.2),point 1 of extend_path_by(obj1, 1.1) ]); 
 
   label.urt(btex $\tau^\prime(x^\prime)$ etex rotated
     angle_between(spatial(obs1,obj1, o ), horizontal(o))
     , 0.0[timePrime1,pntPrime1] );
   draw timePrime1--pntPrime1 withcolor blue;
 
   label.llft(btex $\tau(x)$ etex, timeDPrime1);
   draw timeDPrime1--pntDPrime1 withcolor blue;

   

   pickup pencircle scaled 1pt;
   label.ulft(btex $k^2\tau(x)$ etex,projTimeDPrime1); %1/2[projTimeDPrime1,timePrime1] );
   draw projTimeDPrime1--timePrime1 dashed withdots scaled 0.25 ;
   draw o -- (spatial(obs1, obj1, o) intersectionpoint obj1) dashed evenly;
   
   
   %draw projTimeDPrime1--timePrime1 dashed withdots scaled 0.25; % withcolor bleach * white;
   
   %label.rt(btex $\Delta$ etex,1/10[projTimeDPrime1+(1mm,0),timeDPrime1+(1mm,0)]); %1/2[projTimeDPrime1,timePrime1] );
   %drawdblarrow arcspatialproject(projTimeDPrime1--timeDPrime1,2.6mm, obs2, obj2  );

   save sqrtPnt;
   pair sqrtPnt[];
   sqrtPnt0 = sqrt_path(pntPrime0--projTimeDPrime1, timeDPrime1);
   sqrtPnt1 = sqrt_path( (pntPrime0--timePrime1) , (obs1 intersectionpoint (timeDPrime1--pntDPrime1) )) ;
   sqrtPnt2 = spatial(obs2, obj2,sqrtPnt1 ) intersectionpoint light_out(time0) ;
   sqrtPnt3 = spatial(obs2, obj2,point 0 of obs2) intersectionpoint timelike(obs2, sqrtPnt2);
   sqrtPnt4 = extend_path(obs2) intersectionpoint spatial(obs2, obj2, sqrtPnt3);
   %draw_hyperbola(0.5, time1);
  
 %    draw_hyperbola(3.14, time1 );
   
   pickup pencircle scaled 1pt;
   draw sqrtPnt0 -- sqrtPnt2 dashed withdots scaled 0.25 ;
   draw sqrtPnt2 -- sqrtPnt3 dashed withdots scaled 0.25 ;
   draw sqrtPnt3 -- sqrtPnt4 dashed withdots scaled 0.25 ;
   draw o -- (spatial(obs1, obj1, o) intersectionpoint obj1) dashed evenly;
    
   pickup pencircle scaled std_pen_size;

   %label.lft(btex $k\tau(x)$ etex,sqrtPnt0);

   
   pickup pencircle scaled 2pt;
   draw projTimeDPrime1; % withcolor bleach*white;
   draw timeDPrime1; % withcolor bleach*white;
   draw timePrime1; % withcolor bleach*white;

  %  draw sqrtPnt0;
   pickup pencircle scaled std_pen_size;

   draw_geometry(pi/2,    obs2, interval );
   draw_geometry_horizontal(pi/2,  obs2, interval );
   
  % pickup pencircle scaled 2pt;
   %draw projTimeDPrime1;
   %draw timeDPrime1;
 
 %  draw sqrtPnt1;
 % draw sqrtPnt2;
   
   
   
%(abs(timePrime1)/ ((abs(obs1 intersection_point (timeDPrime1--pntDPrime1) ) )--pnt0))
   
%draw (obs1 intersectionpoint (timeDPrime1--pntDPrime1));
   %draw time1;
%   pickup pencircle scaled std_pen_size;

   
   setbounds currentpicture to bounding1;
  clip currentpicture to bounding1;
   
 endfig;

beginfig(6);

  
   pickup pencircle scaled std_pen_size;
  
   save bleach;
   numeric bleach;
   bleach = 0.85;
   
   save lp;
   path lp[];
   
  %draw_axis( (o + (-25u, 2*interval-10u)),10u, 10u, 1);
  
 
   draw extend_path_by(obs0, 1.15) withcolor bleach*white; % dashed withdots scaled 0.25;
   draw extend_path_by(obj0, 1.15) withcolor bleach*white;
   
   
   lp0 = light_out_first_path(obs0,obj0, point 0 of obs1);
   draw lp0 withcolor bleach[red,  (1,1,1)] ;
   draw time1--pnt1 withcolor  bleach[blue,  (1,1,1)] ;

   
   draw extend_path_by(obs1, 1.2);
   draw extend_path_by(obj1, 1.2);

   draw extend_path_by(obs0, 1.15);
   draw extend_path_by(obj0, 1.15);
   lp1 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp1 withcolor red;
   lp2 = light_out_first_path(obs0,obj0, point 0 of obs0);
   draw lp2 withcolor red;

   
 
   label.rt(btex $x^\prime$ etex, pntPrime1 );
   label.rt(btex $x$ etex, pnt1 );
   label.lft(btex $\tau^{-} = \tau^{\prime-}$ etex, time0  );
   label.lft(btex $\tau^{\prime+}$ etex,timePrime2  ) ;
   label.lft(btex $\tau^{+}$ etex,time2  ) ;
   

   label.urt(btex $T$ etex, point 1 of extend_path_by(obs0,1.05));
   label.urt(btex $T^\prime$ etex, point 1 of extend_path_by(obs1,1.15));
   label.urt(btex $R$ etex, point 1 of extend_path_by(obj0,1.05));
   label.urt(btex $R^\prime$ etex, point 1 of extend_path_by(obj1,1.15));
   

   
   label.top(btex transducer paths etex, 1/2[point 1 of extend_path_by(obs0, 1.2),point 1 of extend_path_by(obs1, 1.1) ] ); 
   label.top(btex reflector paths etex, 1/2[ point 1 of extend_path_by(obj0, 1.2),point 1 of extend_path_by(obj1, 1.1) ]); 
 
  
   %draw extend_path_by(obs0, 1.1) withcolor bleach*white; % dashed withdots scaled 0.25;
   %draw extend_path_by(obj0, 1.1) withcolor bleach*white;
   
   
%    lp0 = light_out_first_path(obs0,obj0, point 0 of obs1);
%    draw lp0 withcolor bleach[red,  (1,1,1)] ;
%    draw time1--pnt1 withcolor  bleach[blue,  (1,1,1)] ;

   
%    draw extend_path_by(obs1, 1.1);
%    draw extend_path_by(obj1, 1.1);

%    draw extend_path_by(obs0, 1.1);
%    draw extend_path_by(obj0, 1.1);
%    lp1 = light_out_first_path(obs1,obj1, point 0 of obs1);
%    draw lp1 withcolor red;
%    lp2 = light_out_first_path(obs0,obj0, point 0 of obs2);
%    draw lp2 withcolor red;

   
 
%    label.rt(btex $x^\prime$ etex, pntPrime1 );
%    label.rt(btex $x$ etex, pnt1 );
%    label.lft(btex $\tau^{-} = \tau^{\prime-}$ etex, time0  );
%    label.lft(btex $\tau^{\prime+}$ etex,timePrime2  ) ;
%    label.lft(btex $\tau^{+}$ etex,time2  ) ;
   

%    label.urt(btex $T$ etex, point 1 of extend_path_by(obs0,1.05));
%    label.urt(btex $T^\prime$ etex, point 1 of extend_path_by(obs1,1.05));
%    label.urt(btex $R$ etex, point 1 of extend_path_by(obj0,1.05));
%    label.urt(btex $R^\prime$ etex, point 1 of extend_path_by(obj1,1.05));
   

   
%    label.top(btex transducer paths etex, 1/2[point 1 of extend_path_by(obs0, 1.1),point 1 of extend_path_by(obs1, 1.1) ] ); 
%    label.top(btex reflector paths etex, 1/2[ point 1 of extend_path_by(obj0, 1.1),point 1 of extend_path_by(obj1, 1.1) ]);

   
 
   label.urt(btex $\tau^\prime(x^\prime)$ etex rotated
     angle_between(spatial(obs1,obj1, o ), horizontal(o))
     , 0.0[timePrime1,pntPrime1] );
   draw timePrime1--pntPrime1 withcolor blue;
 
   label.llft(btex $\tau(x)$ etex, time1);
   draw timePrime1--pntPrime1 withcolor blue;

   

   pickup pencircle scaled 1pt;
   label.ulft(btex $k^2\tau(x)$ etex,projTimePrime1); %1/2[projTimePrime1,timePrime1] );
   draw projTimePrime1--timePrime1 dashed withdots scaled 0.25 ;
   
   pickup pencircle scaled std_pen_size;
   
   save sqrtPnt;
   pair sqrtPnt[];
   sqrtPnt0 = sqrt_path(pntPrime0--projTimePrime1, time1);
   sqrtPnt1 = sqrt_path( (pntPrime0--timePrime1) , (obs1 intersectionpoint (time1--pnt1) )) ;
   sqrtPnt2 = spatial(obs0, obj0,sqrtPnt1 ) intersectionpoint light_out(time0) ;
   sqrtPnt3 = spatial(obs0, obj0,point 0 of obs0) intersectionpoint timelike(obs0, sqrtPnt2);
   sqrtPnt4 = extend_path(obs0) intersectionpoint spatial(obs0, obj0, sqrtPnt3);
   
   
   pickup pencircle scaled 1pt;
   draw sqrtPnt0 -- sqrtPnt2 dashed withdots scaled 0.25 ;
   draw sqrtPnt2 -- sqrtPnt3 dashed withdots scaled 0.25 ;
   draw sqrtPnt3 -- sqrtPnt4 dashed withdots scaled 0.25 ;
   pickup pencircle scaled std_pen_size;
   draw o -- (spatial(obs1, obj1, o) intersectionpoint obj1) dashed evenly;
    

   pickup pencircle scaled 2pt;
   draw projTimePrime1; % withcolor bleach*white;
   draw time1; % withcolor bleach*white;
   draw timePrime1; % withcolor bleach*white;

   pickup pencircle scaled std_pen_size;

   draw_geometry(pi/2,  obs0, interval );
   draw_geometry_horizontal(pi/2,   obs0, interval );
   
    setbounds currentpicture to bounding1;
  clip currentpicture to bounding1;
   
 endfig;

beginfig(7);

  
   pickup pencircle scaled std_pen_size;
  
   save bleach;
   numeric bleach;
   bleach = 0.85;
   
   save lp;
   path lp[];
   
  draw_axis( (o + (-25u, 2*interval-10u)),10u, 10u, 1);
  

  
   draw extend_path_by(obs0, 1.15) withcolor bleach*white; % dashed withdots scaled 0.25;
   draw extend_path_by(obj0, 1.15) withcolor bleach*white;
   
   
   lp0 = light_out_first_path(obs2,obj2, point 0 of obs1);
   draw lp0 withcolor bleach[red,  (1,1,1)] ;
   draw time1--pnt1 withcolor  bleach[blue,  (1,1,1)] ;

   
   draw extend_path_by(obs1, 1.2);
   draw extend_path_by(obj1, 1.2);

   draw extend_path_by(obs2, 1.15);
   draw extend_path_by(obj2, 1.15);
   lp1 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp1 withcolor red;
   lp2 = light_out_first_path(obs2,obj2, point 0 of obs2);
   draw lp2 withcolor red;

   
 
   label.rt(btex $x^\prime$ etex, pntPrime1 );
   label.rt(btex $x$ etex, pnt1 );
   label.lft(btex $\tau^{-} = \tau^{\prime-}$ etex, time0  );
   label.lft(btex $\tau^{\prime+}$ etex,timePrime2  ) ;
   label.lft(btex $\tau^{+}$ etex,timeDPrime2  ) ;
   

   label.urt(btex $T$ etex, point 1 of extend_path_by(obs2,1.05));
   label.urt(btex $T^\prime$ etex, point 1 of extend_path_by(obs1,1.15));
   label.urt(btex $R$ etex, point 1 of extend_path_by(obj2,1.05));
   label.urt(btex $R^\prime$ etex, point 1 of extend_path_by(obj1,1.15));
   

   
   label.top(btex transducer paths etex, 1/2[point 1 of extend_path_by(obs0, 1.2),point 1 of extend_path_by(obs1, 1.1) ] ); 
   label.top(btex reflector paths etex, 1/2[ point 1 of extend_path_by(obj0, 1.2),point 1 of extend_path_by(obj1, 1.1) ]); 
   

   label.urt(btex $\tau^\prime(x^\prime) = k^{\prime 2} \tau^\prime(x)$ etex rotated
     angle_between(spatial(obs1,obj1, o ), horizontal(o))
     , 0.0[timePrime1,pntPrime1] );
   draw timePrime1--pntPrime1 withcolor blue;
   
   label.llft(btex $\tau(x)$ etex, timeDPrime1);
   draw timeDPrime1--pntDPrime1 withcolor blue;

   

  % label.ulft(btex $k^2\tau(x)$ etex,projTimeDRPrime1); %1/2[projTimePrime1,timePrime1] );
   %draw projTimeDRPrime1--timePrime1 dashed withdots scaled 0.25 ;
   
   draw timeDPrime1 -- (spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1) dashed withdots scaled 0.25 ;
   
   label.lrt(btex $\tau^\prime(x) $ etex
%     rotated angle_between(spatial(obs1,obj1, o ), horizontal(o))
     , (spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1));
   draw timePrime1--pntPrime1 withcolor blue;
   
   save sqrtPnt;
   pair sqrtPnt[];
   sqrtPnt0 = sqrt_path(pntPrime0--projTimeDRPrime1, timeDPrime1);
  % sqrtPnt1 = sqrt_path( (pntPrime0--timePrime1) , (obs1 intersectionpoint (timeDRPrime1--pntDRPrime1) )) ;
   sqrtPnt2 = spatial(obs1, obj1,sqrtPnt0 ) intersectionpoint light_out(time0) ;
   sqrtPnt3 = spatial(obs1, obj1,point 0 of obs2) intersectionpoint timelike(obs1, sqrtPnt2);
   sqrtPnt4 = extend_path(obs2) intersectionpoint spatial(obs1, obj1, sqrtPnt3);
   
   
   draw sqrtPnt0 -- sqrtPnt2 dashed withdots scaled 0.25 ;
   draw sqrtPnt2 -- sqrtPnt3 dashed withdots scaled 0.25 ;
   draw sqrtPnt3 -- sqrtPnt4 dashed withdots scaled 0.25 ;
  % draw o -- (spatial(obs2, obj2, o) intersectionpoint obj2) dashed evenly;
    

   pickup pencircle scaled 2pt;
   %draw projTimePrime1; % withcolor bleach*white;
   draw timeDPrime1; % withcolor bleach*white;
   draw timePrime1; % withcolor bleach*white;
   draw (spatial(obs1,obj1,timeDPrime1) intersectionpoint obs1);
   
   pickup pencircle scaled std_pen_size;

   draw_geometry(pi/2,  obs1, interval );
   draw_geometry_horizontal(pi/2,   obs1, interval );
   
    setbounds currentpicture to bounding1;
  clip currentpicture to bounding1;
   
 endfig;

beginfig(10);

  
   pickup pencircle scaled std_pen_size;
  
   save lp;
   path lp[];
   
   save bleach;
   numeric bleach;
   bleach = 0.7;
   
   draw_axis( (o + (-20u, 2*interval-10u)),10u, 10u, 1);
   

   draw extend_path_by(obs0, 1.1) dashed withdots scaled 0.25 withcolor bleach*white;
   draw extend_path_by(obs1, 1.1); % withcolor bleach*white;
   draw extend_path_by(obj1, 1.1); % withcolor bleach*white;
   
   lp0 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp0 withcolor bleach[red,  (1,1,1)] ;
   
   pickup pencircle scaled 2pt;
   draw pnt2 withcolor bleach*white;
   draw timePrime0 withcolor bleach*white;
   draw timePrime2 withcolor bleach*white;
   pickup pencircle scaled std_pen_size;
   
   draw pntPrime2 -- (xpart(pnt2), ypart(pntPrime2))  dashed withdots scaled 0.25 withcolor bleach*white;
   draw time2 -- 1/2[time2,(xpart(pntPrime2), ypart(pnt2))]  dashed withdots scaled 0.25 withcolor bleach*white;
   


   
  

   draw projTimePrime2 -- timePrime2 dashed withdots scaled 0.25 withcolor bleach*white;
   draw time2 -- 1/2[time2, (xpart(timePrime2), ypart(time2))]  dashed withdots scaled 0.25 withcolor bleach*white;

   draw projTimePrime1 -- timePrime1 dashed withdots scaled 0.25 withcolor bleach*white;
   draw time1 -- 1/2[time1, (xpart(timePrime1), ypart(time1))]  dashed withdots scaled 0.25 withcolor bleach*white;
     
%    save ahlength;
%    numeric ahlength;
 %   ahlength = 1.5bp; % usually 4
    drawdblarrow 1/2[projTimePrime2,timePrime2] -- 1/2[time2,(xpart(timePrime2), ypart(time2))] withcolor bleach*white  ;
   
   
    drawdblarrow 1/2[projTimePrime1,timePrime1] -- 1/2[time1,(xpart(timePrime1), ypart(time1))] withcolor bleach*white  ;
  

   label.urt(btex transducer etex, point 0.97 of (extend_path_by(obs1, 1.1))); 
   label.urt(btex ruler etex,  point 0.9 of  extend_path_by(obj1, 1.1)); 

  % label.top(btex $\tfrac{1}{2}\metre$ etex, 1/2[projXPrime1,pntPrime1] );
   drawdblarrow projXPrime1--pntPrime1 withcolor bleach*white;;
    
  % label.bot(btex $\rho(x^\prime)$ etex, 1/2[timePrime1,pntPrime1] );
   drawdblarrow timePrime1--pntPrime1 withcolor bleach*white;;
 
   
   %label.ulft(btex $\tau(x^\prime)$ etex, projTimePrime1 );
  % label.llft(btex $\tau(x)$ etex, time1 );
   

   pickup pencircle scaled 2pt;
   draw projTimePrime1 withcolor bleach*white;
   draw time1 withcolor bleach*white;
   pickup pencircle scaled std_pen_size;

   
    save k, time_zero_length;
    numeric k[], time_zero_length;
   

   
    save kPoint,kPointPrime;
    pair kPoint[], kPointPrime[];
    
    kPoint2 = light_ret_intp(obs0, projTimePrime1 );  %obs1 intersectionpoint horizontal(timePrime1)
    kPoint1 = light_ret_intp(obs1, projTimePrime1);
    kPoint0 = light_out_intp(obs0, kPoint1);

    %kPoint2 = light_ret_intp(obs0, time0);
    %kPoint1 = light_ret_intp(obs1, time0);
    %kPoint0 = light_out_intp(obs0, kPoint1);
    
    save kTime, kTimePrime; pair kTime[], kTimePrime[];
    kTime1  = extend_path(obs0) intersectionpoint spatial(obs0,obs1, kPoint1);
    
    %k = (abs(kPoint1- time0)/ abs(time1 - time0));
    k0 = sqrt(abs(projTimePrime1- time0)/ abs(time1 - time0));
    %show "k0 = ";
    %show k0;
    k1 = sqrt(abs(timePrime1- time0)/ abs((obs1 intersectionpoint horizontal(time1)) - time0));
    %show "k1 = ";
    %show k1;
    
 %   kPoint0  = obs_intp_one_rec(obs0, obs1, tau_x,  1,0,0);
 %   kPoint1 = obj_intp_rec(obs0,obs1 ,tau_x ,  1, 0, 0);
 %   kPoint2 = obs_intp_two_rec(obs0,obs1 ,tau_x ,  1, 0, 0);

%    save mPoint;
%    pair mPoint[];
%    k  = sqrt( abs(time1 - time0)/abs(kPoint1- time0) );
   
%    time10 = obs0 intersectionpoint parallel(kPoint1, time1, pntPrime1);
    kTime0 = kPoint0;
    kTime1 = extend_path(obs0) intersectionpoint spatial(obs0,obs1, kPoint1);
    kTime2 = kPoint2;

    kPointPrime0 = point 1 of extend_by(time0,kPoint0,1/k0);
    kPointPrime1 = point 1 of extend_by(time0,kPoint1,1/k0);
    kPointPrime2 = point 1 of extend_by(time0,kPoint2,1/k0);

    kTimePrime0 = kPointPrime0;
    kTimePrime1 = extend_path(obs0) intersectionpoint spatial(obs0,obs1,kPointPrime1 );
    kTimePrime2 = kPointPrime2;
    
    lp1=light_ret_second_path(obs0, obs1, projTimePrime1);
    lp2=light_ret_second_path(obs0, obs1,kPointPrime1 );
    
    lp3=light_ret_first_path(obs0, obs1,obs1 intersectionpoint spatial(obs1,obj1,kPoint1 )); %kPointPrime1
    %lp1=light_ret_second_path(obs0, obs1,timePrime1);
    draw lp1 withcolor  bleach[red,  (1,1,1)] ;
    draw lp3 withcolor red;
    
    %kPrime1 = obs1 intersectionpoint spatial(obs0,obs1, kTimePrime0)
    %kTimePrime1 = obs1 intersectionpoint spatial(obs0,obs1, kTimePrime0)

 
    %label.rt(btex $x^\prime$ etex, pntPrime1 );
    label.lft(btex $\tau^{-}$ etex, kTime0  );
    %abel.lft(btex $\tau^\prime({\tfrac{1}{2}})$ etex, kTime1 ) ;
    %label.lft(btex $\tau^{+}$ etex,kTime2  ) ;

    save pntLabel, pntLabelPrime;
    pair pntLabel[],pntLabelPrime[];

    pntLabel0 = (time0) -(10u,0);    
    pntLabel1 = (projTimePrime1) -(10u,0);
    %label.lft(btex $k^2 \tau^{-}$  etex rotated 90, 1/2[pntLabel0,pntLabel1]);
    label.lft(btex $k^2 \tau^{-}$  etex, projTimePrime1);
    pntLabelPrime0 = (time0) ;    
    pntLabelPrime1 = (kPoint1) ;
    
    %drawdblarrow pntLabel0--pntLabel1;
    %drawdblarrow arcproject(pntLabelPrime0--pntLabelPrime1, 3.5mm);
    
    
    %label.lft(btex $k \tau^{-}$  etex rotated (180 + angle(point 0 of obs1 - point 1 of obs1)),
    %  point 0.55 of  arcproject(pntLabelPrime0--pntLabelPrime1, 4.5mm) );
    label.rt(btex $k \tau^{-}$  etex, kPoint1);
      
    label.rt(btex $k\tau^{+}$ etex, light_out_intp(obs1, projTimePrime1) );
     
    label.rt(btex $k\tau$ etex,  1/2[kPoint1, light_out_intp(obs1, projTimePrime1)  ]);
    
    pickup pencircle scaled 2pt;
    draw kPoint2;
    draw kPoint1;
    draw kPoint0;

    %draw timePrime1;
    draw light_out_intp(obs1, projTimePrime1);
    draw  1/2[kPoint1, light_out_intp(obs1, projTimePrime1)]; %  ;kTimePrime1;
    
   pickup pencircle scaled std_pen_size;

    
%    mPoint0 = time0 + k * abs(time10 - time0) * unitvector(kPoint1- time0);
%    %pair test;
%    %test = time0 + k *k *k * abs(kPoint0 - time0) * unitvector(time1- time0);

%    mPoint1 = time0 +  k * abs(time1 - time0) * unitvector(kPoint1- time0);
   
   
%    show  k;
   

%    drawdblarrow time0--kPoint1;
%    label.rt(btex $k\tau^-(x)$ etex, 1/2[ time0, kPoint1 ] );
   
   
%    %k = 0.91;
%    drawdblarrow time0--kPoint0;
%    label.lft(btex $\tau^-(x)$ etex, 1/2[ time0, kPoint0 ] );

%    label.lft(btex $k^2\tau^-(x)$ etex, kPoint2 );

% %show abs((kPoint0- time0));
%    label.lft(btex $\tau(x)$ etex, time1 );
%    %
%    pickup pencircle scaled 2pt;
%    draw time1; 
%    pickup pencircle scaled std_pen_size;
%    %kPoint = (time0+  k*interval*(sind(m_angle), cosd(m_angle)));
%    pickup pencircle scaled 4pt;
%    draw mPoint1 withcolor blue;
%    draw mPoint0 withcolor blue;
%    %draw test withcolor blue;
   
%    pickup pencircle scaled std_pen_size;
%    %drawdblarrow time0--kPoint ; %k*time_zero_length*
%    %label.rt(btex $k\tau(x)$ etex, 1/2[ time0, kPoint]);
  
   




   
   %draw o -- (o + 20u*(sind(m_angle),cosd(m_angle))) withcolor blue;
  
  setbounds currentpicture to bounding1;
    %clip currentpicture to bounding1;
 endfig;



beginfig(11);

  
   pickup pencircle scaled std_pen_size;
  
   save lp;
   path lp[];
   
   save bleach;
   numeric bleach;
   bleach = 0.7;
   
   draw_axis( (o + (-20u, 2*interval-10u)),10u, 10u, 1);
   

   draw extend_path_by(obs0, 1.1) dashed withdots scaled 0.25 withcolor bleach*white;
   draw extend_path_by(obs1, 1.1) withcolor bleach*white;
   draw extend_path_by(obj1, 1.1) withcolor bleach*white;
   
   lp0 = light_out_first_path(obs1,obj1, point 0 of obs1);
   draw lp0 withcolor red;
   
   pickup pencircle scaled 2pt;
   draw pnt2 withcolor bleach*white;
   draw timePrime0 withcolor bleach*white;
   draw timePrime2 withcolor bleach*white;
   pickup pencircle scaled std_pen_size;
   
   draw pntPrime2 -- (xpart(pnt2), ypart(pntPrime2))  dashed withdots scaled 0.25 withcolor bleach*white;
   draw time2 -- 1/2[time2,(xpart(pntPrime2), ypart(pnt2))]  dashed withdots scaled 0.25 withcolor bleach*white;
   


   
  

   draw projTimePrime2 -- timePrime2 dashed withdots scaled 0.25 withcolor bleach*white;
   draw time2 -- 1/2[time2, (xpart(timePrime2), ypart(time2))]  dashed withdots scaled 0.25 withcolor bleach*white;

   draw projTimePrime1 -- timePrime1 dashed withdots scaled 0.25 withcolor bleach*white;
   draw time1 -- 1/2[time1, (xpart(timePrime1), ypart(time1))]  dashed withdots scaled 0.25 withcolor bleach*white;
     
  %  save ahlength;
 %   numeric ahlength;
 %   ahlength = 1.5bp; % usually 4
    drawdblarrow 1/2[projTimePrime2,timePrime2] -- 1/2[time2,(xpart(timePrime2), ypart(time2))] withcolor bleach*white  ;
   
   
    drawdblarrow 1/2[projTimePrime1,timePrime1] -- 1/2[time1,(xpart(timePrime1), ypart(time1))] withcolor bleach*white  ;
   
    label.rt(btex $x^\prime$ etex, pntPrime1 );
    label.llft(btex $\tau^{\prime-}$ etex, time0  );
    label.ulft(btex $\tau^{\prime+}$ etex,projTimePrime2  ) ;
    label.llft(btex $\tau^{+}$ etex,time2  ) ;


   label.urt(btex {transducer} etex, point 0.97 of (extend_path_by(obs1, 1.1))); 
   label.urt(btex ruler etex,  point 0.9 of  extend_path_by(obj1, 1.1)); 

   label.top(btex $\tfrac{1}{2}\metre$ etex, 1/2[projXPrime1,pntPrime1] );
   drawdblarrow projXPrime1--pntPrime1 withcolor bleach*white;;
    
   label.bot(btex $\rho(x^\prime)$ etex, 1/2[timePrime1,pntPrime1] );
   drawdblarrow timePrime1--pntPrime1 withcolor bleach*white;;
 
   
   label.ulft(btex $\tau(x^\prime)$ etex, projTimePrime1 );
   label.llft(btex $\tau(x)$ etex, time1 );
   

   pickup pencircle scaled 2pt;
   draw projTimePrime1 withcolor bleach*white;
   draw time1 withcolor bleach*white;
   pickup pencircle scaled std_pen_size;

   
    save k, time_zero_length;
    numeric k, time_zero_length;
   

   
    save kPoint,kPointPrime;
    pair kPoint[], kPointPrime[];
    
    kPoint2 = light_ret_intp(obs0, obs1 intersectionpoint horizontal(timePrime1));
    kPoint1 = light_ret_intp(obs1, obs1 intersectionpoint horizontal(timePrime1));
    kPoint0 = light_out_intp(obs0, kPoint1);

    %kPoint2 = light_ret_intp(obs0, time0);
    %kPoint1 = light_ret_intp(obs1, time0);
    %kPoint0 = light_out_intp(obs0, kPoint1);
    
    save kTime, kTimePrime; pair kTime[], kTimePrime[];
    kTime1  = extend_path(obs0) intersectionpoint spatial(obs0,obs1, kPoint1);
    
    %k = (abs(kPoint1- time0)/ abs(time1 - time0));
    k = sqrt(abs(projTimePrime1- time0)/ abs(time1 - time0));
   % show k;
   
    
 %   kPoint0  = obs_intp_one_rec(obs0, obs1, tau_x,  1,0,0);
 %   kPoint1 = obj_intp_rec(obs0,obs1 ,tau_x ,  1, 0, 0);
 %   kPoint2 = obs_intp_two_rec(obs0,obs1 ,tau_x ,  1, 0, 0);

%    save mPoint;
%    pair mPoint[];
%    k  = sqrt( abs(time1 - time0)/abs(kPoint1- time0) );
   
%    time10 = obs0 intersectionpoint parallel(kPoint1, time1, pntPrime1);
    kTime0 = kPoint0;
    kTime1 = extend_path(obs0) intersectionpoint spatial(obs0,obs1, kPoint1);
    kTime2 = kPoint2;

    kPointPrime0 = point 1 of extend_by(time0,kPoint0,1/k);
    kPointPrime1 = point 1 of extend_by(time0,kPoint1,1/k);
    kPointPrime2 = point 1 of extend_by(time0,kPoint2,1/k);

    kTimePrime0 = kPointPrime0;
    kTimePrime1 = extend_path(obs0) intersectionpoint spatial(obs0,obs1,kPointPrime1 );
    kTimePrime2 = kPointPrime2;
    
    lp1=light_ret_second_path(obs0, obs1,obs1 intersectionpoint horizontal(timePrime1));
    lp2=light_ret_second_path(obs0, obs1,kPointPrime1 );
    
    lp3=light_ret_first_path(obs0, obs1,obs1 intersectionpoint spatial(obs1,obj1,kPointPrime0 ));
    %lp1=light_ret_second_path(obs0, obs1,timePrime1);
    draw lp1 withcolor red;
    draw lp3 withcolor red;
    
    %kPrime1 = obs1 intersectionpoint spatial(obs0,obs1, kTimePrime0)
    %kTimePrime1 = obs1 intersectionpoint spatial(obs0,obs1, kTimePrime0)
    
    pickup pencircle scaled 2pt;
    draw kPoint2;
    draw kPoint1;
    draw kPoint0;

    draw kPointPrime0;
    draw kPointPrime1;
    draw kPointPrime2;

    %draw kTimePrime1;
    
   pickup pencircle scaled std_pen_size;

    
%    mPoint0 = time0 + k * abs(time10 - time0) * unitvector(kPoint1- time0);
%    %pair test;
%    %test = time0 + k *k *k * abs(kPoint0 - time0) * unitvector(time1- time0);

%    mPoint1 = time0 +  k * abs(time1 - time0) * unitvector(kPoint1- time0);
   
   
%    show  k;
   

%    drawdblarrow time0--kPoint1;
%    label.rt(btex $k\tau^-(x)$ etex, 1/2[ time0, kPoint1 ] );
   
   
%    %k = 0.91;
%    drawdblarrow time0--kPoint0;
%    label.lft(btex $\tau^-(x)$ etex, 1/2[ time0, kPoint0 ] );

%    label.lft(btex $k^2\tau^-(x)$ etex, kPoint2 );

% %show abs((kPoint0- time0));
%    label.lft(btex $\tau(x)$ etex, time1 );
%    %
%    pickup pencircle scaled 2pt;
%    draw time1; 
%    pickup pencircle scaled std_pen_size;
%    %kPoint = (time0+  k*interval*(sind(m_angle), cosd(m_angle)));
%    pickup pencircle scaled 4pt;
%    draw mPoint1 withcolor blue;
%    draw mPoint0 withcolor blue;
%    %draw test withcolor blue;
   
%    pickup pencircle scaled std_pen_size;
%    %drawdblarrow time0--kPoint ; %k*time_zero_length*
%    %label.rt(btex $k\tau(x)$ etex, 1/2[ time0, kPoint]);
  
   




   
   %draw o -- (o + 20u*(sind(m_angle),cosd(m_angle))) withcolor blue;
  
  setbounds currentpicture to bounding1;
    %clip currentpicture to bounding1;
 endfig;


end;