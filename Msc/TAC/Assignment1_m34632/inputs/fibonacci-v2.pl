fun(fibonacci, [arg(n, int)],
  body([
      var(id(r,local,int), nil),
      var(id(c,local,bool), nil)
    ], [
      assign(id(c,local,bool),
        or(eq(id(n,arg,int): int, int_literal(0): int): bool,
          eq(id(n,arg,int): int, int_literal(1): int): bool): bool),
      if(
        id(c,local,bool): bool, 
        assign(id(r,local,int), id(n,arg,int): int), 
        assign(id(r,local,int),
          plus(
            call(fibonacci, [
              minus(id(n,arg,int): int, int_literal(1): int): int]): int,
            call(fibonacci, [
              minus(id(n,arg,int): int, int_literal(2): int): int]): int
          ): int))
    ],
    id(r,local,int): int)).
