def quantidades(n):
    c = len(range(0,n,100)) - 1
    d = len(range(0,(n-c*100),10)) - 1
    u = len(range(0,(n-c*100-d*10)))
    print (c,'centenas,', d,'dezenas e', u,'unidades.')
quantidades(int(input('N: ')))
