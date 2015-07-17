def tC (tF):
    tC = 5.0/9*(tF - 32)
    return tC
p = float (input ('Insira a temperatura em Fahrenheit - '))
print 'A temperatura em celsius é ' + str (tC (p))    
