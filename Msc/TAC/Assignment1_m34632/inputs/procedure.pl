var(id(x,var,real), nil).

fun(p, [arg(y, real)], body([], 
    assign(id(x,var,real), times(id(x,var,real): real, id(y,arg,real): real): real),
    nil)).

fun(main, [],
  body([], [
      assign(id(x,var,real), real_literal(1.5): real),
      call(p, [toreal(int_literal(3): int): real]),
      print(id(x,var,real): real)
    ],
    nil)).
