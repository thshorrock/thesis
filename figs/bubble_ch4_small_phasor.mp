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

beginfig(4);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (292.9a,93.7b)--(309.5a,93.7b);
draw (675.0a,93.7b)--(658.4a,93.7b);
put_text( btex -0.2 etex, 278.8a, 93.7b, 0, 3);
draw (292.9a,141.5b)--(309.5a,141.5b);
draw (675.0a,141.5b)--(658.4a,141.5b);
put_text( btex -0.15 etex, 278.8a, 141.5b, 0, 3);
draw (292.9a,189.2b)--(309.5a,189.2b);
draw (675.0a,189.2b)--(658.4a,189.2b);
put_text( btex -0.1 etex, 278.8a, 189.2b, 0, 3);
draw (292.9a,237.0b)--(309.5a,237.0b);
draw (675.0a,237.0b)--(658.4a,237.0b);
put_text( btex -0.05 etex, 278.8a, 237.0b, 0, 3);
draw (292.9a,284.8b)--(309.5a,284.8b);
draw (675.0a,284.8b)--(658.4a,284.8b);
put_text( btex  0 etex, 278.8a, 284.8b, 0, 3);
draw (292.9a,332.5b)--(309.5a,332.5b);
draw (675.0a,332.5b)--(658.4a,332.5b);
put_text( btex  0.05 etex, 278.8a, 332.5b, 0, 3);
draw (292.9a,380.3b)--(309.5a,380.3b);
draw (675.0a,380.3b)--(658.4a,380.3b);
put_text( btex  0.1 etex, 278.8a, 380.3b, 0, 3);
draw (292.9a,428.0b)--(309.5a,428.0b);
draw (675.0a,428.0b)--(658.4a,428.0b);
put_text( btex  0.15 etex, 278.8a, 428.0b, 0, 3);
draw (292.9a,475.8b)--(309.5a,475.8b);
draw (675.0a,475.8b)--(658.4a,475.8b);
put_text( btex  0.2 etex, 278.8a, 475.8b, 0, 3);
draw (292.9a,93.7b)--(292.9a,110.3b);
draw (292.9a,475.8b)--(292.9a,459.2b);
put_text( btex  0.985 etex, 292.9a, 64.4b, 0, 2);
draw (356.6a,93.7b)--(356.6a,110.3b);
draw (356.6a,475.8b)--(356.6a,459.2b);
put_text( btex  0.99 etex, 356.6a, 64.4b, 0, 2);
draw (420.3a,93.7b)--(420.3a,110.3b);
draw (420.3a,475.8b)--(420.3a,459.2b);
put_text( btex  0.995 etex, 420.3a, 64.4b, 0, 2);
draw (483.9a,93.7b)--(483.9a,110.3b);
draw (483.9a,475.8b)--(483.9a,459.2b);
put_text( btex  1 etex, 483.9a, 64.4b, 0, 2);
draw (547.6a,93.7b)--(547.6a,110.3b);
draw (547.6a,475.8b)--(547.6a,459.2b);
put_text( btex  1.005 etex, 547.6a, 64.4b, 0, 2);
draw (611.3a,93.7b)--(611.3a,110.3b);
draw (611.3a,475.8b)--(611.3a,459.2b);
put_text( btex  1.01 etex, 611.3a, 64.4b, 0, 2);
draw (675.0a,93.7b)--(675.0a,110.3b);
draw (675.0a,475.8b)--(675.0a,459.2b);
put_text( btex  1.015 etex, 675.0a, 64.4b, 0, 2);
draw (292.9a,475.8b)--(292.9a,93.7b)--(675.0a,93.7b)--(675.0a,475.8b)--(292.9a,475.8b);
put_text( btex wall speed ($ms^{-1}$) etex, 179.5a, 284.7b, 90, 2);
linetype -2;
put_text( btex radius ($\mu m$) etex, 483.9a, 20.5b, 0, 2);
linetype -2;
linetype 0;
draw (669.2a,254.0b)--(666.5a,240.5b)--(662.8a,227.3b)--(658.3a,214.3b)--(652.8a,201.7b)
--(646.4a,189.5b)--(639.1a,177.9b)--(631.1a,166.9b)--(622.2a,156.6b)--(612.7a,147.0b)
--(602.5a,138.4b)--(591.7a,130.6b)--(580.4a,123.8b)--(568.0a,117.8b)--(554.9a,112.9b)
--(540.7a,109.0b)--(525.3a,106.5b)--(509.9a,105.7b)--(494.4a,106.4b)--(479.1a,108.8b)
--(464.0a,112.6b)--(451.2a,117.1b)--(438.6a,122.6b)--(426.6a,129.1b)--(415.0a,136.4b)
--(404.1a,144.4b)--(393.7a,153.0b)--(385.2a,161.0b)--(377.2a,169.3b)--(369.8a,177.8b)
--(362.9a,186.5b)--(356.6a,195.3b)--(351.0a,204.1b)--(345.9a,212.9b)--(341.4a,221.7b)
--(337.4a,230.3b)--(334.1a,238.8b)--(331.3a,247.1b)--(329.0a,255.2b)--(327.3a,263.1b)
--(326.1a,270.9b)--(325.5a,278.4b)--(325.3a,285.8b)--(325.6a,293.0b)--(326.4a,300.0b)
--(327.6a,306.9b)--(329.4a,313.8b)--(331.5a,320.5b)--(334.2a,327.3b)--(337.3a,334.0b)
--(340.8a,340.7b)--(344.8a,347.4b)--(349.3a,354.1b)--(354.2a,360.9b)--(359.7a,367.6b)
--(365.7a,374.5b)--(372.1a,381.3b)--(379.1a,388.0b)--(386.5a,394.6b)--(394.3a,401.1b)
--(402.6a,407.3b)--(411.7a,413.6b)--(421.1a,419.5b)--(431.0a,425.0b)--(441.5a,430.2b)
--(452.7a,435.0b)--(464.4a,439.1b)--(477.4a,442.8b)--(490.8a,445.6b)--(505.4a,447.5b)
--(520.7a,448.0b)--(535.9a,447.1b)--(550.9a,444.7b)--(565.7a,440.8b)--(577.7a,436.3b)
--(589.3a,430.8b)--(600.4a,424.2b)--(610.9a,416.6b)--(620.9a,408.1b)--(630.1a,398.6b)
--(637.6a,389.5b)--(644.5a,379.8b)--(650.6a,369.4b)--(656.0a,358.5b)--(660.7a,347.2b)
--(664.6a,335.4b)--(667.7a,323.2b)--(669.9a,310.8b)--(671.2a,298.1b)--(671.7a,285.2b)
--(671.3a,272.2b)--(670.0a,259.3b)--(667.8a,246.3b);
linetype -2;
draw (292.9a,475.8b)--(292.9a,93.7b)--(675.0a,93.7b)--(675.0a,475.8b)--(292.9a,475.8b);
endfig;
end.
