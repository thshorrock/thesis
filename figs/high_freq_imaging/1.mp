%GNUPLOT Metapost output: Mon May 24 18:20:46 2010


warningcheck:=0;
defaultmpt:=mpt:=4;
th:=.6;
%% Have nice sharp joins on our lines
linecap:=butt;
linejoin:=mitered;

def scalepen expr n = pickup pencircle scaled (n*th) enddef;
def ptsize expr n = mpt:=n*defaultmpt enddef;


textmag:= 1.000;
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
colorlines:=false;
dashedlines:=true;

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

beginfig(0);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (187.0a,117.1b)--(203.6a,117.1b);
draw (1155.7a,117.1b)--(1139.1a,117.1b);
put_text( btex -1 etex, 169.3a, 117.1b, 0, 3);
draw (187.0a,173.9b)--(203.6a,173.9b);
draw (1155.7a,173.9b)--(1139.1a,173.9b);
put_text( btex -0.8 etex, 169.3a, 173.9b, 0, 3);
draw (187.0a,230.6b)--(203.6a,230.6b);
draw (1155.7a,230.6b)--(1139.1a,230.6b);
put_text( btex -0.6 etex, 169.3a, 230.6b, 0, 3);
draw (187.0a,287.3b)--(203.6a,287.3b);
draw (1155.7a,287.3b)--(1139.1a,287.3b);
put_text( btex -0.4 etex, 169.3a, 287.3b, 0, 3);
draw (187.0a,344.1b)--(203.6a,344.1b);
draw (1155.7a,344.1b)--(1139.1a,344.1b);
put_text( btex -0.2 etex, 169.3a, 344.1b, 0, 3);
draw (187.0a,400.9b)--(203.6a,400.9b);
draw (1155.7a,400.9b)--(1139.1a,400.9b);
put_text( btex  0 etex, 169.3a, 400.9b, 0, 3);
draw (187.0a,457.6b)--(203.6a,457.6b);
draw (1155.7a,457.6b)--(1139.1a,457.6b);
put_text( btex  0.2 etex, 169.3a, 457.6b, 0, 3);
draw (187.0a,514.4b)--(203.6a,514.4b);
draw (1155.7a,514.4b)--(1139.1a,514.4b);
put_text( btex  0.4 etex, 169.3a, 514.4b, 0, 3);
draw (187.0a,571.1b)--(203.6a,571.1b);
draw (1155.7a,571.1b)--(1139.1a,571.1b);
put_text( btex  0.6 etex, 169.3a, 571.1b, 0, 3);
draw (187.0a,627.9b)--(203.6a,627.9b);
draw (1155.7a,627.9b)--(1139.1a,627.9b);
put_text( btex  0.8 etex, 169.3a, 627.9b, 0, 3);
draw (187.0a,684.6b)--(203.6a,684.6b);
draw (1155.7a,684.6b)--(1139.1a,684.6b);
put_text( btex  1 etex, 169.3a, 684.6b, 0, 3);
draw (187.0a,117.1b)--(187.0a,133.7b);
draw (187.0a,684.6b)--(187.0a,668.0b);
put_text( btex -10 etex, 187.0a, 80.5b, 0, 2);
draw (429.2a,117.1b)--(429.2a,133.7b);
draw (429.2a,684.6b)--(429.2a,668.0b);
put_text( btex -5 etex, 429.2a, 80.5b, 0, 2);
draw (671.4a,117.1b)--(671.4a,133.7b);
draw (671.4a,684.6b)--(671.4a,668.0b);
put_text( btex  0 etex, 671.4a, 80.5b, 0, 2);
draw (913.5a,117.1b)--(913.5a,133.7b);
draw (913.5a,684.6b)--(913.5a,668.0b);
put_text( btex  5 etex, 913.5a, 80.5b, 0, 2);
draw (1155.7a,117.1b)--(1155.7a,133.7b);
draw (1155.7a,684.6b)--(1155.7a,668.0b);
put_text( btex  10 etex, 1155.7a, 80.5b, 0, 2);
draw (187.0a,684.6b)--(187.0a,117.1b)--(1155.7a,117.1b)--(1155.7a,684.6b)--(187.0a,684.6b);
currentcolor:=0white;
put_text( btex $v/(m\cdot s^{-1})$ etex, 62.5a, 400.8b, 90, 2);
linetype -2;
currentcolor:=0white;
put_text( btex $v/(m\cdot s^{-1})$ etex, 671.3a, 25.6b, 0, 2);
linetype -2;
linetype 0;
linetype -2;
put_text( btex sin(x) etex, 1015.2a, 649.7b, 0, 3);
linetype 0;
draw (1032.9a,649.7b)--(1120.3a,649.7b);
draw (187.0a,555.2b)--(196.8a,504.3b)--(206.6a,449.2b)--(216.4a,392.1b)--(226.1a,335.4b)
--(235.9a,281.3b)--(245.7a,232.1b)--(255.5a,189.8b)--(265.3a,156.0b)--(275.1a,132.2b)
--(284.8a,119.3b)--(294.6a,117.9b)--(304.4a,128.0b)--(314.2a,149.2b)--(324.0a,180.6b)
--(333.8a,221.0b)--(343.6a,268.7b)--(353.3a,321.8b)--(363.1a,378.0b)--(372.9a,435.3b)
--(382.7a,491.1b)--(392.5a,543.2b)--(402.3a,589.6b)--(412.1a,628.3b)--(421.8a,657.7b)
--(431.6a,676.7b)--(441.4a,684.4b)--(451.2a,680.7b)--(461.0a,665.5b)--(470.8a,639.6b)
--(480.5a,604.0b)--(490.3a,560.1b)--(500.1a,509.7b)--(509.9a,454.9b)--(519.7a,397.9b)
--(529.5a,341.1b)--(539.3a,286.6b)--(549.0a,236.8b)--(558.8a,193.7b)--(568.6a,159.0b)
--(578.4a,134.1b)--(588.2a,120.1b)--(598.0a,117.5b)--(607.7a,126.5b)--(617.5a,146.6b)
--(627.3a,177.0b)--(637.1a,216.5b)--(646.9a,263.6b)--(656.7a,316.2b)--(666.5a,372.2b)
--(676.2a,429.5b)--(686.0a,485.5b)--(695.8a,538.1b)--(705.6a,585.2b)--(715.4a,624.7b)
--(725.2a,655.1b)--(735.0a,675.2b)--(744.7a,684.2b)--(754.5a,681.6b)--(764.3a,667.6b)
--(774.1a,642.7b)--(783.9a,608.0b)--(793.7a,564.9b)--(803.4a,515.1b)--(813.2a,460.6b)
--(823.0a,403.8b)--(832.8a,346.8b)--(842.6a,292.0b)--(852.4a,241.6b)--(862.2a,197.7b)
--(871.9a,162.1b)--(881.7a,136.2b)--(891.5a,121.0b)--(901.3a,117.3b)--(911.1a,125.0b)
--(920.9a,144.0b)--(930.6a,173.4b)--(940.4a,212.1b)--(950.2a,258.5b)--(960.0a,310.6b)
--(969.8a,366.4b)--(979.6a,423.7b)--(989.4a,479.9b)--(999.1a,533.0b)--(1008.9a,580.7b)
--(1018.7a,621.1b)--(1028.5a,652.5b)--(1038.3a,673.7b)--(1048.1a,683.8b)--(1057.9a,682.4b)
--(1067.6a,669.5b)--(1077.4a,645.7b)--(1087.2a,611.9b)--(1097.0a,569.6b)--(1106.8a,520.4b)
--(1116.6a,466.3b)--(1126.3a,409.6b)--(1136.1a,352.5b)--(1145.9a,297.4b)--(1155.7a,246.5b);
linetype -2;
draw (187.0a,684.6b)--(187.0a,117.1b)--(1155.7a,117.1b)--(1155.7a,684.6b)--(187.0a,684.6b);
endfig;
end.
