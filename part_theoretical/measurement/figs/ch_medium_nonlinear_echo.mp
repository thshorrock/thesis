%GNUPLOT Metapost output: Tue May 31 13:38:50 2016


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
  addto currentpicture also GPtext shifted (x,y)
enddef;

beginfig(1);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
linetype -2;
draw (211.2a,475.7b)--(211.2a,49.7b)--(637.3a,49.7b)--(637.3a,475.7b)--(211.2a,475.7b);
put_text( btex particle speed etex, 181.9a, 262.7b, -270, 2);
linetype -2;
put_text( btex distance etex, 424.2a, 20.5b, 0, 2);
linetype -2;
linetype 0;
currentcolor:=col0;
put_text( btex echo etex, 522.0a, 444.5b, 0, 3);
linetype 0;
draw (536.1a,444.5b)--(609.1a,444.5b);
draw (211.2a,262.7b)--(217.1a,275.0b)--(223.1a,287.2b)--(229.0a,299.3b)--(234.9a,311.3b)
--(240.8a,323.1b)--(246.6a,334.7b)--(252.5a,345.9b)--(258.3a,356.8b)--(264.0a,367.4b)
--(269.7a,377.5b)--(275.3a,387.2b)--(280.9a,396.3b)--(286.4a,404.9b)--(291.9a,413.0b)
--(297.2a,420.4b)--(302.5a,427.2b)--(307.7a,433.4b)--(312.8a,438.8b)--(317.8a,443.6b)
--(322.7a,447.6b)--(327.5a,450.9b)--(332.2a,453.4b)--(336.8a,455.1b)--(341.3a,456.1b)
--(345.7a,456.3b)--(349.9a,455.7b)--(354.1a,454.4b)--(358.2a,452.2b)--(362.1a,449.3b)
--(365.9a,445.7b)--(369.7a,441.3b)--(373.3a,436.2b)--(376.9a,430.4b)--(380.3a,423.9b)
--(383.6a,416.8b)--(386.9a,409.0b)--(390.0a,400.7b)--(393.1a,391.8b)--(396.1a,382.4b)
--(399.0a,372.5b)--(401.9a,362.2b)--(404.7a,351.4b)--(407.4a,340.3b)--(410.1a,328.9b)
--(412.7a,317.3b)--(415.3a,305.4b)--(417.9a,293.3b)--(420.5a,281.1b)--(423.0a,268.8b)
--(425.5a,256.6b)--(428.0a,244.3b)--(430.5a,232.1b)--(433.1a,220.0b)--(435.6a,208.1b)
--(438.2a,196.5b)--(440.8a,185.1b)--(443.5a,174.0b)--(446.2a,163.2b)--(448.9a,152.9b)
--(451.7a,143.0b)--(454.6a,133.6b)--(457.5a,124.7b)--(460.6a,116.4b)--(463.7a,108.6b)
--(466.9a,101.5b)--(470.2a,95.0b)--(473.6a,89.2b)--(477.1a,84.1b)--(480.7a,79.7b)
--(484.4a,76.1b)--(488.2a,73.2b)--(492.1a,71.0b)--(496.2a,69.7b)--(500.3a,69.1b)
--(504.6a,69.3b)--(509.0a,70.3b)--(513.5a,72.0b)--(518.2a,74.5b)--(522.9a,77.8b)
--(527.8a,81.8b)--(532.8a,86.6b)--(537.9a,92.0b)--(543.1a,98.2b)--(548.4a,105.0b)
--(553.8a,112.4b)--(559.3a,120.5b)--(564.9a,129.1b)--(570.6a,138.2b)--(576.4a,147.9b)
--(582.2a,158.0b)--(588.2a,168.6b)--(594.1a,179.5b)--(600.2a,190.7b)--(606.3a,202.3b)
--(612.4a,214.1b)--(618.6a,226.1b)--(624.8a,238.2b)--(631.1a,250.4b)--(637.3a,262.7b);
linetype -2;
draw (211.2a,475.7b)--(211.2a,49.7b)--(637.3a,49.7b)--(637.3a,475.7b)--(211.2a,475.7b);
linetype -2;
endfig;
end.
