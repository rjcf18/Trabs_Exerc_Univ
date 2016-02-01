id(example, fun, int, [id(n,int)], [id(r,int)]).

function(example, [
  i_value(t0, 1),
  i_lstore(r, t0),
  label(l0),
  i_aload(t1, n),
  i_value(t2, 0),
  i_lt(t3, t2, t1),
  cjump(t3, l1, l2),
  label(l1),
  i_lload(t4, r),
  i_aload(t5, n),
  i_mul(t6, t4, t5),
  i_lstore(r, t6),
  i_aload(t7, n),
  i_value(t8, 1),
  i_sub(t9, t7, t8),
  i_astore(n, t9),
  jump(l0),
  label(l2),
  i_lload(t10, r),
  i_return(t10)]).

