%GNUPLOT Metapost output: Fri Aug 13 13:42:53 2010


warningcheck:=0;
defaultmpt:=mpt:=4;
th:=.6;
%% Have nice sharp joins on our lines
linecap:=butt;
linejoin:=mitered;

def scalepen expr n = pickup pencircle scaled (n*th) enddef;
def ptsize expr n = mpt:=n*defaultmpt enddef;


textmag:= 0.800;
vardef makepic(expr str) =
  if picture str : str scaled textmag
  % otherwise a string
  else: str infont defaultfont scaled (defaultscale*textmag)
  fi
enddef;

def infontsize(expr str, size) =
  infont str scaled (size / fontsize str)
enddef;

%font changes
verbatimtex
\def\setfont#1#2{%.
  \font\gpfont=#1 at #2pt
\gpfont}
\setfont{cmr10}{10.00}
etex

color currentcolor; currentcolor:=black;
color fillcolor;
boolean colorlines,dashedlines;
colorlines:=true;
dashedlines:=false;

def _wc = withpen currentpen withcolor currentcolor enddef;
def _ac = addto currentpicture enddef;
def _sms = scaled mpt shifted enddef;
% drawing point-types
def gpdraw (expr n, x, y) =
  if n<0: _ac contour fullcircle _sms (x,y)
  elseif (n=1) or (n=3):
    _ac doublepath ptpath[n] _sms (x,y) _wc;
    _ac doublepath ptpath[n] rotated 90 _sms (x,y) _wc
  elseif n<6: _ac doublepath ptpath[n] _sms (x,y) _wc
  else: _ac contour ptpath[n] _sms (x,y) _wc
  fi
enddef;

% the point shapes
path ptpath[];
%diamond
ptpath0 = ptpath6 = (-1/2,0)--(0,-1/2)--(1/2,0)--(0,1/2)--cycle;
% plus sign
ptpath1 = (-1/2,0)--(1/2,0);
% square
ptpath2 = ptpath7 = (-1/2,-1/2)--(1/2,-1/2)--(1/2,1/2)--(-1/2,1/2)--cycle;
% cross
ptpath3 := (-1/2,-1/2)--(1/2,1/2);
% circle:
ptpath4 = ptpath8:= fullcircle;
% triangle
ptpath5 = ptpath9 := (0,1/2)--(-1/2,-1/2)--(1/2,-1/2)--cycle;

def linetype expr n =
  currentcolor:= if colorlines : col[n] else: black fi;
  if n = -1 :
      drawoptions(withcolor currentcolor withpen (currentpen scaled .5));
  elseif n < 1 :
    drawoptions(_wc);
  else :
    drawoptions( if dashedlines: dashed lt[n] fi _wc);
  fi
enddef;

% dash patterns
picture lt[];
lt1=dashpattern(on 2 off 2); % dashes
lt2=dashpattern(on 2 off 2 on 0.2 off 2); %dash-dot
lt3=lt1 scaled 1.414;
lt4=lt2 scaled 1.414;
lt5=lt1 scaled 2;
lt6:=lt2 scaled 2;
lt7=dashpattern(on 0.2 off 2); %dots

color col[],cyan, magenta, yellow;
cyan=blue+green; magenta=red+blue;yellow=green+red;
col[-2]:=col[-1]:=col0:=black;
col1:=red;
col2:=(.2,.2,1); %blue
col3:=(1,.66,0); %orange
col4:=.85*green;
col5:=.9*magenta;
col6:=0.85*cyan;
col7:=.85*yellow;

%placing text
picture GPtext;
def put_text(expr pic, x, y, r, j) =
  GPtext:=makepic(pic);
  GPtext:=GPtext shifted
    if j = 1: (-(ulcorner GPtext + llcorner GPtext)/2)
    elseif j = 2: (-center GPtext)
    else: (-(urcorner GPtext + lrcorner GPtext)/2)
    fi
    rotated r;
  draw GPtext shifted (x,y)
enddef;

beginfig(6);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (341.7a,111.4b)--(358.3a,111.4b);
draw (723.8a,111.4b)--(707.2a,111.4b);
put_text( btex $-2\pi$ etex, 327.6a, 111.4b, 0, 3);
draw (341.7a,214.7b)--(358.3a,214.7b);
draw (723.8a,214.7b)--(707.2a,214.7b);
put_text( btex -$3\pi\over 2$ etex, 327.6a, 214.7b, 0, 3);
draw (341.7a,317.9b)--(358.3a,317.9b);
draw (723.8a,317.9b)--(707.2a,317.9b);
put_text( btex $-\pi$ etex, 327.6a, 317.9b, 0, 3);
draw (341.7a,421.2b)--(358.3a,421.2b);
draw (723.8a,421.2b)--(707.2a,421.2b);
put_text( btex -$\pi\over 2$ etex, 327.6a, 421.2b, 0, 3);
draw (341.7a,93.7b)--(341.7a,110.3b);
draw (341.7a,475.8b)--(341.7a,459.2b);
put_text( btex  4.8 etex, 341.7a, 64.4b, 0, 2);
draw (405.4a,93.7b)--(405.4a,110.3b);
draw (405.4a,475.8b)--(405.4a,459.2b);
put_text( btex  4.9 etex, 405.4a, 64.4b, 0, 2);
draw (469.1a,93.7b)--(469.1a,110.3b);
draw (469.1a,475.8b)--(469.1a,459.2b);
put_text( btex  5 etex, 469.1a, 64.4b, 0, 2);
draw (532.7a,93.7b)--(532.7a,110.3b);
draw (532.7a,475.8b)--(532.7a,459.2b);
put_text( btex  5.1 etex, 532.7a, 64.4b, 0, 2);
draw (596.4a,93.7b)--(596.4a,110.3b);
draw (596.4a,475.8b)--(596.4a,459.2b);
put_text( btex  5.2 etex, 596.4a, 64.4b, 0, 2);
draw (660.1a,93.7b)--(660.1a,110.3b);
draw (660.1a,475.8b)--(660.1a,459.2b);
put_text( btex  5.3 etex, 660.1a, 64.4b, 0, 2);
draw (723.8a,93.7b)--(723.8a,110.3b);
draw (723.8a,475.8b)--(723.8a,459.2b);
put_text( btex  5.4 etex, 723.8a, 64.4b, 0, 2);
draw (341.7a,475.8b)--(341.7a,93.7b)--(723.8a,93.7b)--(723.8a,475.8b)--(341.7a,475.8b);
put_text( btex phase etex, 256.5a, 284.7b, 90, 2);
linetype -2;
put_text( btex time ($\mu s$)  etex, 532.7a, 20.5b, 0, 2);
linetype -2;
linetype 0;
draw (344.0a,475.8b)--(347.4a,470.8b)--(350.8a,466.1b)--(354.3a,461.6b)--(357.7a,457.2b)
--(361.1a,453.1b)--(364.5a,449.1b)--(368.1a,445.1b)--(371.8a,441.0b)--(375.7a,436.9b)
--(379.9a,432.6b)--(384.0a,428.3b)--(388.1a,424.1b)--(392.3a,419.8b)--(396.4a,415.5b)
--(400.0a,411.5b)--(403.6a,407.5b)--(407.3a,403.3b)--(410.9a,399.0b)--(414.5a,394.5b)
--(418.1a,389.8b)--(421.3a,385.5b)--(424.5a,381.1b)--(427.7a,376.6b)--(430.9a,371.9b)
--(434.1a,367.2b)--(437.3a,362.4b)--(440.5a,357.6b)--(443.7a,352.8b)--(446.9a,348.0b)
--(450.0a,343.3b)--(453.2a,338.7b)--(456.4a,334.2b)--(459.6a,329.8b)--(462.8a,325.6b)
--(466.0a,321.4b)--(469.2a,317.4b)--(472.4a,313.4b)--(475.6a,309.5b)--(478.8a,305.7b)
--(482.0a,301.9b)--(485.1a,298.1b)--(488.4a,294.3b)--(491.6a,290.4b)--(494.8a,286.5b)
--(498.0a,282.6b)--(501.3a,278.6b)--(504.5a,274.5b)--(507.8a,270.4b)--(511.1a,266.1b)
--(514.4a,261.9b)--(517.8a,257.7b)--(521.1a,253.5b)--(524.4a,249.3b)--(527.7a,245.2b)
--(531.1a,241.0b)--(534.6a,236.9b)--(538.0a,232.9b)--(541.5a,228.9b)--(545.1a,224.9b)
--(548.8a,220.9b)--(552.8a,216.8b)--(556.8a,212.6b)--(561.1a,208.2b)--(565.5a,203.6b)
--(570.0a,199.1b)--(574.5a,194.6b)--(578.9a,189.9b)--(582.6a,186.0b)--(586.4a,181.9b)
--(590.1a,177.7b)--(593.8a,173.4b)--(597.5a,168.8b)--(601.2a,164.1b)--(604.5a,159.7b)
--(607.8a,155.2b)--(611.0a,150.4b)--(614.3a,145.4b)--(617.6a,140.2b)--(620.9a,134.8b)
--(624.1a,129.2b)--(627.4a,123.5b)--(630.7a,117.6b)--(634.0a,111.6b)--(637.2a,105.6b)
--(640.5a,99.6b)--(643.8a,93.7b);
linetype -2;
draw (341.7a,475.8b)--(341.7a,93.7b)--(723.8a,93.7b)--(723.8a,475.8b)--(341.7a,475.8b);
endfig;
end.
