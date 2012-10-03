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

beginfig(5);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (278.8a,93.7b)--(295.4a,93.7b);
draw (660.9a,93.7b)--(644.3a,93.7b);
put_text( btex -15 etex, 264.7a, 93.7b, 0, 3);
draw (278.8a,157.4b)--(295.4a,157.4b);
draw (660.9a,157.4b)--(644.3a,157.4b);
put_text( btex -10 etex, 264.7a, 157.4b, 0, 3);
draw (278.8a,221.1b)--(295.4a,221.1b);
draw (660.9a,221.1b)--(644.3a,221.1b);
put_text( btex -5 etex, 264.7a, 221.1b, 0, 3);
draw (278.8a,284.8b)--(295.4a,284.8b);
draw (660.9a,284.8b)--(644.3a,284.8b);
put_text( btex  0 etex, 264.7a, 284.8b, 0, 3);
draw (278.8a,348.4b)--(295.4a,348.4b);
draw (660.9a,348.4b)--(644.3a,348.4b);
put_text( btex  5 etex, 264.7a, 348.4b, 0, 3);
draw (278.8a,412.1b)--(295.4a,412.1b);
draw (660.9a,412.1b)--(644.3a,412.1b);
put_text( btex  10 etex, 264.7a, 412.1b, 0, 3);
draw (278.8a,475.8b)--(295.4a,475.8b);
draw (660.9a,475.8b)--(644.3a,475.8b);
put_text( btex  15 etex, 264.7a, 475.8b, 0, 3);
draw (278.8a,93.7b)--(278.8a,110.3b);
draw (278.8a,475.8b)--(278.8a,459.2b);
put_text( btex  0.6 etex, 278.8a, 64.4b, 0, 2);
draw (321.3a,93.7b)--(321.3a,110.3b);
draw (321.3a,475.8b)--(321.3a,459.2b);
put_text( btex  0.7 etex, 321.3a, 64.4b, 0, 2);
draw (363.7a,93.7b)--(363.7a,110.3b);
draw (363.7a,475.8b)--(363.7a,459.2b);
put_text( btex  0.8 etex, 363.7a, 64.4b, 0, 2);
draw (406.2a,93.7b)--(406.2a,110.3b);
draw (406.2a,475.8b)--(406.2a,459.2b);
put_text( btex  0.9 etex, 406.2a, 64.4b, 0, 2);
draw (448.6a,93.7b)--(448.6a,110.3b);
draw (448.6a,475.8b)--(448.6a,459.2b);
put_text( btex  1 etex, 448.6a, 64.4b, 0, 2);
draw (491.1a,93.7b)--(491.1a,110.3b);
draw (491.1a,475.8b)--(491.1a,459.2b);
put_text( btex  1.1 etex, 491.1a, 64.4b, 0, 2);
draw (533.5a,93.7b)--(533.5a,110.3b);
draw (533.5a,475.8b)--(533.5a,459.2b);
put_text( btex  1.2 etex, 533.5a, 64.4b, 0, 2);
draw (576.0a,93.7b)--(576.0a,110.3b);
draw (576.0a,475.8b)--(576.0a,459.2b);
put_text( btex  1.3 etex, 576.0a, 64.4b, 0, 2);
draw (618.4a,93.7b)--(618.4a,110.3b);
draw (618.4a,475.8b)--(618.4a,459.2b);
put_text( btex  1.4 etex, 618.4a, 64.4b, 0, 2);
draw (660.9a,93.7b)--(660.9a,110.3b);
draw (660.9a,475.8b)--(660.9a,459.2b);
put_text( btex  1.5 etex, 660.9a, 64.4b, 0, 2);
draw (278.8a,475.8b)--(278.8a,93.7b)--(660.9a,93.7b)--(660.9a,475.8b)--(278.8a,475.8b);
put_text( btex wall speed ($ms^{-1}$) etex, 193.6a, 284.7b, 90, 2);
linetype -2;
put_text( btex radius ($\mu m$) etex, 469.8a, 20.5b, 0, 2);
linetype -2;
linetype 0;
draw (625.5a,301.6b)--(630.1a,298.7b)--(633.9a,295.3b)--(636.6a,291.4b)--(637.9a,286.8b)
--(637.8a,281.5b)--(635.8a,275.4b)--(632.4a,269.1b)--(627.2a,262.0b)--(619.9a,254.0b)
--(610.2a,244.9b)--(600.2a,236.4b)--(588.3a,227.0b)--(578.6a,219.7b)--(569.4a,213.1b)
--(559.5a,206.1b)--(550.1a,199.7b)--(540.0a,192.8b)--(530.5a,186.6b)--(520.4a,180.0b)
--(511.2a,174.1b)--(501.6a,168.0b)--(491.4a,161.6b)--(482.4a,156.1b)--(472.5a,150.1b)
--(463.4a,144.8b)--(454.0a,139.4b)--(444.3a,134.0b)--(434.1a,128.8b)--(423.7a,123.7b)
--(414.2a,119.6b)--(404.5a,115.8b)--(397.2a,113.5b)--(389.8a,111.6b)--(383.7a,110.4b)
--(377.6a,109.8b)--(372.2a,109.6b)--(366.9a,110.0b)--(362.1a,110.8b)--(357.5a,112.2b)
--(352.8a,114.1b)--(348.9a,116.2b)--(345.0a,118.9b)--(341.1a,122.2b)--(337.4a,126.2b)
--(334.2a,130.1b)--(331.2a,134.5b)--(328.2a,139.5b)--(325.4a,145.1b)--(322.6a,151.3b)
--(320.3a,157.2b)--(318.1a,163.6b)--(316.1a,170.5b)--(314.1a,177.9b)--(312.3a,185.7b)
--(310.6a,193.9b)--(309.1a,202.6b)--(307.8a,211.7b)--(306.6a,221.1b)--(305.5a,230.8b)
--(304.7a,240.8b)--(304.0a,251.0b)--(303.5a,261.3b)--(303.2a,271.7b)--(303.0a,282.0b)
--(303.1a,292.4b)--(303.3a,302.6b)--(303.7a,312.6b)--(304.3a,322.4b)--(305.0a,331.8b)
--(305.9a,341.0b)--(307.0a,349.7b)--(308.2a,358.1b)--(309.6a,365.9b)--(311.1a,373.4b)
--(312.7a,380.3b)--(314.4a,386.8b)--(316.3a,392.7b)--(318.3a,398.4b)--(320.4a,403.6b)
--(322.7a,408.4b)--(325.1a,412.8b)--(327.7a,416.8b)--(330.4a,420.4b)--(333.3a,423.6b)
--(336.3a,426.3b)--(339.5a,428.6b)--(342.8a,430.5b)--(346.3a,431.9b)--(350.0a,432.9b)
--(353.9a,433.5b)--(358.0a,433.6b)--(362.3a,433.3b)--(366.9a,432.6b)--(371.7a,431.3b)
--(376.9a,429.6b)--(382.3a,427.3b)--(388.4a,424.4b)--(395.1a,420.7b)--(401.9a,416.5b)
--(408.7a,411.9b)--(415.6a,406.9b)--(422.1a,401.9b)--(428.6a,396.6b)--(434.8a,391.3b)
--(440.8a,385.9b)--(446.7a,380.3b)--(452.4a,374.7b)--(458.0a,368.9b)--(463.4a,363.0b)
--(468.7a,357.0b)--(473.7a,350.8b)--(478.4a,344.6b)--(482.9a,338.2b)--(487.0a,331.7b)
--(490.7a,325.2b)--(493.9a,318.6b)--(496.6a,312.0b)--(498.8a,305.3b)--(500.4a,298.6b)
--(501.4a,292.0b)--(501.8a,285.5b)--(501.6a,279.1b)--(500.7a,272.8b)--(499.3a,266.6b)
--(497.3a,260.4b)--(494.7a,254.4b)--(491.5a,248.5b)--(487.8a,242.7b)--(483.5a,237.0b)
--(478.7a,231.4b)--(474.2a,226.8b)--(469.3a,222.3b)--(464.1a,218.0b)--(458.5a,213.9b)
--(452.5a,209.9b)--(446.1a,206.2b)--(438.9a,202.7b)--(430.2a,199.3b)--(424.2a,197.6b)
--(418.8a,196.5b)--(413.4a,195.9b)--(408.8a,195.7b)--(404.2a,196.0b)--(399.7a,196.8b)
--(395.8a,197.9b)--(391.9a,199.4b)--(388.2a,201.3b)--(385.0a,203.4b)--(381.8a,205.9b)
--(378.8a,208.7b)--(375.9a,212.0b)--(373.5a,215.3b)--(371.2a,218.9b)--(369.0a,222.8b)
--(366.9a,227.0b)--(365.0a,231.5b)--(363.3a,236.4b)--(361.7a,241.5b)--(360.3a,246.9b)
--(359.1a,252.5b)--(358.1a,258.4b)--(357.3a,264.3b)--(356.8a,269.7b)--(356.4a,275.1b)
--(356.2a,280.5b)--(356.1a,286.0b)--(356.3a,291.4b)--(356.5a,296.8b)--(357.0a,302.1b)
--(357.6a,307.3b)--(358.4a,312.4b)--(359.3a,317.4b)--(360.4a,322.3b)--(361.7a,327.0b)
--(363.1a,331.5b)--(364.7a,335.9b)--(366.5a,340.1b)--(368.5a,344.0b)--(370.6a,347.8b)
--(373.0a,351.2b)--(375.4a,354.4b)--(378.1a,357.4b)--(381.0a,360.1b)--(384.1a,362.5b)
--(387.4a,364.6b)--(390.9a,366.5b)--(394.7a,368.0b)--(398.7a,369.3b)--(402.8a,370.2b)
--(407.2a,370.8b)--(412.2a,371.1b)--(417.6a,371.0b)--(422.9a,370.6b)--(429.9a,369.7b)
--(438.0a,368.1b)--(446.0a,366.1b)--(453.8a,363.9b)--(461.4a,361.5b)--(468.7a,359.0b)
--(475.9a,356.4b)--(482.9a,353.8b)--(489.6a,351.3b)--(496.7a,348.5b)--(503.5a,345.8b)
--(510.4a,343.1b)--(517.5a,340.3b)--(524.2a,337.6b)--(530.8a,335.1b)--(537.3a,332.5b)
--(544.1a,330.0b)--(551.0a,327.4b)--(558.0a,324.9b)--(564.8a,322.5b)--(571.6a,320.3b)
--(578.3a,318.1b)--(584.9a,316.0b)--(591.5a,314.0b)--(597.9a,312.0b)--(604.4a,310.0b)
--(610.8a,307.9b)--(617.0a,305.7b)--(622.7a,303.2b)--(627.9a,300.4b);
linetype -2;
draw (278.8a,475.8b)--(278.8a,93.7b)--(660.9a,93.7b)--(660.9a,475.8b)--(278.8a,475.8b);
endfig;
end.
