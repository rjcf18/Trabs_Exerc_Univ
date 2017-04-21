
id(n, var, int, 26).

id(sub, fun, int, [id(i1,int), id(i2,int)], []).

id(fibonacci, fun, int, [id(n,int)], [id(r,int)]).

id(main, fun, int, [], [id(fib,int)]).

function(sub, [
  i_aload(t0, i1),
  i_aload(t1, i2),
  i_sub(t2, t0, t1),
  i_return(t2)]).

function(fibonacci, [
  i_aload(t0, n),
  i_value(t1, 0),
  i_eq(t2, t0, t1),
  cjump(t2, l0, l3),
  label(l3),
  i_aload(t3, n),
  i_value(t4, 1),
  i_eq(t5, t3, t4),
  cjump(t5, l0, l1),
  label(l0),
  i_aload(t6, n),
  i_lstore(r, t6),
  jump(l2),
  label(l1),
  i_aload(t7, n),
  i_value(t8, 1),
  i_sub(t9, t7, t8),
  i_call(t10, fibonacci, [t9]),
  i_aload(t11, n),
  i_value(t12, 2),
  i_call(t13, sub, [t11,t12]),
  i_call(t14, fibonacci, [t13]),
  i_add(t15, t10, t14),
  i_lstore(r, t15),
  label(l2),
  i_lload(t16, r),
  i_return(t16)]).

function(main, [
  i_load(t0, n),
  i_call(t1, fibonacci, [t0]),
  i_lstore(fib, t1),
  i_lload(t2, fib),
  i_print(t2),
  i_value(t3, 14),
  i_value(t4, 3),
  i_value(t5, 4),
  i_mul(t6, t4, t5),
  i_add(t7, t3, t6),
  i_call(t8, fibonacci, [t7]),
  i_print(t8),
  i_value(t9, 121393),
  i_print(t9),
  i_value(t10, 0),
  i_return(t10)]).
