fun(example, [arg(n, int)],
  body([
      var(id(r,local,int), nil)
    ], [
      assign(id(r,local,int), int_literal(1): int),
      while(
        gt(id(n,arg,int): int, int_literal(0): int): bool, [
          assign(id(r,local,int),
            times(id(r,local,int): int, id(n,arg,int): int): int),
          assign(id(n,arg,int),
            minus(id(n,arg,int): int, int_literal(1): int): int)
        ])
    ],
    id(r,local,int): int)).
