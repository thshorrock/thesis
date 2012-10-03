


%verbatimtex
%\documentclass[6pt]{article}
%\begin{document}
%etex




vardef arcsind primary x = angle((1+-+x,x)) enddef;
vardef arccosd primary x = angle((x,1+-+x)) enddef;

show arcsind(1.0) ;

def make_circ_arc(expr number) =
  begingroup
    show("number = "&decimal(number));
    number
  endgroup
enddef;
def observer(expr at, angle)  =
  begingroup
    save large_length, obs_prim, obs;
    numeric large_length;
    path obs_prim,obs;
    large_length := 100cm;
    
    obs_prim := (at - ( 0,large_length) )--(at + (0, large_length) );
    obs      := obs_prim rotatedaround(at,-angle);
    obs  %return
  endgroup
enddef;


def drawobserver(expr at, rot_angle) =
  begingroup
    save large_length, obs_prim, obs;
    numeric large_length;
    path obs_prim[],obs[];
    large_length := 100cm;
    
    obs_prim1 := (at - ( 0,large_length) )--(at  );
    obs_prim2 := (at  )--(at + (0, large_length) );
    obs1      := obs_prim1 rotatedaround(at,-rot_angle);
    obs2      := obs_prim2 rotatedaround(at,-rot_angle);
    drawarrow obs1;
    draw obs2;
  endgroup
enddef;

def drawspatial(expr from, to, obj) =
  begingroup
    save large_length, axis, midpoint, faraway;
    numeric large_length;
    pair midpoint;
    path axis;
    pair faraway[];
    large_length := 1;
    midpoint = 1/2[from,to];
    faraway1 = large_length*(obj-midpoint) + midpoint ;
    faraway2 = large_length*(-obj+midpoint) + midpoint ;
    axis = midpoint--faraway1 ;
    draw axis dashed withdots scaled 0.2;
  endgroup
enddef;

def light_out(expr at, angle) =
  begingroup
    save large_length, outward_prim,outward;
    numeric large_length;
    path outward_prim,outward;

    large_length := 100cm;
    outward_prim := (at - ( large_length, large_length) )--(at + ( large_length, large_length) );
    outward := outward_prim   rotatedaround(at,angle);
    outward
  endgroup
enddef;

def light_ret(expr at, angle) =
  begingroup
    save large_length,returning,returning_prim;
    numeric large_length;
    path returning,returning_prim ;

    large_length := 100cm;
    returning_prim := (at - ( -large_length, large_length) )--(at + ( -large_length, large_length) );
    returning := returning_prim   rotatedaround(at,angle);
    returning
  endgroup
enddef;

def drawlight(expr at, rot_angle) =
  begingroup
    draw light_out(at,rot_angle)  withcolor blue;
    draw light_ret(at,rot_angle)  withcolor red;
  endgroup
enddef;


def mark_right_angle(expr endofa, common, endofb) =
  begingroup
    save angle_radius, angle_delta, mark_size;
    angle_radius := 4mm;
    angle_delta := 0.5mm;
    mark_size := 2mm;

    save tn; tn := 
    turningnumber(common--endofa--endofb--cycle);
    draw ((1,0)--(1,1)--(0,1)) zscaled(mark_size*unitvector((1+tn)*endofa+(1-tn)*endofb-2*common)) shifted common;
  endgroup
enddef;

def find_local_origin(expr the_point, the_observer, light_out_angle) =
  begingroup
    save out_time, ret_time, the_loc_origin;
    pair out_time, ret_time, the_loc_origin;
    
    %find tMinus
    out_time := light_out(the_point,light_out_angle) intersectionpoint the_observer ;

    %find tPlus
    ret_time := light_ret(the_point,light_out_angle) intersectionpoint the_observer ;

    %find time
    the_loc_origin := 1/2[out_time,ret_time];
    the_loc_origin
  endgroup
enddef;

def metriced_point(expr the_point, the_observer, light_out_angle, rotation_angle) =
  begingroup

    save the_loc_origin, rotated_point;
    pair the_loc_origin, rotated_point;
    the_loc_origin:= find_local_origin( the_point, the_observer, light_out_angle);
    
    %draw the_loc_origin withcolor green;
    
    rotated_point :=(the_point) rotatedabout(the_loc_origin ,(-2*rotation_angle));
    rotated_point
  endgroup
enddef;



def make_circular_arc(expr centre, radius, from, through) =
  %from angle, through angle
  begingroup
    %save arc_prim, arc, circle, points;
    %path arc_prim[], arc;
    %pair points[];
    %circle = fullcircle scaled (2*radius) shifted centre;
    %points1 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,from);
    %points2 = from rotatedabout (centre,through);

    %arc_prim[1] = from..(radius*cosd(1), radius*sind(1));
    %for theta = 2 upto angle:
    %  arc_prim[theta]=  arc_prim[theta-1]..(radius*cosd(theta), radius*sind(theta));
    %endfor
    %arc = arc_prim[angle];
    %arc

  endgroup
enddef;


def drawcircle(expr tm, tp) =
  begingroup
    save r;
    save c; %cenre
    save h,k;
%    save x,y,z;
%    save pellipse;


    pair c; %centre
    c = 1/2[tm,tp];
    numeric r; %radius
    r = abs(tp-c);
    
    numeric h,k;
    h = xpart(c);
    k = ypart(c);
    
   
 %   path pellipse;
    x[0] =  h + r;
    y[0] =  k;
    z[0] = (x[0],y[0]);
    pickup pencircle scaled 0.2pt;
    for theta = 1 upto 360:
      x[theta] = h + r*cosd(theta);
      y[theta] = k + r*sind(theta);
      z[theta] = (x[theta],y[theta]);
      draw z[theta-1]..z[theta];
    endfor
%    pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
  endgroup
enddef;


def drawellipse(expr focus_a, focus_b) =
  begingroup
    save a, b; %semi major semi-minor;
    save c; %cenre
    save phi;  %rotated angle
    save h,k;
    %save x;
    %save z;
    %save y;
%    save pellipse;

    numeric a,b;
    a = abs(focus_a-focus_b) * 0.9;
    b = abs(focus_a-focus_b) * 0.5;

    pair c; %centre
    c = 1/2[focus_a,focus_b];

    numeric h,k;
    h = xpart(c);
    k = ypart(c);
    
    numeric phi;
    phi = arcsind( (ypart(focus_b) - ypart(focus_a)) / (abs(focus_a-focus_b))  );

 %   path pellipse;
    x[0] =  h + a*cosd(phi);
    y[0] =  k + a*sind(phi);
    z[0] = (x[0],y[0]);
    for theta = 1 upto 360:
      x[theta] = h + a*cosd(theta)*cosd(phi) - b*sind(theta) * sind(phi);
      y[theta] = k + b*sind(theta)*cosd(phi) + a*cosd(theta) * sind(phi);
      z[theta] = (x[theta],y[theta]);
      draw z[theta-1]..z[theta];
    endfor
%    pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
  endgroup
enddef;

def drawellipse_light(expr lfocus_a, lfocus_b) =
  begingroup
    save a, b; %semi major semi-minor;
    save c; %cenre
    save phi;  %rotated angle
    save h,k;
    save xl,yl,zl;
%    save pellipse;

    numeric a,b;
    a = abs(lfocus_a-lfocus_b) * 0.9;
    b = abs(lfocus_a-lfocus_b) * 0.5;

    pair c; %centre
    c = 1/2[lfocus_a,lfocus_b];

    numeric h,k;
    h = xpart(c);
    k = ypart(c);
    
    numeric phi;
    phi = arcsind( (ypart(lfocus_b) - ypart(lfocus_a)) / (abs(lfocus_a-lfocus_b))  );
    
    pair zl[];
    
 %   path pellipse;
    xl[0] =  h + a*cosd(phi);
    yl[0] =  k + a*sind(phi);
    zl[0] = (xl[0],yl[0]);
    for theta = 1 upto 360:
      xl[theta] = h + a*cosd(theta)*cosd(phi) - b*sind(theta) * sind(phi);
      yl[theta] = k + b*sind(theta)*cosd(phi) + a*cosd(theta) * sind(phi);
      zl[theta] = (xl[theta],yl[theta]);
      draw zl[theta-1]..zl[theta] withcolor  0.75white ;
    endfor
%    pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
  endgroup
enddef;

def drawellipse_metric(expr lfocus_a, lfocus_b,the_observer, light_out_angle, rotation_angle)  =
  begingroup
    save a, b; %semi major semi-minor;
    save c; %cenre
    save phi;  %rotated angle
    save h,k;
    save xl,yl,zl,zm;
%    save pellipse;

    numeric a,b;
    a = abs(lfocus_a-lfocus_b) * 0.9;
    b = abs(lfocus_a-lfocus_b) * 0.5;

    pair c; %centre
    c = 1/2[lfocus_a,lfocus_b];

    numeric h,k;
    h = xpart(c);
    k = ypart(c);
    
    numeric phi;
    phi = arcsind( (ypart(lfocus_b) - ypart(lfocus_a)) / (abs(lfocus_a-lfocus_b))  );
    
    pair zl[];
    pair zm[];
    
 %   path pellipse;
    xl[0] =  h + a*cosd(phi);
    yl[0] =  k + a*sind(phi);
    zl[0] = (xl[0],yl[0]);
    zm[0] = metriced_point(zl[0],the_observer, light_out_angle, rotation_angle);
    for theta = 1 upto 360:
      xl[theta] = h + a*cosd(theta)*cosd(phi) - b*sind(theta) * sind(phi);
      yl[theta] = k + b*sind(theta)*cosd(phi) + a*cosd(theta) * sind(phi);
      zl[theta] = (xl[theta],yl[theta]);
      %find the rotated point of this.
      zm[theta] = metriced_point(zl[theta],the_observer, light_out_angle, rotation_angle);
      draw zm[theta-1]..zm[theta] ;
    endfor
%    pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
  endgroup
enddef;

def ellipsepoint(expr focus_a, focus_b, the_point) =
  begingroup

    save a, b; %semi major semi-minor;
    save c; %cenre
    save phi;  %rotated angle
    save h,k;
    save pellipse;
    save the_min;

    numeric a,b;
    a = abs(focus_a-focus_b) * 0.9;
    b = abs(focus_a-focus_b) * 0.5;

    pair c; %centre
    c = 1/2[focus_a,focus_b];

    numeric h,k;
    h = xpart(c);
    k = ypart(c);
    
    numeric phi;
    phi = arcsind( (ypart(focus_b) - ypart(focus_a)) / (abs(focus_a-focus_b))  );

    
 %   x[0] =  h + a*cosd(phi);
 %   y[0] =  k + a*sind(phi);
 %   z[0] = (x[0],y[0]);
 %   for theta = 1 upto 360:
 %     x[theta] = h + a*cosd(theta)*cosd(phi) - b*sind(theta) * sind(phi);
 %     y[theta] = k + b*sind(theta)*cosd(phi) + a*cosd(theta) * sind(phi);
 %     z[theta] = (x[theta],y[theta]);
 %     draw z[theta-1]..z[theta];
 %   endfor
    
    path pellipse;
    pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
    
    pair the_min;
    the_min = directionpoint the_point of pellipse;
    the_min %return;
    %numeric xmax = xpart(the_min);
    %xmax;
%    the_min;
    
  endgroup
enddef;


numeric u; %scale
numeric boxSizeX;
numeric boxSizeY;

pair A, B;  %points
numeric Oangle[];


Oangle1 = 15;
Oangle2 = 75;

u = 0.75cm;

A := (3u, 5u) + (0,0);
B := (4u, 7u)+ (0,0);
%B := A + (1.5u, 0);


pair view[];
boxSizeX = 10.5u;
boxSizeY = 10u;
view1 := (-0.75u,0); view2 := (boxSizeX,0); view3 := (boxSizeX,boxSizeY); view4 := (-0.75u,boxSizeY);
path toView;
toView := view1--view2--view3--view4--cycle;

path bounding[];
bboxSizeX = 8u;
bboxSizeY = 10u;
bounding0:= (2u,3.0u)--(5u,3.0u)-- (5u,bboxSizeY)-- (2u,bboxSizeY)--cycle;
bounding1:= (1u,3.0u)--(bboxSizeX,3.0u)-- (bboxSizeX,bboxSizeY)-- (1u,bboxSizeY)--cycle;
bounding2:= (-0.5u,0u)--(6.5u,0u)-- (6.5u,bboxSizeY)-- (-0.5u,bboxSizeY)--cycle;
bounding3:= (-0.5u,2.75u)--(6.5u,2.75u)-- (6.5u,bboxSizeY)-- (-0.5u,bboxSizeY)--cycle;
bounding4:= (-1.5u,0u)--(5.5u,0u)-- (5.5u,bboxSizeY)-- (-1.5u,bboxSizeY)--cycle;
bounding5:= (-1.0u,0u)--(7.5u,0u)-- (7.5u,bboxSizeY)-- (-1.0u,bboxSizeY)--cycle;
bounding6:= (1.0u,0u)--(6.5u,0u)-- (6.5u,bboxSizeY)-- (1.0u,bboxSizeY)--cycle;

beginfig(0);

  drawellipse(A,B);
  
  pickup pencircle scaled 4pt;
  draw A;
  draw B;
  
  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  %draw bounding0;
  setbounds currentpicture to bounding0;
  
endfig;


beginfig(1);
  
  save axisA, axisB;
  save o;
  save c;
  
  pair o; %origin
  o := (0u,0u);
    
  drawellipse(A,B);

  pair axisA[], axisB[], projectATop[], projectABot[], projectBTop[], projectBBot[];;
  axisA[0] = o + (1.25u, 3.5u);
  axisA[1] = o + (1.25u, 8.5u);
  projectATop[0] = o + (1.25u, ypart( ellipsepoint(A,B, ( 1,0) ) ) );
  projectATop[1] = o + ellipsepoint(A,B, ( 1,0) );
  projectABot[0] = o + (1.25u, ypart( ellipsepoint(A,B, (-1,0) ) ) );
  projectABot[1] = o + ellipsepoint(A,B, (-1,0) );

  projectBTop[0] = o + ellipsepoint(A,B, ( 1,1 ))  + 5u*(1,1);
  projectBTop[1] = o + ellipsepoint(A,B, ( 1,1 ));
  projectBBot[0] = o + ellipsepoint(A,B, (-1,-1) ) + 5u*(1,1) ;
  projectBBot[1] = o + ellipsepoint(A,B, (-1,-1) );

  pair c; %centre
  c = 1/2[A,B];
  
  axisB[0] = axisA[0] rotatedabout(c,-135); 
  axisB[1] = axisA[1] rotatedabout(c,-135);

  pair intersectionB[];
%  intersectionBTop = projectBTop[0]--projectBTop[1] intersectionpoint axisB[0]--axisB[1];
  intersectionB[0]  = whatever[ axisB[0], axisB[1] ] = whatever[ projectBTop[0],projectBTop[1]  ];
  intersectionB[1]  = whatever[ axisB[0], axisB[1] ] = whatever[ projectBBot[0],projectBBot[1]  ];
  %numeric the_emax;
  %the_emax = ellipseymax(A,B);
%  ellipseymax(A,B);

  mark_right_angle(axisB[0], intersectionB[0], projectBTop[1]);
  mark_right_angle(axisB[0], intersectionB[1], projectBBot[1]);
  mark_right_angle(axisA[0], projectATop[0],   projectATop[1]);
  mark_right_angle(axisA[0], projectABot[0],   projectABot[1]);
  
  draw axisA[0]--axisA[1] ;
  draw axisB[0]--axisB[1] ;
  
  draw projectATop[0]--projectATop[1] dashed withdots scaled 0.25;
  draw projectABot[0]--projectABot[1] dashed withdots scaled 0.25;
  draw intersectionB[0]--projectBTop[1] dashed withdots scaled 0.25; %intersectionBTop[0]--
  draw intersectionB[1]--projectBBot[1] dashed withdots scaled 0.25;
  
  pickup pencircle scaled 4pt;
  draw A;
  draw B;
  
  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  label.rt(btex Projection 1 etex, axisA[0]);
  label.urt(btex Projection 2 etex, 1/2[axisB[0], axisB[1]] );
  
  %path bounding;
  
  %bboxSizeX = 5u;
  %bboxSizeY = 10u;
  %bounding := (-.5u,0)--(bboxSizeX,0)-- (bboxSizeX,bboxSizeY)-- (-0.50u,bboxSizeY)--cycle;
  %  draw bounding1;
  setbounds currentpicture to bounding1;
endfig;


beginfig(2);

  save rotation, O, obs, o;% tAMinus, tAPlus, tBMinus, tBPlus,
  
  numeric rotation;
  pair O[];  %observer locs
  pair tAMinus[], tAPlus[];
  pair tBMinus[], tBPlus[];
  
  pair o; %origin
  o := (0u,0u);
  
  path obs[];
  
  rotation :=  0;
  %draw light

  drawlight(A,rotation);
  drawlight(B,rotation);
  
  %draw observers
  O1  := (1.25u,2u)   + o;
  O2  := (8u,5u) + o;
  obs1 = observer(O1 ,  Oangle1);
  obs2 = observer(O2 ,  Oangle2);

  drawobserver ( O1,  Oangle1);
  drawobserver ( O2,  Oangle2);
  
  %find tMinus
  tAMinus1 = light_out(A,rotation) intersectionpoint obs1;
  tAMinus2 = light_out(A,rotation) intersectionpoint obs2;
  tBMinus1 = light_out(B,rotation) intersectionpoint obs1;
  tBMinus2 = light_out(B,rotation) intersectionpoint obs2;
  
 %find tPlus
  tAPlus1 =  light_ret(A,rotation) intersectionpoint obs1;
  tAPlus2 =  light_ret(A,rotation) intersectionpoint obs2;
  tBPlus1 =  light_ret(B,rotation) intersectionpoint obs1;
  tBPlus2 =  light_ret(B,rotation) intersectionpoint obs2;

  
%draw dots
  pickup pencircle scaled 4pt;
  draw A;
  draw B;
  for i = 1 upto 2:
    
    pickup pencircle scaled 2pt;
    draw tAMinus[i];
    draw tBMinus[i];
    draw tAPlus[i];
    draw tBPlus[i];
  endfor
  
  
  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  label.rt(btex Observer 1 etex, O1);
  label.lrt(btex Observer 2 etex,O2 );
  
  label.lft(btex $\tau_A^{1-}$ etex, tAMinus1);
  label.lft(btex $\tau_B^{1-}$ etex, tBMinus1);
  label.bot(btex $\tau_A^{2-}$ etex, tAMinus2);
  label.bot(btex $\tau_B^{2-}$ etex, tBMinus2);

  label.lft(btex $\tau_A^{1+}$ etex, tAPlus1);
  label.lft(btex $\tau_B^{1+}$ etex, tBPlus1);
  label.bot(btex $\tau_A^{2+}$ etex, tAPlus2);
  label.bot(btex $\tau_B^{2+}$ etex, tBPlus2);

  
  
  %clip
  clip currentpicture to toView;
  
endfig;

beginfig(3);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[], rB[];
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus1),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tBMinus1+o, Oangle1) + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
  O1  := (xpart(tAMinus1),1u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 rtAMinus1 = light_out(rA1,rotation+Oangle1) intersectionpoint obs1;
 % tAMinus2 = light_out(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBMinus1 = light_out(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs1;
  
 %find tPlus
  rtAPlus1 =  light_ret(rA1,rotation+Oangle1) intersectionpoint obs1;
%  tAPlus2 =  light_ret(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBPlus1 =  light_ret(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs1;
 
%  rtAMinus1  = (o) rotatedabout(tAMinus1, Oangle1);
%  rtBMinus1  = () rotatedabout(tBMinus1, Oangle1);
%  rtAPlus1   = () rotatedabout(tAMinus1, Oangle1);
%  rtBPlus1   = () rotatedabout(tBMinus1, Oangle1);
 
 % rA1 = (A+o) rotatedabout(tAMinus1, Oangle1);
 
%  rB1 =  (B+o ) rotatedabout (tBMinus1, Oangle1)  ; 
 
%draw dots
 

  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;
  arc1    = buildcycle( ( rtAMinus1--(A+o)),circle1,  rA1, light_out(rA1,rotation+Oangle1) );
  %draw circle1;
  clip currentpicture to arc1;

  
%draw light
  drawlight(rA1,rotation+Oangle1);
  drawlight(rB1,rotation+Oangle1);
  drawspatial(rtAMinus1, rtAPlus1, rA1);
  drawspatial(rtBMinus1, rtBPlus1, rB1);
  drawobserver ( O1,  0);

 
  
 pickup pencircle scaled 4pt;
  draw rA1;
  draw rB1;
  pickup pencircle scaled 2pt;
  for i = 1 upto 1:
    draw rtAMinus[i];
    draw rtBMinus[i];
    draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
  label.bot(btex $A$ etex, rA1);
  label.bot(btex $B$ etex, rB1);

  label.rt(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
  label.rt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  label.rt(btex $\tau_B^{1-}$ etex, rtBMinus1);

  label.llft(btex $\tau_A^{1+}$ etex, rtAPlus1);
  label.llft(btex $\tau_B^{1+}$ etex, rtBPlus1);

  
  
  %clip
  clip currentpicture to bounding2;
  
endfig;

beginfig(4);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[], rB[];
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus2),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus2) - xpart(tBMinus2)),  abs(tBMinus2-tAMinus2) - abs(ypart(tAMinus2) - ypart(tBMinus2)) );
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tBMinus2+o, Oangle2) - Btranslation  ;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
  O2  := (xpart(tAMinus2),5.7u)   + o;
  obs2 = observer(O2 ,  0);
  %find tMinus
 rtAMinus2 = light_out(rA2,rotation+Oangle2) intersectionpoint obs2;
 % tAMinus2 = light_out(rA2,rotation+Oangle2) intersectionpoint obs2;
  rtBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs2;
%  tBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs2;
  
 %find tPlus
  rtAPlus2 =  light_ret(rA2,rotation+Oangle2) intersectionpoint obs2;
%  tAPlus2 =  light_ret(rA2,rotation+Oangle2) intersectionpoint obs2;
  rtBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs2;
%  tBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs2;
 
%  rtAMinus2  = (o) rotatedabout(tAMinus2, Oangle2);
%  rtBMinus2  = () rotatedabout(tBMinus2, Oangle2);
%  rtAPlus2   = () rotatedabout(tAMinus2, Oangle2);
%  rtBPlus2   = () rotatedabout(tBMinus2, Oangle2);
 
 % rA2 = (A+o) rotatedabout(tAMinus2, Oangle2);
 
%  rB2 =  (B+o ) rotatedabout (tBMinus2, Oangle2)  ; 
 
%draw dots
 

  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle2 = fullcircle scaled (2*rad2) shifted rtAMinus2;
  %arc2    = buildcycle( ( rtAMinus2--(A+o)),circle2,  rA2, light_out(rA2,rotation+Oangle2) );
  %draw circle2;
 % clip currentpicture to arc2;

  
%draw light
  drawlight(rA2,rotation+Oangle2);
  drawlight(rB2,rotation+Oangle2);
  drawspatial(rtAMinus2, rtAPlus2, rA2);
  drawspatial(rtBMinus2, rtBPlus2, rB2);
  drawobserver ( O2,  0);

 
  
 pickup pencircle scaled 4pt;
  draw rA2;
  draw rB2;
  pickup pencircle scaled 2pt;
  for i = 2 upto 2:
    draw rtAMinus[i];
    draw rtBMinus[i];
    draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
  label.rt(btex $A$ etex, rA2);
  label.rt(btex $B$ etex, rB2);

  label.rt(btex Observer 2 etex, O2);
 % label.bot(btex Observer 2 etex,O2 );
  
  label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  label.rt(btex $\tau_B^{2-}$ etex, rtBMinus2);
%  label.bot(btex $\tau_A^{2-}$ etex, tAMinus2);
%  label.bot(btex $\tau_B^{2-}$ etex, tBMinus2);

  label.ulft(btex $\tau_A^{2+}$ etex, rtAPlus2);
  label.ulft(btex $\tau_B^{2+}$ etex, rtBPlus2);
%  label.bot(btex $\tau_A^{2+}$ etex, tAPlus2);
%  label.bot(btex $\tau_B^{2+}$ etex, tBPlus2);

  
  
  %clip
  clip currentpicture to bounding2;
  
endfig;

beginfig(5);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[], rB[];
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus1),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tBMinus1+o, Oangle1) + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
  O1  := (xpart(tAMinus1),3.5u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 rtAMinus1 = light_out(rA1,rotation+Oangle1) intersectionpoint obs1;
 % tAMinus2 = light_out(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBMinus1 = light_out(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs1;
  
 %find tPlus
  rtAPlus1 =  light_ret(rA1,rotation+Oangle1) intersectionpoint obs1;
%  tAPlus2 =  light_ret(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBPlus1 =  light_ret(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs1;
 
%  rtAMinus1  = (o) rotatedabout(tAMinus1, Oangle1);
%  rtBMinus1  = () rotatedabout(tBMinus1, Oangle1);
%  rtAPlus1   = () rotatedabout(tAMinus1, Oangle1);
%  rtBPlus1   = () rotatedabout(tBMinus1, Oangle1);
 
 % rA1 = (A+o) rotatedabout(tAMinus1, Oangle1);
 
%  rB1 =  (B+o ) rotatedabout (tBMinus1, Oangle1)  ; 
 
%draw dots
 

  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;
  arc1    = buildcycle( ( rtAMinus1--(A+o)),circle1,  rA1, light_out(rA1,rotation+Oangle1) );
  %draw circle1;
  clip currentpicture to arc1;

  
%draw light
 % drawlight(rA1,rotation+Oangle1);
  drawlight(rB1,rotation+Oangle1);
 % drawspatial(rtAMinus1, rtAPlus1, rA1);
  drawspatial(rtBMinus1, rtBPlus1, rB1);
  drawobserver ( O1,  0);

  drawcircle(rtBMinus1,rtBPlus1);
 
  
 pickup pencircle scaled 4pt;
%  draw rA1;
  draw rB1;
  pickup pencircle scaled 2pt;
  for i = 1 upto 1:
 %   draw rtAMinus[i];
    draw rtBMinus[i];
 %   draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
%  label.bot(btex $A$ etex, rA1);
  label.rt(btex $B$ etex, rB1);

  label.rt(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
 % label.rt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  label.lrt(btex $\tau_B^{1-}$ etex, rtBMinus1);

 % label.llft(btex $\tau_A^{1+}$ etex, rtAPlus1);
  label.urt(btex $\tau_B^{1+}$ etex, rtBPlus1);

%  label.lft(btex $0$ etex, 1/2[rtBMinus1,rtBPlus1]);
  
  
  %clip
  clip currentpicture to bounding3;
  setbounds currentpicture to bounding3;
  

endfig;

beginfig(6);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[], rB[];
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus1),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tBMinus1+o, Oangle1) + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
  O1  := (xpart(tAMinus1),.5u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 rtAMinus1 = light_out(rA1,rotation+Oangle1) intersectionpoint obs1;
 % tAMinus2 = light_out(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBMinus1 = light_out(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs1;
  
 %find tPlus
  rtAPlus1 =  light_ret(rA1,rotation+Oangle1) intersectionpoint obs1;
%  tAPlus2 =  light_ret(rA2,rotation+Oangle1) intersectionpoint obs1;
  rtBPlus1 =  light_ret(rB1,rotation+Oangle1) intersectionpoint obs1;
%  tBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs1;
 
%  rtAMinus1  = (o) rotatedabout(tAMinus1, Oangle1);
%  rtBMinus1  = () rotatedabout(tBMinus1, Oangle1);
%  rtAPlus1   = () rotatedabout(tAMinus1, Oangle1);
%  rtBPlus1   = () rotatedabout(tBMinus1, Oangle1);
 
 % rA1 = (A+o) rotatedabout(tAMinus1, Oangle1);
 
%  rB1 =  (B+o ) rotatedabout (tBMinus1, Oangle1)  ; 
 
%draw dots
 

  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;
  arc1    = buildcycle( ( rtAMinus1--(A+o)),circle1,  rA1, light_out(rA1,rotation+Oangle1) );
  %draw circle1;
  clip currentpicture to arc1;

  
%draw light
 % drawlight(rA1,rotation+Oangle1);
  drawlight(rB1,rotation+Oangle1);
 % drawspatial(rtAMinus1, rtAPlus1, rA1);
  %drawspatial(rtBMinus1, rtBPlus1, rB1);
  drawobserver ( O1,  0);

  drawarrow 1/2[rtBMinus1,rtBPlus1]--rtBMinus1;
  drawarrow 1/2[rtBMinus1,rtBPlus1]--rtBPlus1;
  drawarrow 1/2[rtBMinus1,rtBPlus1]--rB1;
  drawarrow rtBMinus1--1/2[rtBMinus1,rB1];
  draw (1/2[rtBMinus1,rB1] )--rB1;
 % drawarrow rB1--rtBPlus1;
  
  %drawcircle(rtBMinus1,rtBPlus1);
 
  
 pickup pencircle scaled 4pt;
%  draw rA1;
  draw rB1;
  pickup pencircle scaled 2pt;
  for i = 1 upto 1:
 %   draw rtAMinus[i];
    draw rtBMinus[i];
 %   draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
%  label.bot(btex $A$ etex, rA1);
  %label.rt(btex $B$ etex, rB1);

  %label.rt(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
 % label.rt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  label.lrt(btex $\lambda n$ etex, 1/2[rtBMinus1,rB1]);
  %label.urt(btex $\delta \bar{n}$ etex, 1/2[rtBPlus1,rB1]);
  label.top(btex $\alpha \gamma_1$ etex, (1/2[(  1/2[rtBMinus1,rtBPlus1]    ),rB1]) + (-0.05u, 0.05u) );
  label.lft(btex $-\alpha\gamma_0$ etex, 1/4[rtBMinus1,rtBPlus1]);
  label.lft(btex $\alpha\gamma_0$ etex, 3/4[rtBMinus1,rtBPlus1]);
 % label.llft(btex $\tau_A^{1+}$ etex, rtAPlus1);
 % label.urt(btex $\tau_B^{1+}$ etex, rtBPlus1);

  label.lft(btex $0$ etex, 1/2[rtBMinus1,rtBPlus1]);
  
  
  %clip
  clip currentpicture to bounding3;
  setbounds currentpicture to bounding3;
  

endfig;



beginfig(7);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, grA, grB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[],  rB[];
  pair grA[], grB[]; %rotated acording to metric g
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus1),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tBMinus1+o, Oangle1) + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
  O1  := (xpart(tAMinus1),1u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 rtAMinus1 = light_out(rA1,rotation+Oangle1) intersectionpoint obs1;
  rtBMinus1 = light_out(rB1,rotation+Oangle1) intersectionpoint obs1;
  
 %find tPlus
  rtAPlus1 =  light_ret(rA1,rotation+Oangle1) intersectionpoint obs1;
  rtBPlus1 =  light_ret(rB1,rotation+Oangle1) intersectionpoint obs1;

  %find the rotation acording to g
  grA1 = (rA1) rotatedabout(1/2[rtAMinus1,rtAPlus1] ,(rotation-2*Oangle1));
  grB1 = (rB1) rotatedabout(1/2[rtBMinus1,rtBPlus1] ,(rotation-2*Oangle1));
  
%draw dots
 

  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;
  arc1    = buildcycle( ( rtAMinus1--(A+o)),circle1,  rA1, light_out(rA1,rotation+Oangle1) );
  %draw circle1;
  clip currentpicture to arc1;
  

  rad2 = abs(rA1 - 1/2[rtAMinus1,rtAPlus1]);
  rad3 = abs(rB1 - 1/2[rtBMinus1,rtBPlus1]);
  circle2 = fullcircle scaled (2*rad2) shifted 1/2[rtAMinus1,rtAPlus1];
  circle3 = fullcircle scaled (2*rad3) shifted 1/2[rtBMinus1,rtBPlus1];
  draw circle2 withcolor 0.75white;
  draw circle3 withcolor 0.75white;
  
  drawellipse_light(rA1,rB1);
  
%draw light
  drawlight(grA1,rotation);
  drawlight(grB1,rotation);
  drawspatial(rtAMinus1, rtAPlus1, grA1);
  drawspatial(rtBMinus1, rtBPlus1, grB1);
  drawobserver ( O1,  0);

 %drawellipse(grA1,grB1);
  drawellipse_metric(rA1,rB1,obs1,Oangle1 , Oangle1);
 pickup pencircle scaled 4pt;
  draw rA1 withcolor 0.75white ;
  draw rB1 withcolor 0.75white;
  draw grA1;
  draw grB1;
  draw  metriced_point(rB1,obs1,Oangle1 , Oangle1);
  draw  metriced_point(rA1,obs1,Oangle1 , Oangle1);
  pickup pencircle scaled 2pt;
  for i = 1 upto 1:
    draw rtAMinus[i];
    draw rtBMinus[i];
    draw rtAPlus[i];
    draw rtBPlus[i];

    
    %draw 1/2[rtAMinus1,rtAPlus1];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;
  
  pickup pencircle scaled 1pt;
  
  
  %draw labels
  label.bot(btex $A$ etex, grA1);
  label.bot(btex $B$ etex, grB1);

  label.rt(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
  %label.rt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  %label.rt(btex $\tau_B^{1-}$ etex, rtBMinus1);

  %label.llft(btex $\tau_A^{1+}$ etex, rtAPlus1);
  %label.llft(btex $\tau_B^{1+}$ etex, rtBPlus1);

  
  
  %clip
  clip currentpicture to bounding6;
  
endfig;

beginfig(8);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, grA, grB, o, circle, arc, rad, Btranslation;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];

  pair rA[], rB[];
  pair grA[], grB[]; %rotated acording to metric g
 
  pair o;

  path obs[];
  path circle[];
  path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus2),0);


  pair Btranslation;
  Btranslation = (-abs(xpart(tAMinus2) - xpart(tBMinus2)),  abs(tBMinus2-tAMinus2) - abs(ypart(tAMinus2) - ypart(tBMinus2)) );
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tBMinus2+o, Oangle2) - Btranslation  ;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %drawlight(rB2,rotation+Oangle2);
  
  %draw observers
   O2  := (xpart(tAMinus2),1u)   + o;
  obs2 = observer(O2 ,  0);
  
  %O2  := (xpart(tAMinus2),5.7u)   + o;
  %obs2 = observer(O2 ,  0);
  %find tMinus
 rtAMinus2 = light_out(rA2,rotation+Oangle2) intersectionpoint obs2;
  rtBMinus2 = light_out(rB2,rotation+Oangle2) intersectionpoint obs2;
  
 %find tPlus
  rtAPlus2 =  light_ret(rA2,rotation+Oangle2) intersectionpoint obs2;
  rtBPlus2 =  light_ret(rB2,rotation+Oangle2) intersectionpoint obs2;
 
  %find the rotation acording to g
  grA2 =  metriced_point(rA2,obs2,Oangle2 ,Oangle2);
  grB2 =  metriced_point(rB2,obs2,Oangle2 ,Oangle2);
  %(rA2) rotatedabout(1/2[rtAMinus2,rtAPlus2] ,(rotation-2*Oangle2));
  %grB2 = (rB2) rotatedabout(1/2[rtBMinus2,rtBPlus2] ,(rotation-2*Oangle2));
  
%  rtAMinus2  = (o) rotatedabout(tAMinus2, Oangle2);
%  rtBMinus2  = () rotatedabout(tBMinus2, Oangle2);
%  rtAPlus2   = () rotatedabout(tAMinus2, Oangle2);
%  rtBPlus2   = () rotatedabout(tBMinus2, Oangle2);
 
 % rA2 = (A+o) rotatedabout(tAMinus2, Oangle2);
 
%  rB2 =  (B+o ) rotatedabout (tBMinus2, Oangle2)  ; 
 
%draw dots
 

  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle2 = fullcircle scaled (2*rad2) shifted rtAMinus2;
  %arc2    = buildcycle( ( rtAMinus2--(A+o)),circle2,  rA2, light_out(rA2,rotation+Oangle2) );
  %draw circle2;
 % clip currentpicture to arc2;
  



  rad4 = abs(rA2 - 1/2[rtAMinus2,rtAPlus2]);
  rad3 = abs(rB2 - 1/2[rtBMinus2,rtBPlus2]);
  circle4 = fullcircle scaled (2*rad4) shifted 1/2[rtAMinus2,rtAPlus2];
  circle3 = fullcircle scaled (2*rad3) shifted 1/2[rtBMinus2,rtBPlus2];
  draw circle4 withcolor 0.75white;
  draw circle3 withcolor 0.75white;
  
  drawellipse_light(rB2,rA2);
  
  
%draw light
  drawlight(grA2,90+rotation);
  drawlight(grB2,90+rotation);
  drawspatial(rtAMinus2, rtAPlus2, grA2);
  drawspatial(rtBMinus2, rtBPlus2, grB2);
  drawobserver ( O2, 180 );

 
  
  drawellipse_metric(rB2,rA2,obs2,Oangle2 ,Oangle2);%  -(90-Oangle2));
  
  pickup pencircle scaled 4pt;
  draw rA2 withcolor 0.75white ;
  draw rB2 withcolor 0.75white;
  %raw grA2;
  %raw grB2;
  draw  metriced_point(rB2,obs2,Oangle2 ,Oangle2);%-(90-Oangle2));
  draw  metriced_point(rA2,obs2,Oangle2 ,Oangle2); %-(90-Oangle2));
  pickup pencircle scaled 2pt;
  for i = 2 upto 2:
    draw rtAMinus[i];
    draw rtBMinus[i];
    draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
  label.rt(btex $A$ etex, grA2);
  label.rt(btex $B$ etex, grB2);

  label.rt(btex Observer 2 etex, O2);
 % label.bot(btex Observer 2 etex,O2 );
  
  %label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  %label.rt(btex $\tau_B^{2-}$ etex, rtBMinus2);
%  label.bot(btex $\tau_A^{2-}$ etex, tAMinus2);
%  label.bot(btex $\tau_B^{2-}$ etex, tBMinus2);

  %label.ulft(btex $\tau_A^{2+}$ etex, rtAPlus2);
  %label.ulft(btex $\tau_B^{2+}$ etex, rtBPlus2);
%  label.bot(btex $\tau_A^{2+}$ etex, tAPlus2);
%  label.bot(btex $\tau_B^{2+}$ etex, tBPlus2);

  
  
  %clip
  clip currentpicture to bounding5;
  
endfig;

end;

