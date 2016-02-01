id(triangular, fun, int, [id(n,int)], [id(a,int), id(b,int)]).

function(triangular, [
  i_aload(t0, n),
  i_lstore(a, t0),
  i_lload(t1, a),
  i_value(t2, 0),
  i_lt(t3, t2, t1),
  cjump(t3, l0, l1),
  label(l0),
  i_aload(t4, n),
  i_value(t5, 1),
  i_sub(t6, t4, t5),
  i_call(t7, triangular, [t6]),
  i_lstore(b, t7),
  i_lload(t8, a),
  i_lload(t9, b),
  i_add(t10, t8, t9),
  i_lstore(a, t10),
  label(l1),
  i_lload(t11, a),
  i_return(t11)]).

