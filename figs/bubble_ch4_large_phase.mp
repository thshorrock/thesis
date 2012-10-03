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

beginfig(7);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (292.3a,181.8b)--(308.9a,181.8b);
draw (674.5a,181.8b)--(657.9a,181.8b);
put_text( btex $-3\pi$ etex, 278.2a, 181.8b, 0, 3);
draw (292.3a,278.6b)--(308.9a,278.6b);
draw (674.5a,278.6b)--(657.9a,278.6b);
put_text( btex $-2\pi$ etex, 278.2a, 278.6b, 0, 3);
draw (292.3a,375.4b)--(308.9a,375.4b);
draw (674.5a,375.4b)--(657.9a,375.4b);
put_text( btex $-\pi$ etex, 278.2a, 375.4b, 0, 3);
draw (292.3a,472.2b)--(308.9a,472.2b);
draw (674.5a,472.2b)--(657.9a,472.2b);
put_text( btex 0 etex, 278.2a, 472.2b, 0, 3);
draw (292.3a,93.7b)--(292.3a,110.3b);
draw (292.3a,475.8b)--(292.3a,459.2b);
put_text( btex  4.8 etex, 292.3a, 64.4b, 0, 2);
draw (356.0a,93.7b)--(356.0a,110.3b);
draw (356.0a,475.8b)--(356.0a,459.2b);
put_text( btex  4.9 etex, 356.0a, 64.4b, 0, 2);
draw (419.7a,93.7b)--(419.7a,110.3b);
draw (419.7a,475.8b)--(419.7a,459.2b);
put_text( btex  5 etex, 419.7a, 64.4b, 0, 2);
draw (483.4a,93.7b)--(483.4a,110.3b);
draw (483.4a,475.8b)--(483.4a,459.2b);
put_text( btex  5.1 etex, 483.4a, 64.4b, 0, 2);
draw (547.1a,93.7b)--(547.1a,110.3b);
draw (547.1a,475.8b)--(547.1a,459.2b);
put_text( btex  5.2 etex, 547.1a, 64.4b, 0, 2);
draw (610.8a,93.7b)--(610.8a,110.3b);
draw (610.8a,475.8b)--(610.8a,459.2b);
put_text( btex  5.3 etex, 610.8a, 64.4b, 0, 2);
draw (674.5a,93.7b)--(674.5a,110.3b);
draw (674.5a,475.8b)--(674.5a,459.2b);
put_text( btex  5.4 etex, 674.5a, 64.4b, 0, 2);
draw (292.3a,475.8b)--(292.3a,93.7b)--(674.5a,93.7b)--(674.5a,475.8b)--(292.3a,475.8b);
put_text( btex phase etex, 207.1a, 284.7b, 90, 2);
linetype -2;
put_text( btex time ($\mu s$) etex, 483.4a, 20.5b, 0, 2);
linetype -2;
linetype 0;
draw (292.9a,475.8b)--(298.8a,473.3b)--(304.7a,470.5b)--(310.6a,467.1b)--(315.9a,463.8b)
--(321.1a,459.9b)--(326.4a,455.7b)--(331.6a,451.1b)--(335.9a,447.2b)--(340.3a,443.2b)
--(343.3a,440.5b)--(345.8a,438.3b)--(348.4a,436.2b)--(350.6a,434.5b)--(352.8a,432.8b)
--(354.7a,431.4b)--(356.6a,430.1b)--(358.2a,429.0b)--(359.8a,428.0b)--(361.4a,427.0b)
--(362.8a,426.2b)--(364.2a,425.5b)--(365.5a,424.8b)--(366.8a,424.2b)--(368.0a,423.5b)
--(369.3a,422.9b)--(370.5a,422.4b)--(371.6a,421.9b)--(372.8a,421.4b)--(373.6a,421.0b)
--(374.4a,420.7b)--(375.1a,420.4b)--(375.7a,420.1b)--(376.3a,419.8b)--(376.9a,419.5b)
--(377.4a,419.2b)--(377.9a,418.9b)--(378.5a,418.6b)--(378.9a,418.4b)--(379.4a,418.1b)
--(379.8a,417.7b)--(380.2a,417.4b)--(380.6a,417.0b)--(381.0a,416.7b)--(381.4a,416.3b)
--(381.8a,415.8b)--(382.2a,415.3b)--(382.5a,414.7b)--(382.8a,414.1b)--(383.2a,413.4b)
--(383.5a,412.6b)--(383.8a,411.7b)--(384.2a,410.6b)--(384.5a,409.2b)--(384.8a,407.6b)
--(385.2a,405.5b)--(385.5a,403.0b)--(385.9a,399.8b)--(386.2a,395.7b)--(386.5a,390.6b)
--(386.9a,384.3b)--(387.2a,377.3b)--(387.5a,370.1b)--(387.9a,363.5b)--(388.2a,358.0b)
--(388.5a,353.5b)--(388.9a,349.9b)--(389.2a,347.2b)--(389.5a,345.0b)--(389.9a,343.2b)
--(390.2a,341.7b)--(390.6a,340.5b)--(390.9a,339.5b)--(391.2a,338.7b)--(391.6a,337.9b)
--(391.9a,337.3b)--(392.3a,336.7b)--(392.6a,336.2b)--(393.0a,335.7b)--(393.4a,335.3b)
--(393.8a,334.9b)--(394.2a,334.6b)--(394.6a,334.3b)--(395.0a,334.0b)--(395.4a,333.7b)
--(395.9a,333.4b)--(396.4a,333.1b)--(396.9a,332.9b)--(397.4a,332.6b)--(397.9a,332.4b)
--(398.5a,332.1b)--(399.2a,331.9b)--(399.8a,331.6b)--(400.6a,331.3b)--(401.4a,331.0b)
--(402.3a,330.7b)--(403.3a,330.3b)--(404.3a,329.9b)--(405.3a,329.5b)--(406.4a,329.1b)
--(407.5a,328.7b)--(408.5a,328.2b)--(409.7a,327.7b)--(410.8a,327.2b)--(412.0a,326.6b)
--(413.2a,326.0b)--(414.5a,325.3b)--(415.8a,324.4b)--(417.2a,323.5b)--(418.6a,322.4b)
--(420.1a,321.1b)--(421.7a,319.6b)--(423.3a,317.6b)--(425.0a,315.2b)--(426.7a,312.0b)
--(428.4a,307.5b)--(430.2a,301.0b)--(432.1a,291.8b)--(433.9a,280.0b)--(435.7a,268.1b)
--(437.5a,258.6b)--(439.3a,251.8b)--(441.1a,247.0b)--(443.0a,243.5b)--(444.8a,240.8b)
--(446.6a,238.7b)--(448.4a,236.9b)--(450.2a,235.4b)--(451.8a,234.3b)--(453.3a,233.3b)
--(454.9a,232.4b)--(456.4a,231.5b)--(458.0a,230.7b)--(459.6a,229.9b)--(461.3a,229.1b)
--(463.3a,228.2b)--(464.6a,227.6b)--(465.8a,227.1b)--(467.0a,226.5b)--(468.0a,226.1b)
--(468.9a,225.6b)--(469.9a,225.1b)--(470.8a,224.6b)--(471.6a,224.1b)--(472.5a,223.6b)
--(473.2a,223.1b)--(474.0a,222.5b)--(474.7a,221.9b)--(475.4a,221.2b)--(476.1a,220.5b)
--(476.8a,219.7b)--(477.4a,218.8b)--(478.1a,217.8b)--(478.7a,216.6b)--(479.4a,215.1b)
--(480.0a,213.4b)--(480.7a,211.3b)--(481.3a,208.7b)--(482.0a,205.5b)--(482.7a,201.5b)
--(483.2a,197.1b)--(483.8a,192.1b)--(484.4a,186.4b)--(485.0a,180.4b)--(485.5a,174.6b)
--(486.1a,169.2b)--(486.7a,164.6b)--(487.3a,160.6b)--(487.9a,157.4b)--(488.5a,154.7b)
--(489.1a,152.4b)--(489.7a,150.5b)--(490.3a,149.0b)--(490.9a,147.6b)--(491.6a,146.4b)
--(492.2a,145.4b)--(492.9a,144.4b)--(493.6a,143.6b)--(494.3a,142.9b)--(495.0a,142.2b)
--(495.7a,141.6b)--(496.5a,141.0b)--(497.3a,140.4b)--(498.1a,139.9b)--(499.0a,139.4b)
--(499.9a,138.9b)--(500.8a,138.4b)--(501.8a,137.9b)--(502.9a,137.3b)--(504.1a,136.7b)
--(505.3a,136.2b)--(506.9a,135.5b)--(508.7a,134.6b)--(510.6a,133.7b)--(512.4a,132.8b)
--(514.3a,131.9b)--(516.1a,130.9b)--(518.0a,129.9b)--(519.9a,128.8b)--(521.8a,127.7b)
--(523.9a,126.5b)--(526.0a,125.2b)--(528.2a,123.9b)--(530.6a,122.4b)--(532.9a,120.9b)
--(535.4a,119.3b)--(537.9a,117.7b)--(540.7a,115.9b)--(543.7a,114.1b)--(546.9a,112.2b)
--(550.3a,110.4b)--(553.8a,108.5b)--(557.5a,106.7b)--(561.5a,105.0b)--(565.6a,103.4b)
--(570.0a,101.8b)--(574.7a,100.2b)--(579.7a,98.6b)--(585.1a,97.0b)--(590.7a,95.4b)
--(596.4a,93.7b);
linetype -2;
draw (292.3a,475.8b)--(292.3a,93.7b)--(674.5a,93.7b)--(674.5a,475.8b)--(292.3a,475.8b);
endfig;
end.
