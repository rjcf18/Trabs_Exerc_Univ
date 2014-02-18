def primos(n):
    for l in range(2,n+1):
        primo = True
        for i in range(2,l):
            if l % i == 0:
                primo = False
        if primo == True:
            print l
