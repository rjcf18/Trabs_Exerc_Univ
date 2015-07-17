import math

#exercicio 1

def euros (d):
    e = float(d)/1.2935
    print (e)

#exercicio 2

def soma(x,y):
    resultado = x + y
    print (resultado)

#exercicio 3

def graus (rad):
    graus = rad*(180/math.pi)
    print (graus)

#exercicio 4

def rad (graus):
    rad = (graus*math.pi)/180
    print (rad)

#exercicio 5

def right_justify(s):
    print ((' '*(70-len(s)))+str(s))
    
    
    
