def linha(s1, s2):
    for i in range(2):
        print (s1),
        for i in range(4):
            print (s2),

    print (s1)

def aa():
    for i in range(2):
        linha('+','-')
        for i in range(4):
            linha('|',' ')
    linha('+','-')

aa()
