

% 3D lattice!
beginfig(3);
  u = 0.75cm;
  

  pair o, e[], E[], p;

  %origin at (2u,0)
  o:= (2u,0u);

  %vectors
  e1 := (0u, 2u);
  e2 := (2u,2u);
  e3 := (4u,2u);

  %bivectors
  E3 := (0u,  4u);
  E2 := (2u, 4u);
  E1 := (4u, 4u);

  %pseudoscalar
  p  := (2u, 6u);

  
  
  %draw to vectors
  draw o--e1;
  draw o--e2;
  draw o--e3;

  %draw to bivectors
  draw e1--E2;
  draw e1--E3;
  
  draw e2--E1;
  draw e2--E3;
  
  draw e3--E1;
  draw e3--E2;

  %draw to trivector
  draw E3--p;
  draw E2--p;
  draw E1--p;

  %draw dots
  pickup pencircle scaled 4pt;
  draw o;
  for i = 1 upto 3:
    draw e[i];
    draw E[i];
  endfor 
  draw p;


  %draw labels
  label.bot(btex $\alpha$ etex, o);
  label.llft(btex ${\bf E_1}$ etex, e1);
  label.llft(btex ${\bf E_2}$ etex, e2);
  label.lrt( btex ${\bf E_3}$ etex, e3);
  label.ulft(btex ${\bf E_1 E_2}$ etex, E3);
  label.ulft(btex ${\bf E_3 E_1}$ etex, E2);
  label.urt( btex ${\bf E_2 E_3}$ etex, E1);
  label.top(btex $I$ etex, p);
endfig;

% 4D lattice!
beginfig(4);

  %origin at (2u,0)
  pair s, v[], b[], t[], q;

  s:= (7u,0u);

  for i = 1 upto 4:
    v[i] = ( 2*(i+1)*u, 2u);%vectors
    t[i] = ( 2*(i+1)*u, 6u);%trivectors
  endfor

  %bivectors
  for i = 1 upto 6:
    b[i] = ( 2*(i)*u, 4u);%vectors
  endfor

  %pseudoscalar
  q = (7u, 8u);


  for i = 1 upto 4:
    draw s--v[i]; %draw to vectors
    draw t[i]--q; %draw to ps
    
  endfor
  for i = 1 upto 3:
    draw v1--b[i];
  endfor
  
  draw v2--b[1];
  draw v2--b[4];
  draw v2--b[5];
  
  draw v3--b[6];
  draw v3--b[4];
  draw v3--b[2];
  
  draw v4--b[3];
  draw v4--b[5];
  draw v4--b[6];

  draw b1--t1;
  draw b2--t1;
  draw b4--t1;

  draw b1--t2;
  draw b3--t2;
  draw b5--t2;

  draw b2--t3;
  draw b3--t3;
  draw b6--t3;

  draw b4--t4;
  draw b5--t4;
  draw b6--t4;

  %draw dots
  pickup pencircle scaled 4pt;
  draw s;
  for i = 1 upto 4:
    draw v[i];
    draw t[i];
  endfor
  
  for i = 1 upto 6:
    draw b[i];
  endfor

  draw q;

   %draw labels
  label.bot(btex $\alpha$ etex, s);

  label.llft(btex $\gamma_0$ etex, v1);
  label.llft(btex $\gamma_1$ etex, v2);
  label.lrt( btex $\gamma_2$ etex, v3);
  label.lrt( btex $\gamma_3$ etex, v4);
  
  label.lft(btex $\gamma_0 \gamma_1$ etex, b1);
  label.lft(btex $\gamma_0 \gamma_2$ etex, b2);
  label.lft(btex $\gamma_0 \gamma_3$ etex, b3);
  label.rt( btex $\gamma_1 \gamma_2$ etex, b4);
  label.rt( btex $\gamma_1 \gamma_3$ etex, b5);
  label.rt( btex $\gamma_2 \gamma_3$ etex, b6);

  label.ulft(btex $\gamma_0\gamma_1\gamma_2$ etex, t1);
  label.ulft(btex $\gamma_0\gamma_1\gamma_3$ etex, t2);
  label.urt( btex $\gamma_0\gamma_2\gamma_3$ etex, t3);
  label.urt( btex $\gamma_1\gamma_2\gamma_3$ etex, t4);

  label.top(btex $I$ etex, q);

  
endfig;


beginfig(5);
 
  
  
  %draw to vectors
  draw o--e1;
  draw o--e2;
  draw o--e3;

  %draw to bivectors
  draw e1--E2;
  draw e1--E3;
  
  draw e2--E1;
  draw e2--E3;
  
  draw e3--E1;
  draw e3--E2;

  %draw to trivector
  draw E3--p;
  draw E2--p;
  draw E1--p;

  %draw dots
  pickup pencircle scaled 4pt;
  draw o;
  for i = 1 upto 3:
    draw e[i];
    draw E[i];
  endfor 
  draw p;


  %draw labels
  label.bot(btex $\alpha$ etex, o);
  label.llft(btex $\gamma_0\gamma_1$ etex, e1);
  label.llft(btex $\gamma_0\gamma_2$ etex, e2);
  label.lrt( btex $\gamma_0\gamma_3$ etex, e3);
  label.ulft(btex $\gamma_1\gamma_2$ etex, E3);
  label.ulft(btex $\gamma_1\gamma_3$ etex, E2);
  label.urt( btex $\gamma_2\gamma_3$ etex, E1);
  label.top(btex $I$ etex, p);
endfig;
end;
