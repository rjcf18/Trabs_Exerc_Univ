############################################################################

def mult3(n):
    return n % 3 == 0

############################################################################

def digitos(n):
    n = str(n)
    return int(str(n[::-1]))

############################################################################

def multiplo(n, m):
    return n % m == 0

#############################################################################

import random
def eurmil():
    if(random.sample(range(1, 10), 2)[0] != random.sample(range(1, 10), 2)[1]) and (random.sample(range(1, 51), 5)[0] != random.sample(range(1, 51), 5)[1] != random.sample(range(1, 51), 5)[2] != random.sample(range(1, 51), 5)[3] != random.sample(range(1, 51), 5)[4]):
        print(random.sample(range(1, 51), 5), random.sample(range(1, 10), 2))
    else:
        eurmil()
 
##############################################################################

def cria_tab():
    print ("Jogo do Galo!")
    print ()
    for i in range(3):
        print (' ', '|', ' ', '|')

##############################################################################           
def countdown(n):
    for i in range(n):
        print (n)
        n -= 1
    print ('Blastoff!')

##############################################################################

def divisor(n, m):
    return ((n < m and m % n == 0) or (m < n and n % m == 0))

##############################################################################

def conta_quantos_iguais(n, m):
    s = 0
    for i in m:
        if i == n:
            s += 1
    print(s)

##############################################################################

def pot3():
    n = int(input('>_'))
    for i in :    
        

        
