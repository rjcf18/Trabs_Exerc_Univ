id(factorial, fun, int, [id(n,int)], [id(r,int)]).

function(factorial, [
  i_value(t0, 1),
  i_lstore(r, t0),
  i_aload(t1, n),
  i_value(t2, 0),
  i_lt(t3, t2, t1),
  cjump(t3, l0, l1),
  label(l0),
  i_aload(t4, n),
  i_aload(t5, n),
  i_value(t6, 1),
  i_sub(t7, t5, t6),
  i_call(t8, factorial, [t7]),
  i_mul(t9, t4, t8),
  i_lstore(r, t9),
  label(l1),
  i_lload(t10, r),
  i_return(t10)]).
