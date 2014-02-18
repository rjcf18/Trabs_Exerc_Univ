# pratica 7

# ex 1

def somac(lista):
    s = 0
    l = []
    for n in lista:
        s += n
        l.append(s)
    return l



#ex 2.1

def corta(lista):
    lista.pop(0)
    lista.pop(len(lista)-1)
    return 

#ex 2.2

def meio(lista):
    lista.pop(0)
    lista.pop(len(lista)-1)
    return lista
   #ou

def meio2(lista):
    return lista[1:-1]

#ex 3

def e_anagrama(s1, s2):
    a = 0
    b = 0
    for l in s1:
        if l in s2:       
            a += 1
    for k in s2:
        if k in s1:
            b += 1
    return (a == b)

    
        
    
