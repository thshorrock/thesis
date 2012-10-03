

vardef get_angle(expr p) =
 show angle(p);
enddef;


vardef make_transducer(expr at, rot, scale) =
  pair bar ; bar = (21.25984,63.77953);
  get_angle(bar);
enddef;

u = 0.75cm;
pair o;
o = (0,0);

beginfig(0);
  numeric angle, scale;
  angle = 181.0;
  scale = 1*u;
  pair foo; foo = (1,1);
  get_angle(foo);
  show angle(foo);
endfig;
end;