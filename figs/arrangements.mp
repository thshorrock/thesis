%prologues:=2;

verbatimtex
\documentclass[]{memoir}
\begin{document}
\footnotesize
  etex
  
%http://www-math.univ-poitiers.fr/~phan/metalpha.html
picture alphapict_; alphapict_=nullpicture;


  fgalpha := 0.01; % usual alpha parameter
  bgalpha:= 0.3; % alpha parameter with respect to the background
vardef alphafill (expr c, the_color) =
  alphapict_ := nullpicture;
  alphafill_(currentpicture, c, the_color);
  addto currentpicture also alphapict_;
enddef;

def alphafill_(expr p, c, the_color) =
  begingroup
    save p_, xmax_, xmin_, ymax_, ymin_; picture p_;
    p_ = nullpicture;
    (xmin_, ymin_) = llcorner c; (xmax_, ymax_) = urcorner c;
    addto p_ contour c withcolor bgalpha[background, the_color];
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
	    the_color];
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


vardef arcsind primary x = angle((1+-+x,x)) enddef;
vardef arccosd primary x = angle((x,1+-+x)) enddef;

vardef make_sampleholder.@#(expr at, rot_angle,width, height) =
  pair @#.w, @#.e,@#.n, @#.s,@#.c;
  save pnt; pair pnt[];
  path @#;
  save hw ; numeric hw; hw = 0.5*width;
  save hh ; numeric hh; hh = 0.5*height;
  @#.c = at;
  if (rot_angle<=90  ) :
    @#.w = ( at + (-hw, 0) ) rotatedaround (at, rot_angle);
    @#.e = ( at + (hw, 0) ) rotatedaround (at, rot_angle);
    @#.n = ( at + (0, hh) ) rotatedaround (at, rot_angle);
    @#.s = ( at + (0,- hh) ) rotatedaround (at, rot_angle);
  elseif (rot_angle>=270  ) :
    @#.w = ( at + (-hw, 0) ) rotatedaround (at, rot_angle);
    @#.e = ( at + (hw, 0) ) rotatedaround (at, rot_angle);
    @#.n = ( at + (0, hh) ) rotatedaround (at, rot_angle);
    @#.s = ( at + (0,- hh) ) rotatedaround (at, rot_angle);
  else :
    @#.e = ( at + (-hw, 0) ) rotatedaround (at, rot_angle);
    @#.w = ( at + (hw, 0) ) rotatedaround (at, rot_angle);
    @#.s = ( at + (0, hh) ) rotatedaround (at, rot_angle);
    @#.n = ( at + (0,- hh) ) rotatedaround (at, rot_angle);
  fi;
  pnt0 = ( at + (-hw,  hh) ) rotatedaround (at, rot_angle);
  pnt1 = ( at + (-hw, -hh) ) rotatedaround (at, rot_angle);
  pnt2 = ( at + ( hw, -hh) ) rotatedaround (at, rot_angle);
  pnt3 = ( at + ( hw,  hh) ) rotatedaround (at, rot_angle);
  @# = pnt0--(pnt1--pnt2)--pnt3--cycle;
enddef;
    

vardef make_transducer.@#(expr at, rot_angle, scaleby) =
  save hscaleby;  numeric hscale;  hscaleby   = 0.5*scaleby;
  pair @#.back, @#.top, @#.bottom, @#.front, @#.backtop, @#.backbottom, @#.fronttop, @#.frontbottom, @#.joinbottom, @#.jointop ;
  path @#;
  
  @#.back  = at;
  @#.front = (at+(scaleby,0)) rotatedaround (at, rot_angle) ;
  if (rot_angle<=90  ) :
    @#.top = (at+(0.5*scaleby,0.5*scaleby)) rotatedaround (at, rot_angle) ;
    @#.bottom = (at+(0.5*scaleby,-0.5*scaleby)) rotatedaround (at, rot_angle) ;
    
    @#.backtop = (at + (0, 0.5*hscaleby))  rotatedaround (at, rot_angle) ;
    @#.backbottom = (at + (0, -0.5*hscaleby) )  rotatedaround (at, rot_angle) ;
    @#.joinbottom = (at +(0.75*scaleby,-0.5*hscaleby) ) rotatedaround (at, rot_angle) ;  
    @#.jointop = (at +(0.75*scaleby,+0.5*hscaleby) ) rotatedaround (at, rot_angle) ;
    @#.frontbottom = (at +(scaleby,-0.5*scaleby) ) rotatedaround (at, rot_angle) ;
    @#.fronttop = (at +(scaleby,+0.5*scaleby) ) rotatedaround (at, rot_angle) ;
  elseif(rot_angle>=270  ) :

    @#.top = (at+(0.5*scaleby,0.5*scaleby)) rotatedaround (at, rot_angle) ;
    @#.bottom = (at+(0.5*scaleby,-0.5*scaleby)) rotatedaround (at, rot_angle) ;
    
    @#.backtop = (at + (0, 0.5*hscaleby))  rotatedaround (at, rot_angle) ;
    @#.backbottom = (at + (0, -0.5*hscaleby) )  rotatedaround (at, rot_angle) ;
    @#.joinbottom = (at +(0.75*scaleby,-0.5*hscaleby) ) rotatedaround (at, rot_angle) ;  
    @#.jointop = (at +(0.75*scaleby,+0.5*hscaleby) ) rotatedaround (at, rot_angle) ;
    @#.frontbottom = (at +(scaleby,-0.5*scaleby) ) rotatedaround (at, rot_angle) ;
    @#.fronttop = (at +(scaleby,+0.5*scaleby) ) rotatedaround (at, rot_angle) ;
  else:
    @#.bottom = (at+(0.5*scaleby,0.5*scaleby)) rotatedaround (at, rot_angle) ;
    @#.top = (at+(0.5*scaleby,-0.5*scaleby)) rotatedaround (at, rot_angle) ;
    @#.backbottom = (at + (0, 0.5*hscaleby))  rotatedaround (at, rot_angle) ;
    @#.backtop = (at + (0, -0.5*hscaleby) )  rotatedaround (at, rot_angle) ;
    @#.jointop = (at +(0.75*scaleby,-0.5*hscaleby) ) rotatedaround (at, rot_angle) ;  
    @#.joinbottom = (at +(0.75*scaleby,+0.5*hscaleby) ) rotatedaround (at, rot_angle) ;
    @#.fronttop = (at +(scaleby,-0.5*scaleby) ) rotatedaround (at, rot_angle) ;
    @#.frontbottom = (at +(scaleby,+0.5*scaleby) ) rotatedaround (at, rot_angle) ;
  fi;
  
  
  @# = @#.backtop--@#.backbottom--@#.joinbottom--@#.jointop--@#.fronttop--@#.frontbottom--@#.joinbottom--@#.jointop--cycle;
enddef;

u = 0.5cm;
pair o;
o = (0,0);
path bounding[];
bounding0:= o--(o+(4cm,0))-- (o+(4cm,4cm))-- (o+(0,4cm))--cycle;

beginfig(0);
  numeric rot_angle, scaleby;
  rot_angle = 300.0;
  scaleby = 1*u;

  make_transducer.driving(o+(4cm-1u,2cm), 180, 1.5*u);
  make_transducer.imaging(o+(1u,2cm), 0, 0.75*u);

  
  draw imaging;
  draw driving;

  draw imaging.back--(imaging.back+(-1u,0));
  draw driving.back--(driving.back+(1u,0));

  pair focus; focus = 0.25[imaging.front,driving.front];

  label.llft(btex Imaging transducer etex, imaging.bottom);
  label.lrt(btex Driving transducer etex, driving.bottom);
  
  make_sampleholder.sample(focus, 0, 2mm, 2cm);
  label.top (btex Sample holder etex, sample.n);
  draw sample dashed withdots scaled 0.2;
  
  color hffillcolor; hffillcolor=red;
  color lffillcolor; lffillcolor=red;
  path hf_sound ; hf_sound = imaging.frontbottom--imaging.fronttop--focus--cycle;
  path lf_sound ; lf_sound = driving.frontbottom--driving.fronttop--focus--cycle;
  alphafill(hf_sound, hffillcolor);
  alphafill(lf_sound, lffillcolor);
  
  setbounds currentpicture to bounding0;
endfig;
end