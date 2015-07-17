def dec(n):
    a = len(str(n))
    total = 0
    for i in range(0, a):
        total = total + int(str(n)[i]) * 8**(a-1)
        a = a-1
    print total

dec(input())
