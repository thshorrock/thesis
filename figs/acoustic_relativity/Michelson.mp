%prologues:=2;

verbatimtex
\documentclass[10]{memoir}
\begin{document}
  \def\Tiny{\fontsize{4pt}{4pt}\selectfont}
  etex

vardef arcsind primary x = angle((1+-+x,x)) enddef;
vardef arccosd primary x = angle((x,1+-+x)) enddef;

vardef make_subarrow.@#(expr p, loc, my_colour) =
  save half; path half[];
  save currentpicture; picture currentpicture; currentpicture=nullpicture;
  pair @#.split; @#.split = point loc of p;
  half0 = (point 0 of p)--(point loc of p);
  half1 = (point loc of p)--(point 1 of p);
  drawarrow half0 withcolor my_colour;
  draw half1 withcolor my_colour;
  picture  @#; @# = currentpicture;
enddef;

vardef make_mirror.@#(expr at, rot_angle,width, height, intensity, num_lines) =
  pair @#.front;
  pair @#.top;
  pair @#.bot;
  save currentpicture; picture currentpicture; currentpicture=nullpicture;
  save hh ; numeric hh; hh = 0.5*height;
  @#.front = at;
  @#.bot = (at + (0, -hh)) rotatedaround  (at, rot_angle);
  @#.top = (at + (0, hh)) rotatedaround  (at, rot_angle);
  
  draw  (at + (0, -hh)) --  (at + (0, hh)) withcolor intensity*white;
  save i; numeric i;
  save step_size; numeric step_size; step_size = height/num_lines;
  for i=0 upto num_lines:
    draw (at + (0, -hh) + (0, i*step_size)) -- (at + (0, -hh) + (width, (i+1.0)*step_size))  withcolor intensity*white ;
  endfor

  save p; picture p; p = currentpicture;
  picture  @#;
  @# = p rotatedaround  (at, rot_angle);
enddef;

vardef make_splitter.@#(expr at, rot_angle, height, intensity) =
  pair @#.front;
  pair @#.above;
  pair @#.below;
  pair @#.back;
  pair @#.bot;
  save delta; numeric delta; delta = 0.1*height;
  save currentpicture; picture currentpicture; currentpicture=nullpicture;
  save hh ; numeric hh; hh = 0.5*height;
  @#.front = at;
  @#.above   = (at + (delta,delta)) rotatedaround   (at, rot_angle);
  @#.below   = (at + (-delta,-delta)) rotatedaround   (at, rot_angle);
  
  @#.back   = (at + (hh,0)) rotatedaround   (at, rot_angle);
  @#.bot = (at + (0,-hh)) rotatedaround  (at, rot_angle);
  
  draw (at + (-hh, -hh))--(at + (hh, -hh)) -- (at + (hh, hh)) -- (at + (-hh, -hh)) withcolor intensity*white;

  save p; picture p; p = currentpicture;
  picture  @#;
  @# = p rotatedaround  (at, rot_angle);
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
pair o, ob;
o = (0,0);
ob = (0,0);
path bounding[];
bounding0:= ob--(ob+(4.5cm,0))-- (ob+(4.5cm,4.5cm))-- (ob+(0,4.5cm))--cycle;

beginfig(0);
  
  save ahlength; numeric ahlength; ahlength = 2pt;
  numeric intensity; intensity = 0;
  numeric mirror_width; mirror_width = 0.1cm;
  numeric mirror_height; mirror_height = 1cm;
  numeric beam_split_height; beam_split_height = 0.3cm;
  
  make_transducer.pulser(o+(0cm,2cm), 0, 0.75*u);
  make_mirror.m_ll((o+(4cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, intensity,30);
  make_mirror.m_perp((o+(2cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, intensity,30);
  make_splitter.beamsplit(o+(2cm, 2cm), 0, beam_split_height, intensity);

  make_subarrow.arrowOone(((pulser.front + (0,0.1*beam_split_height)) -- beamsplit.above), 0.5, red);
  make_subarrow.arrowOtwo(beamsplit.above -- ((m_perp.front) + (0.1*beam_split_height, 0) ), 0.5, red);
  make_subarrow.arrowOthree(beamsplit.above -- ((m_ll.front) + (0, 0.1*beam_split_height) ), 0.5, red);
  
  make_subarrow.arrowRone( beamsplit.below--((pulser.front + (0,-0.1*beam_split_height))), 0.5, blue);
  make_subarrow.arrowRtwo(((m_perp.front) + (-0.1*beam_split_height, 0) )--beamsplit.below, 0.5, blue);
  make_subarrow.arrowRthree( ((m_ll.front) + (0,- 0.1*beam_split_height) )--beamsplit.below, 0.5, blue);
  
  draw pulser;
  draw m_ll;
  draw m_perp;

  draw beamsplit;

  draw arrowOone;
  draw arrowOtwo;
  draw arrowOthree;

  draw arrowRone;
  draw arrowRtwo;
  draw arrowRthree;

  
  make_subarrow.outward( (o+(3cm,4.5cm))--(o+(4cm, 4.5cm)), 0.5, red);
  make_subarrow.return(  (o+(3cm,4.25cm))--(o+(4cm, 4.25cm)), 0.5, blue);

  label.rt(btex {\tiny Outward  pulse } etex, (o+(4cm,4.5cm)));
  label.rt(btex {\tiny Returning  pulse} etex, (o+(4cm,4.25cm)));

  drawdblarrow (beamsplit.front + (0,-0.75cm))--(m_ll.front+ (0,-0.75cm) );
  label.bot(btex $l$ etex,  0.5[(beamsplit.front + (0,-0.75cm)),(m_ll.front+ (0,-0.75cm) )]  );
    
  drawdblarrow (beamsplit.front + (2.25cm,0cm))--(m_perp.front+ (2.25cm,0cm) );
  label.rt(btex $l$ etex,  0.5[beamsplit.front + (2.25cm,0cm),m_perp.front+ (2.25cm,0cm)]  );

  label.top(btex {\tiny transducer} etex, pulser.top);
  label.ulft(btex {\tiny acoustic reflector} etex, m_perp.top);
  label.bot(btex {\tiny partial reflector} etex, beamsplit.bot);

  label.ulft(btex $A$ etex, beamsplit.front);
  label.llft(btex $B$ etex, m_perp.front);
  label.ulft(btex $C$ etex, m_ll.front);
  
  
  draw outward;
  draw return;
  
  setbounds currentpicture to bounding0;
endfig;


beginfig(1);
  save ahlength; numeric ahlength; ahlength = 2pt;
  numeric intensity; intensity = 0;

  numeric mirror_width; mirror_width = 0.1cm;
  numeric mirror_height; mirror_height = 1cm;
  numeric beam_split_height; beam_split_height = 0.3cm;
  
  make_transducer.pulser(o+(0cm,2cm), 0, 0.75*u);
  make_mirror.m_ll((o+(4cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, intensity,30);
  make_mirror.m_perp((o+(2cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, intensity,30);
  make_splitter.beamsplitOne(o+(1.5cm, 2cm), 0, beam_split_height, intensity);
  make_splitter.beamsplitTwo(o+(2.5cm, 2cm), 0, beam_split_height, intensity);

  make_subarrow.arrowOone(((pulser.front + (0,0.1*beam_split_height)) -- beamsplitOne.above), 0.5, red);
  make_subarrow.arrowOtwo(beamsplitOne.above -- (m_perp.front) , 0.5, red);
  make_subarrow.arrowOthree(beamsplitOne.above -- ((m_ll.front) + (0, 0.1*beam_split_height) ), 0.7, red);
  
  make_subarrow.arrowRone( beamsplitTwo.below--((pulser.front + (0,-0.1*beam_split_height))), 0.7, blue);
  make_subarrow.arrowRtwo(((m_perp.front) )--beamsplitTwo.below, 0.5, blue);
  make_subarrow.arrowRthree( ((m_ll.front) + (0,- 0.1*beam_split_height) )--beamsplitTwo.below, 0.7, blue);
  
  draw pulser;
  draw m_ll;
  draw m_perp;

  draw beamsplitOne;
  draw beamsplitTwo;

  draw arrowOone;
  draw arrowOtwo;
  draw arrowOthree;

  draw arrowRone;
  draw arrowRtwo;
  draw arrowRthree;
  
  drawdblarrow (beamsplit.front + (0,-0.75cm))--(m_ll.front+ (0,-0.75cm) );
  label.bot(btex $l$ etex,  0.5[(beamsplit.front + (0,-0.75cm)),(m_ll.front+ (0,-0.75cm) )]  );
    
  drawdblarrow (beamsplit.front + (2.25cm,0cm))--(m_perp.front+ (2.25cm,0cm) );
  label.rt(btex $l$ etex,  0.5[beamsplit.front + (2.25cm,0cm),m_perp.front+ (2.25cm,0cm)]  );
    
  
  drawdblarrow (beamsplit.front + (0,-0.75cm))--(beamsplit.front+ (-0.5cm,-0.75cm) );
  label.bot(btex $vt_{AB}$ etex,  0.5[beamsplit.front + (0,-0.75cm), beamsplit.front+ (-0.5cm,-0.75cm) ]  );

  label.ulft(btex $A$ etex, beamsplitOne.front);
  label.top(btex $A^\prime$ etex, beamsplitTwo.above + (0.05cm,0.05cm));
  label.llft(btex $B$ etex, m_perp.front);
  label.ulft(btex $C$ etex, m_ll.front);
  
  pickup pencircle scaled 2pt;
  
  drawarrow (o+(1.5cm,0.5cm))--(o+(2.5cm,0.5cm));
  label.bot(btex laminar flow of speed $v$ etex, (2cm,0.5cm) );
  pickup defaultpen; 
  
  setbounds currentpicture to bounding0;
endfig;

beginfig(2);
  
  save ahlength; numeric ahlength; ahlength = 2pt;
  numeric intensity; intensity = 0;
  numeric mirror_width; mirror_width = 0.1cm;
  numeric mirror_height; mirror_height = 1cm;
  numeric beam_split_height; beam_split_height = 0.3cm;
  
  make_transducer.pulser(o+(0cm,2cm), 0, 0.75*u);
  make_mirror.m_ll((o+(4cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, intensity,30);
  make_mirror.m_perp((o+(2cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, intensity,30);
  make_splitter.beamsplit(o+(2cm, 2cm), 0, beam_split_height, intensity);

  make_subarrow.arrowOone(((pulser.front + (0,0.1*beam_split_height)) -- beamsplit.above), 0.5, red);
  make_subarrow.arrowOtwo(beamsplit.above -- ((m_perp.front) + (0.1*beam_split_height, 0) ), 0.5, red);
  make_subarrow.arrowOthree(beamsplit.above -- ((m_ll.front) + (0, 0.1*beam_split_height) ), 0.5, red);
  
  make_subarrow.arrowRone( beamsplit.below--((pulser.front + (0,-0.1*beam_split_height))), 0.5, blue);
  make_subarrow.arrowRtwo(((m_perp.front) + (-0.1*beam_split_height, 0) )--beamsplit.below, 0.5, blue);
  make_subarrow.arrowRthree( ((m_ll.front) + (0,- 0.1*beam_split_height) )--beamsplit.below, 0.5, blue);
  
  %draw pulser;
  draw m_ll;
  draw m_perp;

  draw beamsplit;

  %draw arrowOone;
  draw arrowOtwo;
  draw arrowOthree;

  %draw arrowRone;
  draw arrowRtwo;
  draw arrowRthree;

  
  make_subarrow.outward( (o+(3cm,4.5cm))--(o+(4cm, 4.5cm)), 0.5, red);
  make_subarrow.return(  (o+(3cm,4.25cm))--(o+(4cm, 4.25cm)), 0.5, blue);

  label.rt(btex {\tiny Outward  pulse } etex, (o+(4cm,4.5cm)));
  label.rt(btex {\tiny Returning  pulse} etex, (o+(4cm,4.25cm)));

  drawdblarrow (beamsplit.front + (0,-0.75cm))--(m_ll.front+ (0,-0.75cm) );
  label.bot(btex $l$ etex,  0.5[(beamsplit.front + (0,-0.75cm)),(m_ll.front+ (0,-0.75cm) )]  );
    
  drawdblarrow (beamsplit.front + (2.25cm,0cm))--(m_perp.front+ (2.25cm,0cm) );
  label.rt(btex $l$ etex,  0.5[beamsplit.front + (2.25cm,0cm),m_perp.front+ (2.25cm,0cm)]  );

  %label.top(btex {\tiny transducer} etex, pulser.top);
%  label.ulft(btex {\tiny acoustic reflector} etex, m_perp.top);
 % label.bot(btex {\tiny partial reflector} etex, beamsplit.bot);

  label.ulft(btex $A$ etex, beamsplit.front);
  label.llft(btex $B$ etex, m_perp.front);
  label.ulft(btex $C$ etex, m_ll.front);

  label.rt(btex {\tiny  $t_{AB}$ } etex rotated 90, arrowOtwo.split);
  label.lft(btex {\tiny $t_{BA}$ } etex rotated 90, arrowRtwo.split);
  
  
  label.top(btex {\tiny  $t_{AC}$ } etex , arrowOthree.split);
  label.bot(btex {\tiny $t_{CA}$ } etex , arrowRthree.split);
  
  draw outward;
  draw return;
  
  setbounds currentpicture to bounding0;
endfig;


beginfig(3);
  save ahlength; numeric ahlength; ahlength = 2pt;

  numeric Present; Present = 0;
  numeric Past; Past  = 0.8;
  numeric mirror_width; mirror_width = 0.1cm;
  numeric mirror_height; mirror_height = 0.4cm;
  numeric beam_split_height; beam_split_height = 0.3cm;
  
  make_transducer.pulser(o+(0cm,2cm), 0, 0.75*u);
  make_mirror.m_ll_one((o+(3.5cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, Past,12);
  make_mirror.m_ll_two((o+(4.cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, Present,12);
  make_mirror.m_ll_three((o+(4.5cm-mirror_width, 2cm)), 0, mirror_width, mirror_height, Past,12);
  make_mirror.m_perp_one((o+(1.5cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, Past,12);
  make_mirror.m_perp_two((o+(2.cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, Present,12);
  make_mirror.m_perp_three((o+(2.5cm, 4cm-mirror_width)), 90, mirror_width, mirror_height, Past,12);
  make_splitter.beamsplitOne(o+(1.5cm, 2cm), 0, beam_split_height, Present);
  make_splitter.beamsplitTwo(o+(2.0cm, 2cm), 0, beam_split_height, Past);
  make_splitter.beamsplitThree(o+(2.5cm, 2cm), 0, beam_split_height, Present);

  make_subarrow.arrowOone(((pulser.front + (0,0.1*beam_split_height)) -- beamsplitOne.above), 0.5, red);
  make_subarrow.arrowOtwo(beamsplitOne.above -- (m_perp_two.front) , 0.5, red);
  make_subarrow.arrowOthree(beamsplitOne.above -- ((m_ll_two.front) + (0, 0.1*beam_split_height) ), 0.7, red);
  
  make_subarrow.arrowRone( beamsplitTwo.below--((pulser.front + (0,-0.1*beam_split_height))), 0.7, blue);
  make_subarrow.arrowRtwo(((m_perp_two.front) )--beamsplitThree.below, 0.5, blue);
  make_subarrow.arrowRthree( ((m_ll_two.front) + (0,- 0.1*beam_split_height) )--beamsplitThree.below, 0.7, blue);
  
  %draw pulser;
  draw m_ll_one;
  draw m_ll_two;
  draw m_ll_three;
  draw m_perp_one;
  draw m_perp_two;
  draw m_perp_three;

  draw beamsplitOne;
  draw beamsplitTwo;
  draw beamsplitThree;

  %draw arrowOone;
  draw arrowOtwo;
  draw arrowOthree;

  %draw arrowRone;
  draw arrowRtwo;
  draw arrowRthree;
  
  drawdblarrow (beamsplit.front + (0,-0.75cm))--(m_ll.front+ (0,-0.75cm) );
  label.bot(btex $l$ etex,  0.5[(beamsplit.front + (0,-0.75cm)),(m_ll.front+ (0,-0.75cm) )]  );
    
  drawdblarrow (beamsplit.front - (1.25cm,0cm))--(m_perp.front- (1.25cm,0cm) );
  label.rt(btex $l$ etex,  0.5[beamsplit.front - (1.25cm,0cm),m_perp.front- (1.25cm,0cm)]  );
    
  
  drawdblarrow (beamsplit.front + (0,-0.75cm))--(beamsplit.front+ (-0.5cm,-0.75cm) );
  label.bot(btex $vt_{AB}$ etex,  0.5[beamsplit.front + (0,-0.75cm), beamsplit.front+ (-0.5cm,-0.75cm) ]  );

  label.ulft(btex $A$ etex, beamsplitOne.front);
  label.top(btex $A$ etex, beamsplitThree.above + (0.05cm,0.05cm));
  label.llft(btex $B$ etex, m_perp_two.front);
  label.ulft(btex $C$ etex, m_ll_two.front);


  label.lft(btex {\tiny  $t_{AB} $ } etex rotated (90-14.04), arrowOtwo.split);
  label.rt(btex {\tiny $t_{BA} $ } etex rotated -(90-14.04), arrowRtwo.split);
  
  
  label.top(btex {\tiny  $t_{AC} $ } etex , arrowOthree.split);
  label.bot(btex {\tiny $t_{CA} $ } etex , arrowRthree.split + ( 0.2cm,0));
  
  %pickup pencircle scaled 2pt;
  
  %drawarrow (o+(1.5cm,0.5cm))--(o+(2.5cm,0.5cm));
  %label.bot(btex laminar flow of speed $v$ etex, (2cm,0.5cm) );
  %pickup defaultpen; 
  
  setbounds currentpicture to bounding0;
endfig;



end