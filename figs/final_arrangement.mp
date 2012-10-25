input boxes

verbatimtex
%&latex
\documentclass{article}
\begin{document}
etex

beginfig(1);


%TRANSPARENT http://www-math.univ-poitiers.fr/~phan/metalpha.html

def addalso = addto currentpicture also enddef;

%SEE http://www-math.univ-poitiers.fr/~phan/metalpha.html

vardef alphafill expr c =
  alphapict_ := nullpicture;
  alphafill_(currentpicture, c);
  addto currentpicture also alphapict_;
enddef;

def alphafill_(expr p, c) =
  begingroup
    save p_, xmax_, xmin_, ymax_, ymin_; picture p_;
    p_ = nullpicture;
    (xmin_, ymin_) = llcorner c; (xmax_, ymax_) = urcorner c;
    addto p_ contour c withcolor bgalpha[background, fillcolor];
     
    for p__ within p:
      numeric xmin__, xmax__, ymin__, ymax__;
      (xmin__, ymin__) = llcorner p__; (xmax__, ymax__) = urcorner p__;
      if (xmax__<= xmin_) or (xmin__ >= xmax_):
      else:
	if (ymax__<= ymin_) or (ymin__ >= ymax_):
	else:
	  if (not clipped p__) and (not bounded p__):
	    addto p_ also p__ withcolor
	    fgalpha[(redpart p__, greenpart p__, bluepart p__),
	    fillcolor];
	  else:
	    begingroup save alphapict_;
	      picture alphapict_; alphapict_ = nullpicture;
	      alphafill_(p__, pathpart p__);
	      addto p_ also alphapict_;
	    endgroup;
	  fi
	fi
      fi
    endfor
    clip p_ to c;
    addto alphapict_ also p_;
  endgroup;
enddef;




  
  numeric u,w[],h[],h_,sf[];
  pair o, tleft[],tright[];
  path line[];
  path US[];
  u = 0.7cm;
  o = (3u,-6u);
  
  
%boxjoin(a.se=b.sw; a.ne=b.nw);
boxit.pa(btex\strut Power-amp etex);
boxit.trig(btex $\begin{array}{c} \mbox{Analogic} \\ \mbox{trigger} \end{array}$ etex);
boxit.pre(btex\strut Pre-amp etex);
boxit.s(btex $\begin{array}{c} \mbox{Data} \\ \mbox{Aquisition} \end{array}$ etex);
    boxit.g(btex\strut Signal Generator  etex);
  boxit.f(btex\strut Filter  etex);boxit.t1(btex\strut  etex);boxit.t2(btex\strut  etex);

boxit.dpr(btex\strut DPR500 etex);
boxit.rpl(btex\strut RPL2 etex);
boxit.scope(btex\strut Oscilloscope etex);

boxit.pc(btex\strut PC etex);


s.c   = o;
  pa.c   = o+(5u,5u);
  pre.c = o+(2u,5u);
  f.c   = o+(5u,5u);
trig.c   = o+(1u,3u);
pc.c = o + (1u,1u);
  g.c= o+(5u,3u);
dpr.c=o+(-2u,3u);
rpl.c=o+(-2u,5u);
scope.c= o+(-5u,3u);

%t1.c  = o+(-1u,8u);
  %t2.c  = o+(4u,8u);
  drawboxed(pa,g,trig,scope,dpr,rpl,pc);%t1,t2
  draw g.n--pa.s;
draw pa.n--(o+(5u,6u));
draw pc.n -- trig.s;
draw pc.e -- (o+(5u,1u)) -- g.s;
draw pc.w -- (o+(-2u,1u)) -- dpr.s;
draw pc.w -- (o+(-5u,1u)) -- scope.s;

%  draw (o+(-2u,6u))--(o+(5u,6u));
%  draw pre.w--(xpart(o),ypart(pre.c));
%  draw pre.e--f.w;
%draw f.s--s.n;
draw scope.e -- dpr.w;
draw dpr.e --trig.w;
draw dpr.n -- rpl.s;
draw rpl.n -- (o+(-2u,6u));
draw trig.e -- g.w;
  
  %draw trig.n -- s.s dashed evenly;
 % draw trig.w -- g.e dashed evenly;
  pair ip[];
%  ip1 =g.e+(xpart((s.w-g.e)/2),0);
%  ip2 = g.e+(xpart((s.w-g.e)/2),2u);
%  draw ip1--ip2 dashed evenly;
%  draw ip2--pa.e dashed evenly;
%  draw ip2--s.w dashed evenly;

  %Transducer Small * sf
  sf1 = 0.5;
  w1 = 0.3*sf1*u;
  h1 = 0.5*sf1*u;
  
  tleft1 = o+(-1u,8u);% ;
  tright1 =  tleft1+(w1,0);
  draw unitsquare xscaled (0.3*sf1*u) yscaled (u*sf1) shifted (tleft1 - (0,h1));
  draw (tright1 + (0,h1)) -- (tright1 + (w1,1.33*h1)) -- (tright1 + (w1,-1.33*h1)) --(tright1 - (0,h1));

  draw (o+(-2u,6u))--(o+(-2u,8u));
  draw (o+(-2u,8u))--tleft1;
  label.lft(btex $\begin{array}{c} \mbox{Imaging} \\ \mbox{Transducer} \end{array}$ etex rotated 0, (o+(-2u,8u)));

%%Transducer large *
  sf2 = 1;
  w2 = 0.3*sf2*u;
  h2 = 0.5*sf2*u;
  tright2 = o+(+4u,8u);
  tleft2 = tright2 -(w2,0);
  draw unitsquare xscaled (0.3*sf2*u) yscaled (u*sf2) shifted (tleft2 - (0,h2));
  draw (tleft2 + (0,h2)) -- (tleft2 + (-w2,1.33*h2)) -- (tleft2 + (-w2,-1.33*h2)) --(tleft2 - (0,h2));

  draw (o+(5u,6u))--(o+(5u,8u));
  draw (o+(5u,8u))--tright2;
label.rt(btex $\begin{array}{c} \mbox{Pumping} \\ \mbox{Transducer} \end{array}$ etex rotated 0, (o+(5u,8u)));

%% Draw sample
  sf3 = 1;
  w3 = 0.1*sf2*u;
  h3 = 1*sf2*u;
  tleft3 = o+(1u,8u);
  tright3 =tleft3+(w3,0);
  draw unitsquare xscaled w3 yscaled (2*h3) shifted (tleft3 - (0,h3));
  
  label.top(btex $\mbox{Sample}$ etex rotated 0, (  o+(1u,8u+h3)));
%% Draw the US beam
  
  
  picture alphapict_; alphapict_=nullpicture;
  color fillcolor;
  color fillcolor;
  
  fgalpha := 0.4; % usual alpha parameter
  bgalpha := 0.3; % alpha parameter with respect to the background

  
  US1 = (tright1 + (w1,h1)) -- (tright1 + (w1,-h1)) -- tright3 --cycle;
  US2 = (tleft2 + (-w2,h2)) -- (tleft2  + (-w2,-h2)) -- tleft3 --cycle;
  
  fillcolor=(1,1,0);
  alphafill(US1);
  fillcolor:=red;
  alphafill(US2);


  
%w = xpart(t1.e-t1.w);
  %h = ypart(t1.n-t1.s);
  %h_ = (h/4);
  %draw t1.ne -- (t1.ne + (w,h_)) --(t1.se + (w,-h_)) -- t1.se ;
  %draw t2.nw -- (t2.nw + (-w,h_)) --(t2.sw + (-w,-h_)) -- t2.sw ;

  
  
  
endfig;
end