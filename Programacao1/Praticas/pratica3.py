def todos_inteiros(n):

    for i in range(n):
        print (i)

#numero_escolhido = input()
#todos_inteiros(numero_escolhido)

def soma_inteiros(n):
    soma = 0

    for i in range(n+1):
        soma=soma + i

    print (soma)

#numero = input()
#soma_inteiros(numero)

def linha(s1,s2):
    for i in range(2):
            print (s1),
            for l in range(4):
                print (s2),
        
    print (s1)

def aa():
    for i in range(2):
        linha('+','-')
        for i in range(4):
            linha('|',' ')
    linha('+','-')
    
aa()
