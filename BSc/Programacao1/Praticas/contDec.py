def contagem_decrescente (n):
    if (isinstance (n,int)):
        if (n<=0):
            print 'Partida'
        else:
            print n
            contagem_decrescente (n-1)

        
