def primo(n):
    for i in range(2, n):
        if n % i == 0:
            return False
    return True

def primo2(n):
    if primo(n) == True:
        print 'é primo'
    else:
        print 'não é primo'
