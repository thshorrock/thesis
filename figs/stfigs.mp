


%verbatimtex
%\documentclass[6pt]{article}
%\begin{document}
%etex



numeric std_pen_size;
std_pen_size := 0.3pt;

    pickup pencircle scaled std_pen_size;
    
vardef arcsind primary x = angle((1+-+x,x)) enddef;
vardef arccosd primary x = angle((x,1+-+x)) enddef;

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
    pickup pencircle scaled std_pen_size;
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
    pickup pencircle scaled std_pen_size;
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
    outward_prim := (at - ( large_length, large_length))--   (at);
    %  + ( large_length, large_length) 
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
    returning_prim := (at  )--(at + ( -large_length, large_length) );
    %- ( -large_length, large_length)
    returning := returning_prim   rotatedaround(at,angle);
    returning
  endgroup
enddef;

def observer_to_the_left_of_point(expr at, the_observer) =
  begingroup
    save obs_at_test_point, return_value, large_length;
    pair obs_at_test_point;
    numeric return_value large_length;
    pickup pencircle scaled std_pen_size;
    large_length = 100cm;
    obs_at_test_point = ((-large_length, ypart(at))--(large_length, ypart(at))) intersectionpoint the_observer ;
    numeric test_value;
    test_value = xpart(at)-xpart(obs_at_test_point);
    
    if (test_value > 0) :
    %  show ("observer to the left");
      
      return_value = 1;
    else:
    %  show ("observer to the right");
      return_value = 0;
    fi
    %draw obs_at_test_point--at;
    %show ("test value = " & decimal(xpart(at))&", "& decimal(xpart(obs_at_test_point))&", "&decimal(test_value));
    %draw obs_at_test_point withcolor green;
    return_value
  endgroup
enddef;


def light_path(expr at, the_observer, rot_angle, draw_me) =
  %set draw_me to equal one to draw the lightpath
  begingroup
    save large_length,  lp ,obs_at_test_point;
    numeric large_length;
    path lp, returning;
    pair obs_at_test_point;
    
    pickup pencircle scaled std_pen_size;
    
    large_length = 100cm;
    obs_at_test_point = ((-large_length, ypart(at))--(large_length, ypart(at))) intersectionpoint the_observer ;
    
    if (observer_to_the_left_of_point(at,the_observer ) = 1) :
      %xpart(at-obs_at_test_point) < 0
      %the out light signal needs to go to the right,
      lp := light_out(at,rot_angle) -- light_ret(at,rot_angle);
      if (draw_me =1):
%	show ("lp_l");
	draw light_out(at,rot_angle)  withcolor blue;
	draw light_ret(at,rot_angle)  withcolor red;
      fi
    else:
      lp := light_out(at,rot_angle+180) --  light_ret(at,rot_angle+180);
      if (draw_me =1):
%	show ("lp_r");
	draw light_out(at,rot_angle+180)  withcolor red;
	draw light_ret(at,rot_angle+180)  withcolor blue;
      fi
    fi
    lp
  endgroup
enddef;


def drawlight(expr at, rot_angle) =
  begingroup
    pickup pencircle scaled std_pen_size;
    draw light_out(at,rot_angle)  withcolor blue;
    draw light_ret(at,rot_angle)  withcolor red;
  endgroup
enddef;
def drawlight_r(expr at, rot_angle) =
  begingroup
    pickup pencircle scaled std_pen_size;
    draw light_out(at,rot_angle +180)  withcolor red;
    draw light_ret(at,rot_angle +180)  withcolor blue;
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
    pickup pencircle scaled std_pen_size;
    draw ((1,0)--(1,1)--(0,1)) zscaled(mark_size*unitvector((1+tn)*endofa+(1-tn)*endofb-2*common)) shifted common;
  endgroup
enddef;


def mark_angle(expr A, common, B, n) = % draw 1, 2, 3 or 4 arcs
  save angle_radius, angle_delta, mark_size;
  angle_radius := 9mm;
  angle_delta := 0.5mm;
  mark_size := 2mm;
  
  
  draw_angle(A, common, B, angle_radius);
  if n>1: draw_angle(A, common, B, angle_radius+angle_delta); fi;
  if n>2: draw_angle(A, common, B, angle_radius-angle_delta); fi;
  if n>3: draw_angle(A, common, B, angle_radius+2*angle_delta); fi;
enddef;

def draw_angle(expr endofa, common, endofb, r) =
   begingroup
   save tn; tn := turningnumber(common--endofa--endofb--cycle);
   draw (unitvector(endofa-common){(endofa-common) rotated(tn*90)} .. unitvector(endofb-common)) scaled r shifted common;
   endgroup
enddef;


def find_t_minus(expr the_point, the_observer, light_out_angle, draw_dot) =
  begingroup
    save out_time;
    pair out_time;
    if (observer_to_the_left_of_point(the_point,the_observer ) = 1) :
      out_time := light_out(the_point,light_out_angle) intersectionpoint the_observer ;
    else:
      out_time := light_out(the_point,90+light_out_angle) intersectionpoint the_observer ;
    fi;
    
    if (draw_dot=1):
      pickup pencircle scaled 2pt;
      draw out_time;
    fi
 pickup pencircle scaled std_pen_size;
    out_time
    endgroup
enddef;

def find_t_plus(expr the_point, the_observer, light_out_angle, draw_dot) =
  begingroup
    save ret_time;
    pair ret_time;
    if (observer_to_the_left_of_point(the_point,the_observer ) = 1) :
      ret_time := light_ret(the_point,light_out_angle) intersectionpoint the_observer ;
    else:
      ret_time := light_ret(the_point,-90+light_out_angle) intersectionpoint the_observer ;
    fi;
    
    if (draw_dot=1):
      pickup pencircle scaled 2pt;
      draw ret_time;
    fi
 pickup pencircle scaled std_pen_size;
    ret_time
    endgroup
enddef;

def find_t_minus_time(expr the_point, the_observer, light_out_angle, draw_dot) =
  begingroup
    save out_time;
    numeric out_time;
    if (observer_to_the_left_of_point(the_point,the_observer ) = 1) :
      out_time :=ypart(light_out(the_point,light_out_angle) intersectiontimes the_observer );
    else:
     out_time :=ypart( light_out(the_point,90+light_out_angle) intersectiontimes the_observer );
    fi;
    
    if (draw_dot=1):
      pickup pencircle scaled 2pt;
      draw point out_time of the_observer ;
    fi
     pickup pencircle scaled std_pen_size;
    %draw ((point out_time of the_observer)--(the_point));
    out_time
    endgroup
enddef;

def find_t_plus_time(expr the_point, the_observer, light_out_angle, draw_dot) =
  begingroup
    save ret_time;
    numeric ret_time;
    if (observer_to_the_left_of_point(the_point,the_observer ) = 1) :
      ret_time := ypart(light_ret(the_point,light_out_angle) intersectiontimes the_observer );
    else:
      ret_time := ypart(light_ret(the_point,-90+light_out_angle) intersectiontimes the_observer) ;
    fi;
    
    if (draw_dot=1):
      pickup pencircle scaled 2pt;
      draw point ret_time of the_observer;
    fi
     pickup pencircle scaled std_pen_size;
    %draw ((point ret_time of the_observer)--(the_point));
    ret_time
    endgroup
enddef;


def find_local_origin(expr the_point, the_observer, light_out_angle, draw_dot) =
  begingroup
    save out_time, ret_time,average_time,  the_loc_origin;
    pair the_loc_origin;
    numeric out_time, ret_time, average_time;
    %find tMinus
    out_time := find_t_minus_time(the_point, the_observer, light_out_angle, 0);
    ret_time := find_t_plus_time(the_point, the_observer, light_out_angle, 0);
    
    average_time := 1/2(out_time+ret_time);
    
    the_loc_origin := point average_time of the_observer;

    if (draw_dot=1):
      pickup pencircle scaled 2pt;
      draw the_loc_origin ;
    fi
     pickup pencircle scaled std_pen_size;
    the_loc_origin
   
  endgroup
enddef;

def metriced_point(expr the_point, the_observer, light_out_angle, rotation_angle) =
  begingroup
    pickup pencircle scaled std_pen_size;

    save the_loc_origin, rotated_point;
    pair the_loc_origin, rotated_point;
    the_loc_origin:= find_local_origin( the_point, the_observer, light_out_angle,0);
    
    rotated_point :=(the_point) rotatedabout(the_loc_origin ,(-2*rotation_angle));
    rotated_point
  endgroup
enddef;



def make_circular_arc(expr centre, radius, from, through) =
  %from angle, through angle
  begingroup
    save arc_prim, arc, circle, points;
    path arc_prim[], arc,circle;
    pair points[];
    circle = fullcircle scaled (2*radius) shifted centre;
    points1 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,from);
    points2 = points1 rotatedabout (centre,through);

    arc_prim[1] = points1..(centre + (radius*cosd(from), radius*sind(from)));
    for theta = 2 upto through:
      arc_prim[theta]=  arc_prim[theta-1]..(centre + (radius*cosd(from+theta), radius*sind(from+theta)));
    endfor
   arc = arc_prim[through];
%arc =circle;
    arc

  endgroup
enddef;


def drawcircle(expr tm, tp) =
  begingroup
    save r;
    save c; %cenre
    save h,k;
%    save x,y,z;
%    save pellipse;

pickup pencircle scaled std_pen_size;
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


def make_ellipse(expr focus_a, focus_b) =
 begingroup
    save a, b; %semi major semi-minor;
    save c; %cenre
    save phi;  %rotated angle
    save h,k;
    save pellipse;
    pickup pencircle scaled std_pen_size;
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

    path pellipse[], return_ellipse;
    x[0] =  h + a*cosd(phi);
    y[0] =  k + a*sind(phi);
    z[0] = (x[0],y[0]);
    x[1] = h + a*cosd(1)*cosd(phi) - b*sind(1) * sind(phi);
    y[1] = k + b*sind(1)*cosd(phi) + a*cosd(1) * sind(phi);
    z[1] = (x[1],y[1]);
    pellipse[1] := z[0]..z[1];
    for theta = 2 upto 360:
      x[theta] = h + a*cosd(theta)*cosd(phi) - b*sind(theta) * sind(phi);
      y[theta] = k + b*sind(theta)*cosd(phi) + a*cosd(theta) * sind(phi);
      z[theta] = (x[theta],y[theta]);
      pellipse[theta] :=pellipse[theta-1]..z[theta];
    endfor
    return_ellipse = pellipse[360]..cycle;
    return_ellipse
    
    %pellipse = z[0]..z[20]..z[40]..z[60]..z[80]..z[100]..z[120]..z[140]..z[160]..z[180]..z[200]..z[220]..z[240]..z[260]..z[280]..z[300]..z[320]..z[340]..cycle;
  endgroup
enddef;

def drawellipse(expr focus_a, focus_b) =
  begingroup
    save ellipse;
    path ellipse;
    ellipse = make_ellipse( focus_a, focus_b) ;
    draw ellipse;
  endgroup
enddef;

def drawellipse_light(expr lfocus_a, lfocus_b) =
  begingroup
    save ellipse;
    path ellipse;
    ellipse = make_ellipse( lfocus_a, lfocus_b) ;
    draw ellipse withcolor  0.75white;
    
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
pickup pencircle scaled std_pen_size;
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
pickup pencircle scaled std_pen_size;
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


def emph_projection(expr the_path_given, no_points, reverse_path) =
  begingroup
    %need the number of points in the path so that can work through the entire path in case of multiple intersections.
   
   
    
    save the_path_prim, the_path, the_path_reverse, projected, init_direction;

    path the_path_prim[];
    path the_path;
    path the_path_reverse;
    path projected[];

     %begin at end of path by convension, may need to reverse path
    %if (reverse_path = 1):
      the_path_prim[0] = (point (no_points-0) of the_path_given)..(point (no_points-1) of the_path_given);
      for theta = 1 upto no_points:
	the_path_prim[theta] = (point (no_points-theta-0) of the_path_given)..(point (no_points-theta-1) of the_path_given);
      endfor

    if (reverse_path = 1):
      the_path = the_path_prim[no_points];
      the_path_reverse = the_path_given;
    else:
      the_path_reverse = the_path_prim[no_points];
      the_path = the_path_given;
    fi
    
   %okay now have the path to work with,
    pair  init_direction;
    %init_direction := direction 0 of the_path;

    
    pair out_sound_tangent[];
    pair ret_sound_tangent[];
    
    out_sound_tangent[0]:=  directionpoint(-1,-1) of the_path;
    ret_sound_tangent[0]:=  directionpoint(+1,-1) of the_path;

    pickup pencircle scaled 2;
    for i = 0 upto 0:
      draw out_sound_tangent[i] withcolor red;
      draw ret_sound_tangent[i] withcolor blue;
    endfor
    
    pair final_out_sound_tangent;
    pair final_ret_sound_tangent;
    final_out_sound_tangent:=  directionpoint(-1,-1) of the_path_reverse;
    final_ret_sound_tangent:=  directionpoint(+1,-1) of the_path_reverse;
    pickup pencircle scaled 2;
   draw the_path_reverse withcolor red;
      draw final_out_sound_tangent withcolor black
      %draw final_ret_sound_tangent withcolor black;
    
    %find the inital direction 
    %for theta = 0 upto no_points:
      
    %endfor
    
    
  endgroup
enddef;



numeric u; %scale
numeric boxSizeX;
numeric boxSizeY;

pair A, B;  %points
numeric Oangle[];


Oangle1 = 0;
Oangle2 = 15;

u = 0.75cm;

A := (3u, 5u) + (0,0);
B := (4u, 7u)+ (0,0);



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
bounding7:= (-0.5u,1.25u)--(6.5u,1.25u)-- (6.5u,bboxSizeY+1.25u)-- (-0.5u,bboxSizeY+1.25u)--cycle;
bounding8:= (-0.5u,0u)--(10u,0u)-- (10u,bboxSizeY)-- (-0.5u,bboxSizeY)--cycle;
beginfig(0);
 pickup pencircle scaled std_pen_size;
  save o;
  pair o;
  o := (0u,0u);
  drawellipse(A,B);
  
  pickup pencircle scaled 4pt;
  draw A;
  draw B;
  
  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  %draw axis
  save points;
  pair points[];

  points0 = A +(-3u,3u);
  points1 = points0+(0,1u);
  points2 = points0+(1u,0);
pickup pencircle scaled std_pen_size;
  drawarrow points0--points1;
  drawarrow points0--points2;

  label.top(btex $p_0$ etex, points1);
  label.rt(btex $p_1$ etex,points2 );

  
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

  save rotation, O, obs,lp, o;% tAMinus, tAPlus, tBMinus, tBPlus,
  
  numeric rotation;
  pair O[];  %observer locs
  pair tAMinus[], tAPlus[];
  pair tBMinus[], tBPlus[];
  
  pair o; %origin
  o := (0u,0u);
   drawellipse(A,B);
  path obs[], lpA[], lpB[];
  
  rotation :=  0;
  
  %draw observers
  O1  := (5.25u,0.5u)   + o;
  O2  := (0.8u,1.5u) + o;
  obs1 = observer(O1 ,  Oangle1);
  obs2 = observer(O2 ,  Oangle2);

  drawobserver ( O1,  Oangle1);
  drawobserver ( O2,  Oangle2);
   %draw light
  lpA1 :=  light_path(A, obs1, rotation, 1);
  lpA2 :=  light_path(A, obs2, rotation, 1);
  lpB1 :=  light_path(B, obs1, rotation, 1);
  lpB2 :=  light_path(B, obs2, rotation, 1);
  
  %find tMinus
  tAMinus1 = find_t_minus(A, obs1, rotation, 1);
  tAMinus2 = find_t_minus(A, obs2, rotation, 1);
  tBMinus1 = find_t_minus(B, obs1, rotation, 1);
  tBMinus2 = find_t_minus(B, obs2, rotation, 1);
  
  %find tPlus
  tAPlus1 = find_t_plus(A, obs1, rotation, 1);
  tAPlus2 = find_t_plus(A, obs2, rotation, 1);
  tBPlus1 = find_t_plus(B, obs1, rotation, 1);
  tBPlus2 = find_t_plus(B, obs2, rotation, 1);

  
%draw dots
  pickup pencircle scaled 4pt;
  draw A;
  draw B;

  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  label.lrt(btex Observer 1 etex, O1);
  label.lrt(btex Observer 2 etex,O2 );
  
  label.rt(btex $\tau_A^{1-}$ etex, tAMinus1);
  label.rt(btex $\tau_B^{1-}$ etex, tBMinus1);
  label.lft(btex $\tau_A^{2-}$ etex, tAMinus2);
  label.lft(btex $\tau_B^{2-}$ etex, tBMinus2);

  label.rt(btex $\tau_A^{1+}$ etex, tAPlus1);
  label.rt(btex $\tau_B^{1+}$ etex, tBPlus1);
  label.lft(btex $\tau_A^{2+}$ etex, tAPlus2);
  label.lft(btex $\tau_B^{2+}$ etex, tBPlus2);

  
  
  %clip
  clip currentpicture to toView;
  
endfig;

beginfig(3);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB,lpA, lpB, o, circle, arc, rad, Btranslation;
  
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


  %pair Btranslation;
  %Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tAMinus1+o, Oangle1);% + Btranslation;
  %rB1 = (B+o) rotatedabout(tBMinus1+o, Oangle1) + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
   drawellipse(rA1,rB1);
  
  rotation :=  0;
  
  %draw observers
  O1  := (xpart(tAMinus1),1u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 
  %find tMinus
  rtAMinus1 = find_t_minus(rA1, obs1, rotation+Oangle1, 1);
  rtBMinus1 = find_t_minus(rB1, obs1, rotation+Oangle1, 1);
  
  %find tPlus
  rtAPlus1 = find_t_plus(rA1, obs1, rotation+Oangle1, 1);
  rtBPlus1 = find_t_plus(rB1, obs1, rotation+Oangle1, 1);

  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;

  drawspatial(rtAMinus1, rtAPlus1, rA1);
  drawspatial(rtBMinus1, rtBPlus1, rB1);
  drawobserver ( O1,  0);
%draw light
   path lpA[], lpB[];
  lpA1 :=  light_path(rA1, obs1, rotation+Oangle1, 1);
  lpB1 :=  light_path(rB1, obs1, rotation+Oangle1, 1);
  
  
 pickup pencircle scaled 4pt;
  draw rA1;
  draw rB1;
  pickup pencircle scaled 2pt;
 

  
  %draw labels
  label.lft(btex $A$ etex, rA1);
  label.lft(btex $B$ etex, rB1);

  label.lft(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
  label.urt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  label.rt(btex $\tau_B^{1-}$ etex, rtBMinus1);

  label.rt(btex $\tau_A^{1+}$ etex, rtAPlus1);
  label.ulft(btex $\tau_B^{1+}$ etex, rtBPlus1);

  
  
  %clip
  clip currentpicture to bounding2;
  
endfig;

beginfig(4);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB,lpA, lpB, o, circle, arc, rad, Btranslation;
  
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


  %pair Btranslation;
  %Btranslation = (-abs(xpart(tAMinus2) - xpart(tBMinus2)),  abs(tBMinus2-tAMinus2) - abs(ypart(tAMinus2) - ypart(tBMinus2)) );
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tAMinus2+o, Oangle2);% - Btranslation  ;
  drawellipse(rA2,rB2);
  rotation :=  0;
  
  %draw observers
  O2  := (xpart(tAMinus2),1u)   + o;
  obs2 = observer(O2 ,  0);
  
    %find tMinus
 
  %find tMinus
  rtAMinus2 = find_t_minus(rA2, obs2, rotation+Oangle2,0 );
  rtBMinus2 = find_t_minus(rB2, obs2, rotation+Oangle2,0 );
  
  %find tPlus
  rtAPlus2 = find_t_plus(rA2, obs2, rotation+Oangle2, 0);
  rtBPlus2 = find_t_plus(rB2, obs2, rotation+Oangle2, 0);

  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle1 = fullcircle scaled (2*rad2) shifted rtAMinus2;

%draw light

  drawspatial(rtAMinus2, rtAPlus2, rA2);
  drawspatial(rtBMinus2, rtBPlus2, rB2);
  drawobserver ( O2,  0);
%draw light
   path lpA[], lpB[];
  lpA2 :=  light_path(rA2, obs2, rotation+Oangle2, 1);
  lpB2 :=  light_path(rB2, obs2, rotation+Oangle2, 1);
  
  
  
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
  
  label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  label.lft(btex $\tau_B^{2-}$ etex, rtBMinus2);

  label.llft(btex $\tau_A^{2+}$ etex, rtAPlus2);
  label.llft(btex $\tau_B^{2+}$ etex, rtBPlus2);
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
  
  o = (3u-xpart(tAMinus2),0);


 %pair Btranslation;
 %Btranslation = (-abs(xpart(tAMinus2) - xpart(tBMinus2)),  abs(tBMinus2-tAMinus2) - abs(ypart(tAMinus2) - ypart(tBMinus2)) );
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tAMinus2+o, Oangle2);%+ Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  

  %draw observers
  O2  := (xpart(tAMinus2),3.5u)   + o;
  obs2 = observer(O2 ,  0);

  %find tMinus
  rtAMinus2 = find_t_minus(rA2, obs2, rotation+Oangle2, 0);
  rtBMinus2 = find_t_minus(rB2, obs2, rotation+Oangle2, 0);
  
  %find tPlus
  rtAPlus2 = find_t_plus(rA2, obs2, rotation+Oangle2, 0);
  rtBPlus2 = find_t_plus(rB2, obs2, rotation+Oangle2, 0);

  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle2 = fullcircle scaled (2*rad2) shifted rtAMinus2;

  drawspatial(rtBMinus2, rtBPlus2, rB2);
  drawobserver ( O2,  0);
%draw light
   path  lpB[];
  lpB2 :=  light_path(rB2, obs2, rotation+Oangle2, 1);
  
  

  drawcircle(rtBMinus2,rtBPlus2);
 
  
 pickup pencircle scaled 4pt;
%  draw rA2;
  draw rB2;
  pickup pencircle scaled 2pt;
  for i = 2 upto 2:
 %   draw rtAMinus[i];
    draw rtBMinus[i];
 %   draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
%  label.bot(btex $A$ etex, rA2);
  label.rt(btex $B$ etex, rB2);

  label.rt(btex Observer 2 etex, O2);
 % label.bot(btex Observer 2 etex,O2 );
  
 % label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  label.lrt(btex $\tau_B^{2-}$ etex, rtBMinus2);

 % label.llft(btex $\tau_A^{2+}$ etex, rtAPlus2);
  label.urt(btex $\tau_B^{2+}$ etex, rtBPlus2);

%  label.lft(btex $0$ etex, 1/2[rtBMinus2,rtBPlus2]);
  
  
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
  
  o = (3u-xpart(tAMinus2),0);


 % pair Btranslation;
 % Btranslation = (-abs(xpart(tAMinus2) - xpart(tBMinus2)),  abs(tBMinus2-tAMinus2) - abs(ypart(tAMinus2) - ypart(tBMinus2)) );
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tBMinus2+o, Oangle2);% + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  


  %draw observers
  O2  := (xpart(tAMinus2),3.5u)   + o;
  obs2 = observer(O2 ,  0);

  %find tMinus
  rtAMinus2 = find_t_minus(rA2, obs2, rotation+Oangle2, 0);
  rtBMinus2 = find_t_minus(rB2, obs2, rotation+Oangle2, 0);
  
  %find tPlus
  rtAPlus2 = find_t_plus(rA2, obs2, rotation+Oangle2, 0);
  rtBPlus2 = find_t_plus(rB2, obs2, rotation+Oangle2, 0);
 %find central point
save centre;
  pair centre;
  centre = find_local_origin(rB2, obs2, Oangle2, 1);

  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle2 = fullcircle scaled (2*rad2) shifted rtAMinus2;

  save horizontal_point;
  pair horizontal_point;
  horizontal_point = centre+ rad2 *(1,0);

  
  drawspatial(rtBMinus2, rtBPlus2, rB2);
  drawobserver ( O2,  0);
%draw light
   path  lpB[];
  lpB2 :=  light_path(rB2, obs2, rotation+Oangle2, 1);
  
  
 draw centre--horizontal_point dashed withdots scaled 0.25;
  

  drawarrow 1/2[rtBMinus2,rtBPlus2]--rtBMinus2;
  drawarrow 1/2[rtBMinus2,rtBPlus2]--rtBPlus2;
  drawarrow 1/2[rtBMinus2,rtBPlus2]--rB2;
  drawarrow rtBMinus2--1/2[rtBMinus2,rB2];
  draw (1/2[rtBMinus2,rB2] )--rB2;

   mark_angle(horizontal_point, centre,rB2,1);
  
  
 % drawarrow rB1--rtBPlus2;
  
  %drawcircle(rtBMinus2,rtBPlus2);
 
  
 pickup pencircle scaled 4pt;
%  draw rA2;
  draw rB2;
  pickup pencircle scaled 2pt;
  for i = 2 upto 2:
 %   draw rtAMinus[i];
    draw rtBMinus[i];
 %   draw rtAPlus[i];
    draw rtBPlus[i];
  endfor
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
%  label.bot(btex $A$ etex, rA2);
  %label.rt(btex $B$ etex, rB2);

   label.rt(btex Observer 2 etex, O2);
 % label.bot(btex Observer 2 etex,O2 );
  
 % label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  label.lrt(btex $\lambda n$ etex, 1/2[rtBMinus2,rB2]);
  %label.urt(btex $\delta \bar{n}$ etex, 1/2[rtBPlus2,rB2]);
  label.top(btex $\alpha \gamma_1$ etex, (1/2[(  1/2[rtBMinus2,rtBPlus2]    ),rB2]) + (-0.05u, 0.05u) );
  label.lft(btex $-\alpha\gamma_0$ etex, 1/4[rtBMinus2,rtBPlus2]);
  label.lft(btex $\alpha\gamma_0$ etex, 3/4[rtBMinus2,rtBPlus2]);
 % label.llft(btex $\tau_A^{2+}$ etex, rtAPlus2);
 % label.urt(btex $\tau_B^{2+}$ etex, rtBPlus2);

  label.lft(btex $0$ etex, 1/2[rtBMinus2,rtBPlus2]);
   
  label.urt(btex $\phi$ etex, (1/4[centre,horizontal_point]+(0.2mm,-.4mm))); %
  
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


 % pair Btranslation;
  %Btranslation = (-abs(xpart(tAMinus1) - xpart(tBMinus1)),  abs(tBMinus1-tAMinus1) - abs(ypart(tAMinus1) - ypart(tBMinus1)) );
  rA1 = (A+o) rotatedabout(tAMinus1+o, Oangle1);
  rB1 = (B+o) rotatedabout(tAMinus1+o, Oangle1);% + Btranslation;
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  
    
  %draw observers
  O1  := (xpart(tAMinus1),1u)   + o;
  obs1 = observer(O1 ,  0);
  %find tMinus
 
  %find tMinus
  rtAMinus1 = find_t_minus(rA1, obs1, rotation+Oangle1, 1);
  rtBMinus1 = find_t_minus(rB1, obs1, rotation+Oangle1, 1);
  
  %find tPlus
  rtAPlus1 = find_t_plus(rA1, obs1, rotation+Oangle1, 1);
  rtBPlus1 = find_t_plus(rB1, obs1, rotation+Oangle1, 1);

  %find the rotation acording to g
  grA1 =metriced_point(rA1,obs1,Oangle1 , Oangle1);
  %(rA1) rotatedabout(1/2[rtAMinus1,rtAPlus1] ,(rotation-2*Oangle1));
grB1 = metriced_point(rB1,obs1,Oangle1 , Oangle1);
  %(rB1) rotatedabout(1/2[rtBMinus1,rtBPlus1] ,(rotation-2*Oangle1));
   %metriced_point(rB1,obs1,Oangle1 , Oangle1);
  %draw circle;
 
  rad1    = abs(rA1 - rtAMinus1);
  circle1 = fullcircle scaled (2*rad1) shifted rtAMinus1;

  drawspatial(rtAMinus1, rtAPlus1, grA1);
  drawspatial(rtBMinus1, rtBPlus1, grB1);
  drawobserver ( O1,  0);
%draw light
   path lpA[], lpB[];
  lpA1 :=  light_path(grA1, obs1, rotation, 1);
  lpB1 :=  light_path(grB1, obs1, rotation, 1);
  
  

  rad2 = abs(rA1 - 1/2[rtAMinus1,rtAPlus1]);
  rad3 = abs(rB1 - 1/2[rtBMinus1,rtBPlus1]);
  circle2 = fullcircle scaled (2*rad2) shifted 1/2[rtAMinus1,rtAPlus1];
  circle3 = fullcircle scaled (2*rad3) shifted 1/2[rtBMinus1,rtBPlus1];
  draw circle2 withcolor 0.75white;
  draw circle3 withcolor 0.75white;
  
  drawellipse_light(rA1,rB1);
  
  
 drawellipse_metric(rA1,rB1,obs1,Oangle1 ,Oangle1);
 
 pickup pencircle scaled 4pt;
  draw rA1 withcolor 0.75white ;
  draw rB1 withcolor 0.75white;
  draw grA1;
  draw grB1;
  %draw  metriced_point(rB1,obs1,Oangle1 , Oangle1);
  %draw  metriced_point(rA1,obs1,Oangle1 , Oangle1);
  pickup pencircle scaled 2pt;
 
  %draw A+o;
  %pickup pencircle scaled 0pt;
  
  pickup pencircle scaled 1pt;
  
  
  %draw labels
  label.lft(btex $A$ etex, grA1);
  label.lft(btex $B$ etex, grB1);

  label.lft(btex Observer 1 etex, O1);
 % label.bot(btex Observer 2 etex,O2 );
  
  %label.rt(btex $\tau_A^{1-}$ etex, rtAMinus1);
  %label.rt(btex $\tau_B^{1-}$ etex, rtBMinus1);

  %label.llft(btex $\tau_A^{1+}$ etex, rtAPlus1);
  %label.llft(btex $\tau_B^{1+}$ etex, rtBPlus1);

  
  
  %clip
  clip currentpicture to bounding2;
  
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


  
  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tAMinus2+o, Oangle2);
  %rA2 = (A+o) rotatedabout(o, Oangle2);
  %rB2 = (B+o) rotatedabout(o, Oangle2);
  
  
  rotation :=  0;
  
  
  
  %draw observers
  O2  := (xpart(tAMinus2),1u)   + o;
  obs2 = observer(O2 ,  0);
  %find tMinus
 
  %find tMinus
  rtAMinus2 = find_t_minus(rA2, obs2, rotation+Oangle2, 1);
  rtBMinus2 = find_t_minus(rB2, obs2, rotation+Oangle2, 1);
  
  %find tPlus
  rtAPlus2 = find_t_plus(rA2, obs2, rotation+Oangle2, 1);
  rtBPlus2 = find_t_plus(rB2, obs2, rotation+Oangle2, 1);

  %find the rotation acording to g
  grA2 =metriced_point(rA2,obs2,Oangle2 , Oangle2);
grB2 = metriced_point(rB2,obs2,Oangle2 , Oangle2);
  %(rB2) rotatedabout(1/2[rtBMinus2,rtBPlus2] ,(rotation-2*Oangle2));
   %metriced_point(rB2,obs2,Oangle2 , Oangle2);
  %draw circle;
 
  rad2    = abs(rA2 - rtAMinus2);
  circle2 = fullcircle scaled (2*rad2) shifted rtAMinus2;
  
  pickup pencircle scaled 4pt;
  draw rA2 withcolor 0.75white ;
  draw rB2 withcolor 0.75white;
  draw grA2;
  draw grB2;
  pickup pencircle scaled std_pen_size;
  
  drawspatial(rtAMinus2, rtAPlus2, grA2);
  drawspatial(rtBMinus2, rtBPlus2, grB2);
  drawobserver ( O2,  0);
%draw light
   path lpA[], lpB[];
  lpA2 :=  light_path(grA2, obs2, rotation, 1);
  lpB2 :=  light_path(grB2, obs2, rotation, 1);
  
  





  rad4 = abs(rA2 - 1/2[rtAMinus2,rtAPlus2]);
  rad3 = abs(rB2 - 1/2[rtBMinus2,rtBPlus2]);
  circle4 = fullcircle scaled (2*rad4) shifted 1/2[rtAMinus2,rtAPlus2];
  circle3 = fullcircle scaled (2*rad3) shifted 1/2[rtBMinus2,rtBPlus2];
  draw circle4 withcolor 0.75white;
  draw circle3 withcolor 0.75white;
  
  drawellipse_light(rA2,rB2);
  
  
%draw light
  drawlight(grA2,rotation);
  drawlight(grB2,rotation);
  drawspatial(rtAMinus2, rtAPlus2, grA2);
  drawspatial(rtBMinus2, rtBPlus2, grB2);
  drawobserver ( O2, 0);

 
  
  drawellipse_metric(rA2,rB2,obs2,Oangle2 ,Oangle2);%  -(90-Oangle2));

  
%  draw  metriced_point(rA2,obs2,Oangle2 ,Oangle2);%-(90-Oangle2));
%  draw  metriced_point(rB2,obs2,Oangle2 ,Oangle2); %-(90-Oangle2));

  %draw labels
  label.lrt(btex $A$ etex, grA2);
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
  clip currentpicture to bounding2;
  
endfig;


beginfig(9);
  
  save axisA, axisB;
  save o;
  save c;
  
  pair o; %origin
  o := (0u,0u);
    
  %drawellipse(A,B);
  path ellipse;
  ellipse = make_ellipse(A,B);
  %draw ellipse;
  
  %find times of the tangents to sound
  numeric sound_tangent_time[];
  %find locations of the tangents to sound
  pair    sound_tangent_loc[];

  pair path_start, path_end;
  path_start = point 0 of ellipse;
  path_end = point 360 of ellipse;
  
  sound_tangent_time[0]:= directiontime (-1,+1) of ellipse;
  sound_tangent_loc[0] := directionpoint(-1,+1) of ellipse;
  sound_tangent_time[1]:= directiontime (+1,+1) of ellipse;
  sound_tangent_loc[1] := directionpoint(+1,+1) of ellipse;
  sound_tangent_time[2]:= directiontime (+1,-1) of ellipse;
  sound_tangent_loc[2] := directionpoint(+1,-1) of ellipse;
  sound_tangent_time[3]:= directiontime (-1,-1) of ellipse;
  sound_tangent_loc[3] := directionpoint(-1,-1) of ellipse;
  %draw the points
  pickup pencircle scaled 2;
  for i = 0 upto 3:
    draw sound_tangent_loc[i];
  endfor
  
  show(" tangent 0 = "& decimal((sound_tangent_time[0])));
  show(" tangent 1 = "& decimal((sound_tangent_time[1])));
  show(" tangent 2 = "& decimal((sound_tangent_time[2])));
  show(" tangent 3 = "& decimal((sound_tangent_time[3])));
  
  numeric horizontal_tangent_time[];
  pair    horizontal_tangent_loc[];
  horizontal_tangent_time[0] = directiontime (1,0) of ellipse;
  horizontal_tangent_loc[0]  = directionpoint (1,0) of ellipse;
  horizontal_tangent_time[1] = directiontime (-1,0) of ellipse;
  horizontal_tangent_loc[1]  = directionpoint (-1,0) of ellipse;

  path projection_subsonic, projection_supersonic_leave;
  path projection_supersonic_approach; %
  %projection_supersonic_prim[]  ;
  %lost signal;
  path super_approach_lost, super_leave_lost, regular_lost;

  projection_subsonic := subpath (sound_tangent_time[2], sound_tangent_time[3]) of ellipse;
  projection_supersonic_leave = subpath ( sound_tangent_time[3],horizontal_tangent_time[1]) of ellipse;
  % horizontal_tangent_time[1]
  projection_supersonic_approach =
  (subpath (horizontal_tangent_time[1],0) of ellipse)..
  (subpath (sound_tangent_time[0],360) of ellipse);
  
  super_leave_lost := subpath (horizontal_tangent_time[0], sound_tangent_time[1]) of ellipse;
  super_approach_lost    := subpath (sound_tangent_time[2],horizontal_tangent_time[0] ) of ellipse;
  regular_lost   := subpath (sound_tangent_time[0], sound_tangent_time[1]) of ellipse;


%  projection_supersonic_prim[0]:= subpath (sound_tangent_time[3],0 ) of ellipse;
%  projection_supersonic_prim[1]:= subpath ( sound_tangent_time[0],360) of ellipse;%

%  projection_supersonic =projection_supersonic_prim[0]..projection_supersonic_prim[1];
  
  draw projection_subsonic withcolor black;
  draw projection_supersonic_leave withcolor red;
  draw projection_supersonic_approach withcolor blue;
%  draw projection_supersonic withcolor blue;
  
  pickup pencircle scaled (std_pen_size);
  draw super_approach_lost withcolor blue;
  draw super_leave_lost withcolor red;
  draw regular_lost withcolor 0.75white;
  
  %emph_projection(ellipse, 360, 0);
  
  

  
  
  pair axisA[], axisB[], projectATop[], projectABot[], projectBTop[], projectBBot[];;
  axisA[0] = o + (1u, -50u);
  axisA[1] = o + (1u, 50u);

  path obs;
  obs := axisA[0] --axisA[1];
  
  %find t- for outgoing wave
  pair tOut[];
  pair tRet[];

   %find tMinus
   tOut[1]= find_t_minus(sound_tangent_loc[2] , obs, 0, 1);
   tOut[2]= find_t_minus(sound_tangent_loc[3] , obs, 0, 1);
   tOut[3]= find_t_minus(sound_tangent_loc[1] , obs, 0, 1);
  
  %find tPlus
   tRet[1]= find_t_plus(sound_tangent_loc[2] , obs,  0, 1);
   tRet[2]= find_t_plus(sound_tangent_loc[0] , obs,  0, 1);

   
   draw  tOut[1]--sound_tangent_loc[2] dashed withdots scaled 0.25;
   draw  tOut[2]--sound_tangent_loc[3] dashed withdots scaled 0.25;
   draw  tOut[3]--sound_tangent_loc[1] dashed withdots scaled 0.25;
   draw  tRet[1]--sound_tangent_loc[2] dashed withdots scaled 0.25;
   draw  tRet[2]--sound_tangent_loc[0] dashed withdots scaled 0.25;
   

   draw obs;

   pair left_abit;
   left_abit := (-0.2u, 0);
   drawdblarrow (tOut1 - left_abit)--(tOut2-left_abit);
   drawdblarrow (tOut2 + left_abit)--(tOut3+left_abit);
   drawdblarrow (tRet1 + left_abit)--(tRet2+left_abit);

   label.rt(btex min excitation etex rotated 90,
          1/2[(tOut1 - left_abit),(tOut2-left_abit)]);

   label.lft(btex max excitation etex rotated 90,
          1/2[(tOut2 + left_abit),(tOut3+left_abit)]);

   label.lft(btex reflected signal etex rotated 90,
          1/2[(tRet1 + left_abit),(tRet2+left_abit)]);
   
  %draw light
 %  path  lp[];
 % lp[0] :=  light_path(sound_tangent_loc[2]  ,obs , 0, 1);
  

 % projectATop[0] = o + (1.25u, ypart( ellipsepoint(A,B, ( 1,0) ) ) );
 % projectATop[1] = o + ellipsepoint(A,B, ( 1,0) );
 % projectABot[0] = o + (1.25u, ypart( ellipsepoint(A,B, (-1,0) ) ) );
 % projectABot[1] = o + ellipsepoint(A,B, (-1,0) );

 % projectBTop[0] = o + ellipsepoint(A,B, ( 1,1 ))  + 5u*(1,1);
 % projectBTop[1] = o + ellipsepoint(A,B, ( 1,1 ));
 % projectBBot[0] = o + ellipsepoint(A,B, (-1,-1) ) + 5u*(1,1) ;
 % projectBBot[1] = o + ellipsepoint(A,B, (-1,-1) );

 % pair c; %centre
 % c = 1/2[A,B];
  
 % axisB[0] = axisA[0] rotatedabout(c,-135); 
 % axisB[1] = axisA[1] rotatedabout(c,-135);

 % pair intersectionB[];
 
 % intersectionB[0]  = whatever[ axisB[0], axisB[1] ] = whatever[ projectBTop[0],projectBTop[1]  ];
 % intersectionB[1]  = whatever[ axisB[0], axisB[1] ] = whatever[ projectBBot[0],projectBBot[1]  ];
  %numeric the_emax;
  %the_emax = ellipseymax(A,B);
%  ellipseymax(A,B);

 % mark_right_angle(axisB[0], intersectionB[0], projectBTop[1]);
 % mark_right_angle(axisB[0], intersectionB[1], projectBBot[1]);
 % mark_right_angle(axisA[0], projectATop[0],   projectATop[1]);
 % mark_right_angle(axisA[0], projectABot[0],   projectABot[1]);
  
 % draw axisA[0]--axisA[1] ;
 % draw axisB[0]--axisB[1] ;
 % 
 % draw projectATop[0]--projectATop[1] dashed withdots scaled 0.25;
 % draw projectABot[0]--projectABot[1] dashed withdots scaled 0.25;
 % draw intersectionB[0]--projectBTop[1] dashed withdots scaled 0.25; %intersectionBTop[0]--
 % draw intersectionB[1]--projectBBot[1] dashed withdots scaled 0.25;
  
  pickup pencircle scaled 4pt;
  draw A;
  draw B;
  
  %draw labels
  label.rt(btex $A$ etex, A);
  label.rt(btex $B$ etex, B);

  label.rt(btex Projection 1 etex, axisA[0]);
%  label.urt(btex Projection 2 etex, 1/2[axisB[0], axisB[1]] );
  clip currentpicture to bounding7;
 % setbounds currentpicture to bounding7;
endfig;

%eigenfig,based on figure 6


beginfig(10);

  save rotation, O, obs, rtAMinus, rtAPlus, rtBMinus, rtBPlus, rA, rB, o, circle, arc, rad, Btranslation, centre;
  
  numeric rotation;
  pair O[];  %observer locs
  pair rtAMinus[], rtAPlus[];
  pair rtBMinus[], rtBPlus[];
  pair centre;
  pair rA[], rB[];
  pair o;

  path obs[];
  path circle[];
  %path arc[];
  numeric rad[];
  
  o = (3u-xpart(tAMinus2),0);


  rA2 = (A+o) rotatedabout(tAMinus2+o, Oangle2);
  rB2 = (B+o) rotatedabout(tBMinus2+o, Oangle2);% + Btranslation;
  
  
  
  rotation :=  0;
  


  %draw observers
  O2  := (xpart(tAMinus2),3.5u)   + o;
  obs2 = observer(O2 ,  0);

  %find tMinus
  rtAMinus2 = find_t_minus(rA2, obs2, rotation+Oangle2, 0);
  rtBMinus2 = find_t_minus(rB2, obs2, rotation+Oangle2, 0);
  
  %find tPlus
  rtAPlus2 = find_t_plus(rA2, obs2, rotation+Oangle2, 0);
  rtBPlus2 = find_t_plus(rB2, obs2, rotation+Oangle2, 0);

  %find central point
  centre = find_local_origin(rB2, obs2, Oangle2, 1);

  save eigen,reigen, phi;
  pair eigen[], reigen[];
  numeric phi;
  phi = 2*Oangle2; %90 - 2*Oangle2;
  eigen1 =  rB2 rotatedabout(centre, -phi/2);
  eigen2 =  rtBPlus2 rotatedabout(centre, phi/2);
  reigen1 = eigen1 - (0, 2*ypart(eigen1-centre));
  reigen2 = eigen2 - (0, 2*ypart(eigen2-centre));
  eigen3 =  eigen1 rotatedabout(centre, -90);
  
  
  %draw circle;
 
  rad2    = abs(rB2 - centre);
  circle2 = fullcircle scaled (2*rad2) shifted centre;

  save horizontal_point;
  pair horizontal_point;
  horizontal_point = centre+ rad2 *(1,0);
  
  numeric rad_plus_abit;
  rad_plus_abit = rad2+0.2u;

  %numeric num;
  %num = make_circ_arc(rad_plus_abit);
  
  save arc, bigger_circle;
  path arc[];

  arc1 =make_circular_arc(centre, rad_plus_abit,(-phi/2),  phi);
  arc2 = make_circular_arc(centre, rad_plus_abit,(-90-phi/2),  phi);
  
  path bigger_circle;
  
  bigger_circle = fullcircle scaled (2*rad_plus_abit) shifted centre;
  
  %pair circle_arrow[];
  %circle_arrow1 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,phi/2) ;
  %circle_arrow2 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,-phi/2) ;
  %circle_arrow3 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,-90+phi/2) ;
  %circle_arrow4 = (centre + rad_plus_abit*(1,0)) rotatedabout(centre,-90-phi/2) ;

  %arc1 = buildcycle( ( rtAMinus1--(A+o)),circle1,  rA1, light_out(rA1,rotation+Oangle1) );
  %  clip currentpicture to arc1;


  %drawspatial(rtBMinus2, rtBPlus2, rB2);
 % drawobserver ( O2,  0);
%draw light
 %  path  lpB[];
 % lpB2 :=  light_path(rB2, obs2, rotation+Oangle2, 1);
  
  
  draw circle2 withcolor 0.75white;

  %drawarrow centre--rtBMinus2 withcolor 0.75white ;
  drawarrow centre--rtBPlus2 withcolor 0.75white;
  drawarrow centre--rB2 withcolor 0.75white;

  drawarrow centre--eigen1;
  drawarrow centre--eigen2;
  
  drawarrow eigen1--reigen1 withcolor red;
  drawarrow eigen2--reigen2 withcolor red;
  
  drawarrow arc1 withcolor blue;
  drawarrow arc2 withcolor blue;

  %drawarrow rtBMinus2--1/2[rtBMinus2,rB2];
  %draw (1/2[rtBMinus2,rB2] )--rB2;
 % drawarrow rB1--rtBPlus2;
  
  %drawcircle(rtBMinus2,rtBPlus2);
  
  draw centre--horizontal_point dashed withdots scaled 0.25;
  draw centre--eigen3 dashed withdots scaled 0.25;
  
 pickup pencircle scaled 4pt;
%  draw rA2;
  draw rB2 withcolor 0.75white;
  draw eigen1;
  draw eigen2;
  draw eigen3;
  draw reigen1;
  draw reigen2;
  
  mark_right_angle(eigen1,centre,eigen2);
  mark_angle(horizontal_point, centre,eigen1,1);
  
  
  pickup pencircle scaled 2pt;
 %
  %draw A+o;
  %pickup pencircle scaled 0pt;


  
  %draw labels
%  label.bot(btex $A$ etex, rA2);
  %label.rt(btex $B$ etex, rB2);

  %label.rt(btex Observer 2 etex, O2);
 % label.bot(btex Observer 2 etex,O2 );
  
 % label.rt(btex $\tau_A^{2-}$ etex, rtAMinus2);
  %label.lrt(btex $\lambda n$ etex, 1/2[rtBMinus2,rB2]);
  %label.urt(btex $\delta \bar{n}$ etex, 1/2[rtBPlus2,rB2]);
  label.urt(btex $ \gamma_1$ etex, rB2 );
  label.top(btex $\gamma_0$ etex, rtBPlus2);
  
  label.top(btex $\phi/2$ etex, (3/4[centre,horizontal_point]+(0.2mm,-1.1mm)));
  label.urt(btex $ e_1 = g_2g_1(e_1)$ etex,eigen1 ); %+ (-0.05u, 0.05u)
  label.lrt(btex $ g_1(e_1) $ etex, reigen1 ); %+ (-0.05u, 0.05u)
%  label.rt(btex $-\gamma_0$ etex, 1/4[rtBMinus2,rtBPlus2]);
  label.ulft(btex $e_0$ etex, eigen2 );
  label.lft(btex $g_1(e_0)$ etex, (reigen2 +  (-0.2u, -0.2u) ));
  label.lrt(btex $-e_0 = g_2g_1(e_0)$ etex, (eigen3 +  (-0.4u, -0.2u) ));
 % label.llft(btex $\tau_A^{2+}$ etex, rtAPlus2);
 % label.urt(btex $\tau_B^{2+}$ etex, rtBPlus2);

  label.lft(btex $0$ etex, 1/2[rtBMinus2,rtBPlus2]);
  
     save points;
  pair points[];

  points0 = A +(-3u,3.5u);
  points1 = points0+(0,1u);
  points2 = points0+(1u,0);
pickup pencircle scaled std_pen_size;
  drawarrow points0--points1;
  drawarrow points0--points2;

  label.top(btex $q_0$ etex, points1);
  label.rt(btex $q_1$ etex,points2 );
  
  %clip
  clip currentpicture to bounding8;
  
  

endfig;






end;

