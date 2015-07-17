#######################################
def print_n(s, n):
    if n <= 0:
        return
    print (s)
    print_n(s, n-1)

####################################### 1.
def print_n1(s, n):
    while not n <= 0:
        print (s)
        n -= 1

####################################### 2.
def raiz_quadrada(a, x, epsilon):
    while True :
        y = ( x + a/x )/2
        if abs(y-x) < epsilon:
            return y
        x = y

####################################### 3.1
def escrever(w):
    l = len(w) -1
    while l >= 0:
        print (w[l])
        l -= 1

####################################### 3.2
def escrever_1(w):
    print (w[-1])
    if len(w) == 1:
        return
    escrever_1(w[:-1])
    
####################################### 4.
def find(word, letter, index):
    while index < len(word):
        if word[index] == letter:
            return index
        index = index + 1
    return -1

####################################### 5.
def num_vezes(string,letra):
    vezes = 0
    for i in string:
        if i == letra :
            vezes += 1
    return vezes













