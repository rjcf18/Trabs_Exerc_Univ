###############################################################################
#exercicio 1.1

def todos_inteiros(n):
    for i in range(n):
        print (i)
        
###############################################################################
#exercicio 1.2

def soma_inteiros(n):
    soma = 0
    for i in range(n+1):
        soma += i
    print ("A soma é: ", soma)
    
###############################################################################
#exercicio 2

def grid(n):
    for l in range(n):
        print('+', '-', '-', '-', '-', '+', '-', '-', '-', '-', '+')
        for i in range(2*n):
            print('|',' '*7, '|', ' '*7, '|')
    print('+', '-', '-', '-', '-', '+', '-', '-', '-', '-', '+')
           
###############################################################################
#exercicio 3

def primo(n):    
    if n == 1:
        print (n, "não é um número primo!")
    else:
        for i in range(2, n):
            if n % i == 0:
                print (n, "não é um número primo!")
                return
        print(n, "é um número primo!")
            
################################################################################
#exercicio 4

def primos(n):
    for l in range(2, n+1):
        primo = True
        for i in range(2, l):
            if l % i == 0:
                primo = False
        if primo == True:
            print (l)

################################################################################
#exercicio 5
            
def quantidades(n):
    c = len(range(0,n,100)) - 1
    d = len(range(0,(n-c*100),10)) - 1
    u = len(range(0,(n-c*100-d*10)))
    print (c,'centenas,', d,'dezenas e', u,'unidades.')

################################################################################                     

