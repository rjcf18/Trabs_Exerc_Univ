id(fibonacci, fun, bool, [id(n,int)], [id(c,bool)]).

function(fibonacci, [
  i_aload(t0, n),
  i_value(t1, 0),
  i_eq(t2, t0, t1),
  cjump(t2, l0, l1),
  label(l1),
  i_aload(t3, n),
  i_value(t4, 1),
  i_eq(t5, t3, t4),
  i_copy(t2, t5),
  label(l0),
  i_lstore(c, t2),
  i_lload(t6, c),
  i_return(t6)]). 
