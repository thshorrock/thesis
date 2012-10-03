%GNUPLOT Metapost output: Thu May 27 16:15:38 2010


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

beginfig(0);
w:=5.000in;h:=3.000in;
a:=w/1200.0;b:=h/720.0;
scalepen 1; ptsize 1.000;linetype -2;
draw (327.1a,181.6b)--(343.7a,181.6b);
draw (657.4a,181.6b)--(640.8a,181.6b);
put_text( btex  0.1 etex, 313.0a, 181.6b, 0, 3);
draw (327.1a,218.4b)--(335.4a,218.4b);
draw (657.4a,218.4b)--(649.1a,218.4b);
draw (327.1a,240.0b)--(335.4a,240.0b);
draw (657.4a,240.0b)--(649.1a,240.0b);
draw (327.1a,255.3b)--(335.4a,255.3b);
draw (657.4a,255.3b)--(649.1a,255.3b);
draw (327.1a,267.1b)--(335.4a,267.1b);
draw (657.4a,267.1b)--(649.1a,267.1b);
draw (327.1a,276.8b)--(335.4a,276.8b);
draw (657.4a,276.8b)--(649.1a,276.8b);
draw (327.1a,285.0b)--(335.4a,285.0b);
draw (657.4a,285.0b)--(649.1a,285.0b);
draw (327.1a,292.1b)--(335.4a,292.1b);
draw (657.4a,292.1b)--(649.1a,292.1b);
draw (327.1a,298.3b)--(335.4a,298.3b);
draw (657.4a,298.3b)--(649.1a,298.3b);
draw (327.1a,303.9b)--(343.7a,303.9b);
draw (657.4a,303.9b)--(640.8a,303.9b);
put_text( btex  1 etex, 313.0a, 303.9b, 0, 3);
draw (327.1a,340.8b)--(335.4a,340.8b);
draw (657.4a,340.8b)--(649.1a,340.8b);
draw (327.1a,362.3b)--(335.4a,362.3b);
draw (657.4a,362.3b)--(649.1a,362.3b);
draw (327.1a,377.6b)--(335.4a,377.6b);
draw (657.4a,377.6b)--(649.1a,377.6b);
draw (327.1a,389.5b)--(335.4a,389.5b);
draw (657.4a,389.5b)--(649.1a,389.5b);
draw (327.1a,399.1b)--(335.4a,399.1b);
draw (657.4a,399.1b)--(649.1a,399.1b);
draw (327.1a,407.3b)--(335.4a,407.3b);
draw (657.4a,407.3b)--(649.1a,407.3b);
draw (327.1a,414.4b)--(335.4a,414.4b);
draw (657.4a,414.4b)--(649.1a,414.4b);
draw (327.1a,420.7b)--(335.4a,420.7b);
draw (657.4a,420.7b)--(649.1a,420.7b);
draw (327.1a,426.3b)--(343.7a,426.3b);
draw (657.4a,426.3b)--(640.8a,426.3b);
put_text( btex  10 etex, 313.0a, 426.3b, 0, 3);
draw (327.1a,463.1b)--(335.4a,463.1b);
draw (657.4a,463.1b)--(649.1a,463.1b);
draw (327.1a,484.7b)--(335.4a,484.7b);
draw (657.4a,484.7b)--(649.1a,484.7b);
draw (327.1a,499.9b)--(335.4a,499.9b);
draw (657.4a,499.9b)--(649.1a,499.9b);
draw (327.1a,511.8b)--(335.4a,511.8b);
draw (657.4a,511.8b)--(649.1a,511.8b);
draw (327.1a,181.6b)--(327.1a,198.2b);
draw (327.1a,511.8b)--(327.1a,495.2b);
put_text( btex  1 etex, 327.1a, 152.3b, 0, 2);
draw (376.8a,181.6b)--(376.8a,189.9b);
draw (376.8a,511.8b)--(376.8a,503.5b);
draw (405.9a,181.6b)--(405.9a,189.9b);
draw (405.9a,511.8b)--(405.9a,503.5b);
draw (426.5a,181.6b)--(426.5a,189.9b);
draw (426.5a,511.8b)--(426.5a,503.5b);
draw (442.5a,181.6b)--(442.5a,189.9b);
draw (442.5a,511.8b)--(442.5a,503.5b);
draw (455.6a,181.6b)--(455.6a,189.9b);
draw (455.6a,511.8b)--(455.6a,503.5b);
draw (466.7a,181.6b)--(466.7a,189.9b);
draw (466.7a,511.8b)--(466.7a,503.5b);
draw (476.2a,181.6b)--(476.2a,189.9b);
draw (476.2a,511.8b)--(476.2a,503.5b);
draw (484.7a,181.6b)--(484.7a,189.9b);
draw (484.7a,511.8b)--(484.7a,503.5b);
draw (492.3a,181.6b)--(492.3a,198.2b);
draw (492.3a,511.8b)--(492.3a,495.2b);
put_text( btex  10 etex, 492.3a, 152.3b, 0, 2);
draw (542.0a,181.6b)--(542.0a,189.9b);
draw (542.0a,511.8b)--(542.0a,503.5b);
draw (571.0a,181.6b)--(571.0a,189.9b);
draw (571.0a,511.8b)--(571.0a,503.5b);
draw (591.7a,181.6b)--(591.7a,189.9b);
draw (591.7a,511.8b)--(591.7a,503.5b);
draw (607.7a,181.6b)--(607.7a,189.9b);
draw (607.7a,511.8b)--(607.7a,503.5b);
draw (620.8a,181.6b)--(620.8a,189.9b);
draw (620.8a,511.8b)--(620.8a,503.5b);
draw (631.8a,181.6b)--(631.8a,189.9b);
draw (631.8a,511.8b)--(631.8a,503.5b);
draw (641.4a,181.6b)--(641.4a,189.9b);
draw (641.4a,511.8b)--(641.4a,503.5b);
draw (649.8a,181.6b)--(649.8a,189.9b);
draw (649.8a,511.8b)--(649.8a,503.5b);
draw (657.4a,181.6b)--(657.4a,198.2b);
draw (657.4a,511.8b)--(657.4a,495.2b);
put_text( btex  100 etex, 657.4a, 152.3b, 0, 2);
draw (327.1a,511.8b)--(327.1a,181.6b)--(657.4a,181.6b)--(657.4a,511.8b)--(327.1a,511.8b);
put_text( btex $\omega_i/\omega_d$ etex, 263.0a, 346.7b, 90, 2);
linetype -2;
put_text( btex Range (\%) etex, 492.2a, 108.4b, 0, 2);
linetype -2;
linetype 0;
linetype -2;
put_text( btex 1 cycle etex, 391.0a, 60.6b, 0, 3);
linetype 0;
draw (405.1a,60.6b)--(478.1a,60.6b);
draw (657.3a,181.6b)--(649.9a,218.4b)--(614.2a,240.0b)--(580.5a,255.3b)--(551.9a,267.1b)
--(527.6a,276.8b)--(506.6a,285.0b)--(488.2a,292.1b)--(471.8a,298.3b)--(457.0a,303.9b)
--(443.6a,309.0b)--(431.3a,313.6b)--(420.0a,317.9b)--(409.5a,321.8b)--(399.7a,325.5b)
--(390.5a,328.9b)--(381.9a,332.1b)--(373.8a,335.2b)--(366.1a,338.0b)--(358.7a,340.8b)
--(351.8a,343.4b)--(345.1a,345.8b)--(338.8a,348.2b)--(332.7a,350.5b)--(327.1a,352.5b);
linetype 1;
linetype -2;
put_text( btex 2 cycles etex, 391.0a, 31.3b, 0, 3);
linetype 1;
draw (405.1a,31.3b)--(478.1a,31.3b);
draw (657.3a,181.6b)--(657.3a,218.4b)--(657.3a,240.0b)--(649.9a,255.3b)--(632.6a,267.1b)
--(614.2a,276.8b)--(596.7a,285.0b)--(580.5a,292.1b)--(565.6a,298.3b)--(551.9a,303.9b)
--(539.3a,309.0b)--(527.6a,313.6b)--(516.8a,317.9b)--(506.6a,321.8b)--(497.1a,325.5b)
--(488.2a,328.9b)--(479.8a,332.1b)--(471.8a,335.2b)--(464.2a,338.0b)--(457.0a,340.8b)
--(450.2a,343.4b)--(443.6a,345.8b)--(437.4a,348.2b)--(431.3a,350.5b)--(425.6a,352.6b)
--(420.0a,354.7b)--(414.7a,356.7b)--(409.5a,358.6b)--(404.5a,360.5b)--(399.7a,362.3b)
--(395.1a,364.1b)--(390.5a,365.7b)--(386.2a,367.4b)--(381.9a,369.0b)--(377.8a,370.5b)
--(373.8a,372.0b)--(369.9a,373.5b)--(366.1a,374.9b)--(362.3a,376.3b)--(358.7a,377.6b)
--(355.2a,378.9b)--(351.8a,380.2b)--(348.4a,381.4b)--(345.1a,382.7b)--(341.9a,383.9b)
--(338.8a,385.0b)--(335.7a,386.2b)--(332.7a,387.3b)--(329.7a,388.4b)--(327.1a,389.4b);
linetype 2;
linetype -2;
put_text( btex 3 cycles etex, 605.0a, 60.6b, 0, 3);
linetype 2;
draw (619.1a,60.6b)--(692.1a,60.6b);
draw (657.4a,181.6b)--(657.0a,218.4b)--(657.3a,240.0b)--(657.4a,255.3b)--(657.0a,267.1b)
--(649.9a,276.8b)--(638.7a,285.0b)--(626.5a,292.1b)--(614.2a,298.3b)--(602.4a,303.9b)
--(591.2a,309.0b)--(580.5a,313.6b)--(570.4a,317.9b)--(560.9a,321.8b)--(551.9a,325.5b)
--(543.4a,328.9b)--(535.3a,332.1b)--(527.6a,335.2b)--(520.3a,338.0b)--(513.3a,340.8b)
--(506.6a,343.4b)--(500.2a,345.8b)--(494.1a,348.2b)--(488.2a,350.5b)--(482.5a,352.6b)
--(477.1a,354.7b)--(471.8a,356.7b)--(466.7a,358.6b)--(461.8a,360.5b)--(457.0a,362.3b)
--(452.4a,364.1b)--(448.0a,365.7b)--(443.6a,367.4b)--(439.4a,369.0b)--(435.3a,370.5b)
--(431.3a,372.0b)--(427.5a,373.5b)--(423.7a,374.9b)--(420.0a,376.3b)--(416.4a,377.6b)
--(412.9a,378.9b)--(409.5a,380.2b)--(406.2a,381.4b)--(402.9a,382.7b)--(399.7a,383.9b)
--(396.6a,385.0b)--(393.5a,386.2b)--(390.5a,387.3b)--(387.6a,388.4b)--(384.7a,389.5b)
--(381.9a,390.5b)--(379.1a,391.5b)--(376.4a,392.6b)--(373.8a,393.5b)--(371.1a,394.5b)
--(368.6a,395.5b)--(366.1a,396.4b)--(363.6a,397.3b)--(361.1a,398.3b)--(358.7a,399.1b)
--(356.4a,400.0b)--(354.1a,400.9b)--(351.8a,401.7b)--(349.5a,402.6b)--(347.3a,403.4b)
--(345.1a,404.2b)--(343.0a,405.0b)--(340.9a,405.8b)--(338.8a,406.6b)--(336.7a,407.3b)
--(334.7a,408.1b)--(332.7a,408.8b)--(330.7a,409.6b)--(328.8a,410.3b)--(327.1a,410.9b);
linetype 3;
linetype -2;
put_text( btex 4 cycles etex, 605.0a, 31.3b, 0, 3);
linetype 3;
draw (619.1a,31.3b)--(692.1a,31.3b);
draw (657.4a,181.6b)--(657.3a,218.4b)--(657.3a,240.0b)--(657.3a,255.3b)--(657.3a,267.1b)
--(657.3a,276.8b)--(655.9a,285.0b)--(649.9a,292.1b)--(641.7a,298.3b)--(632.6a,303.9b)
--(623.4a,309.0b)--(614.2a,313.6b)--(605.3a,317.9b)--(596.7a,321.8b)--(588.4a,325.5b)
--(580.5a,328.9b)--(572.9a,332.1b)--(565.6a,335.2b)--(558.6a,338.0b)--(551.9a,340.8b)
--(545.5a,343.4b)--(539.3a,345.8b)--(533.4a,348.2b)--(527.6a,350.5b)--(522.1a,352.6b)
--(516.8a,354.7b)--(511.6a,356.7b)--(506.6a,358.6b)--(501.8a,360.5b)--(497.1a,362.3b)
--(492.6a,364.1b)--(488.2a,365.7b)--(483.9a,367.4b)--(479.8a,369.0b)--(475.7a,370.5b)
--(471.8a,372.0b)--(468.0a,373.5b)--(464.2a,374.9b)--(460.6a,376.3b)--(457.0a,377.6b)
--(453.6a,378.9b)--(450.2a,380.2b)--(446.9a,381.4b)--(443.6a,382.7b)--(440.5a,383.9b)
--(437.4a,385.0b)--(434.3a,386.2b)--(431.3a,387.3b)--(428.4a,388.4b)--(425.6a,389.5b)
--(422.8a,390.5b)--(420.0a,391.5b)--(417.3a,392.6b)--(414.7a,393.5b)--(412.1a,394.5b)
--(409.5a,395.5b)--(407.0a,396.4b)--(404.5a,397.3b)--(402.1a,398.3b)--(399.7a,399.1b)
--(397.4a,400.0b)--(395.1a,400.9b)--(392.8a,401.7b)--(390.5a,402.6b)--(388.3a,403.4b)
--(386.2a,404.2b)--(384.0a,405.0b)--(381.9a,405.8b)--(379.8a,406.6b)--(377.8a,407.3b)
--(375.8a,408.1b)--(373.8a,408.8b)--(371.8a,409.6b)--(369.9a,410.3b)--(367.9a,411.0b)
--(366.1a,411.7b)--(364.2a,412.4b)--(362.3a,413.1b)--(360.5a,413.8b)--(358.7a,414.4b)
--(357.0a,415.1b)--(355.2a,415.7b)--(353.5a,416.4b)--(351.8a,417.0b)--(350.1a,417.7b)
--(348.4a,418.3b)--(346.8a,418.9b)--(345.1a,419.5b)--(343.5a,420.1b)--(341.9a,420.7b)
--(340.3a,421.3b)--(338.8a,421.9b)--(337.2a,422.4b)--(335.7a,423.0b)--(334.2a,423.6b)
--(332.7a,424.1b)--(331.2a,424.7b)--(329.7a,425.2b)--(328.3a,425.8b)--(327.1a,426.2b);
linetype -2;
draw (327.1a,511.8b)--(327.1a,181.6b)--(657.4a,181.6b)--(657.4a,511.8b)--(327.1a,511.8b);
endfig;
end.
