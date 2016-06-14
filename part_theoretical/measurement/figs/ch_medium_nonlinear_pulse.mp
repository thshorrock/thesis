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

beginfig(0);
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
put_text( btex pulse etex, 522.0a, 444.5b, 0, 3);
linetype 0;
draw (536.1a,444.5b)--(609.1a,444.5b);
draw (211.2a,262.7b)--(215.5a,275.0b)--(219.8a,287.2b)--(224.1a,299.3b)--(228.4a,311.3b)
--(232.7a,323.1b)--(237.0a,334.7b)--(241.3a,345.9b)--(245.6a,356.8b)--(249.9a,367.4b)
--(254.2a,377.5b)--(258.5a,387.2b)--(262.8a,396.3b)--(267.2a,404.9b)--(271.5a,413.0b)
--(275.8a,420.4b)--(280.1a,427.2b)--(284.4a,433.4b)--(288.7a,438.8b)--(293.0a,443.6b)
--(297.3a,447.6b)--(301.6a,450.9b)--(305.9a,453.4b)--(310.2a,455.1b)--(314.5a,456.1b)
--(318.8a,456.3b)--(323.1a,455.7b)--(327.4a,454.4b)--(331.7a,452.2b)--(336.0a,449.3b)
--(340.3a,445.7b)--(344.6a,441.3b)--(348.9a,436.2b)--(353.2a,430.4b)--(357.5a,423.9b)
--(361.8a,416.8b)--(366.1a,409.0b)--(370.4a,400.7b)--(374.8a,391.8b)--(379.1a,382.4b)
--(383.4a,372.5b)--(387.7a,362.2b)--(392.0a,351.4b)--(396.3a,340.3b)--(400.6a,328.9b)
--(404.9a,317.3b)--(409.2a,305.4b)--(413.5a,293.3b)--(417.8a,281.1b)--(422.1a,268.8b)
--(426.4a,256.6b)--(430.7a,244.3b)--(435.0a,232.1b)--(439.3a,220.0b)--(443.6a,208.1b)
--(447.9a,196.5b)--(452.2a,185.1b)--(456.5a,174.0b)--(460.8a,163.2b)--(465.1a,152.9b)
--(469.4a,143.0b)--(473.7a,133.6b)--(478.1a,124.7b)--(482.4a,116.4b)--(486.7a,108.6b)
--(491.0a,101.5b)--(495.3a,95.0b)--(499.6a,89.2b)--(503.9a,84.1b)--(508.2a,79.7b)
--(512.5a,76.1b)--(516.8a,73.2b)--(521.1a,71.0b)--(525.4a,69.7b)--(529.7a,69.1b)
--(534.0a,69.3b)--(538.3a,70.3b)--(542.6a,72.0b)--(546.9a,74.5b)--(551.2a,77.8b)
--(555.5a,81.8b)--(559.8a,86.6b)--(564.1a,92.0b)--(568.4a,98.2b)--(572.7a,105.0b)
--(577.0a,112.4b)--(581.3a,120.5b)--(585.7a,129.1b)--(590.0a,138.2b)--(594.3a,147.9b)
--(598.6a,158.0b)--(602.9a,168.6b)--(607.2a,179.5b)--(611.5a,190.7b)--(615.8a,202.3b)
--(620.1a,214.1b)--(624.4a,226.1b)--(628.7a,238.2b)--(633.0a,250.4b)--(637.3a,262.7b);
linetype -2;
draw (211.2a,475.7b)--(211.2a,49.7b)--(637.3a,49.7b)--(637.3a,475.7b)--(211.2a,475.7b);
linetype -2;
endfig;
end.
