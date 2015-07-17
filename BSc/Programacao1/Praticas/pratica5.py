################################################################################
# exercicio 1 #
###############

def compara(x, y):
    if x > y:
        return 1
    elif x == y:
        return 0
    else:
        return -1

################################################################################
# exercicio 2 #
###############

import math
def hip(cat1, cat2):
    return math.sqrt(((cat1)**2) + ((cat2)**2))

################################################################################
# exercicio 3 #
###############

def esta_entre(x, y, z):
    return x <= y <= z

################################################################################
# exercicio 4 #
###############

def contagem_decrescente(n):
    if isinstance(n, int) and n <= 0:
        print ('Partida!')
    elif isinstance(n,int) and n > 0:
        print (n)
        contagem_decrescente(n-1)
    else:
        print ('Tem que ser um número inteiro !')

################################################################################
# exercicio 5.1 #
#################

def somarial(n):
    if n <= 0:
        return 0
    else:
        return n + somarial(n-1)
                                                                        
################################################################################
# exercicio 5.2 #
#################

def somarial2(n):
    s = 0
    for i in range(n+1):
        s += i
    print (s)

################################################################################
# exercicio 7 #
###############





################################################################################    
