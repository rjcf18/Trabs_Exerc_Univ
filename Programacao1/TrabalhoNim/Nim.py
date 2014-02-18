

                    ######################################
                    # Nim - Humano vs Humano: Modo Texto #
                    ######################################

import random
from tkinter import *

# Aqui sao inicializadas algumas variaveis e é utilizado o random sample
# para obter o tabuleiro aleatorio
win = 0
t = random.sample(range(1,30),4)
jog = [0,0,0,0]
root = Tk()
j = ''
k = ''

#####################################################
# Funcao que faz as mudancas da jogada no tabuleiro #
#####################################################

def novotab(jog, t):
    # apos verificadas as condicoes anteriores é removido o numero
    # de objectos da respectiva pilha
    # (novotab = [t[0]-jog[0], t[1]-jog[1], t[2]-jog[2], t[3]-jog[3]])
    x = 0
    for n in jog:
        t[x] -= jog[x]
        x += 1
    return t

###############################################
# Funcao que verifica se o jogo foi terminado # 
###############################################

def gameover(t, p, k):
    # verificar se o jogo foi terminado, sair do loop e voltar ao
    # menu caso se verifique que sim e imprimir quem foi o vencedor 
    if (t[0] == 0 and t[1] == 0 and t[2] == 0 and t[3] == 0 and k == 'HvsH'):
        win = 1
        mostrartab(t, k)
        print ('Jogador ' + str(p) +  ' ganhou! \n')
        novojogo(win, p)
    elif (t[0] == 0 and t[1] == 0 and t[2] == 0 and t[3] == 0 and k == 'HvsC'):
        win = 1
        mostrartab(t, k)
        if p == 1:
            print ('Jogador ganhou! \n')
        elif p == 'Computador':
            print ('Computador ganhou! \n')
            novojogo(win, p)

#####################################################################
# Funcao para verificar se o utilizador deseja iniciar um jogo novo #
#####################################################################
def novojogo(win, p):
    if win == 1:
        print('Deseja jogar outra vez? \n')
        print('1 - Sim')
        print('2 - Nao \n')
        njog = int(input('>_ '))
        print('')
        if njog == 1:
            jog = [0,0,0,0]
            menu()
        elif njog == 2:
            print ('Volte Sempre. \n')
            exit()
        else:
            print('Nao e uma opcao valida. \n')
            novojogo(win, p) 

###################################################################
# Funcao que mostra o menu inicial e pede ao utilizador uma opcao #
###################################################################
        
def menu():
    print ("#* * * * * * * * *Nim* * * * * * * * *#")
    print ('#                                     #')
    print ('# 0 - Sair                            #')
    print ('# 1 - Humano vs Humano: Modo Texto    #')
    print ('# 2 - Humano vs Humano: Modo Grafico  #')
    print ('# 3 - Humano vs Computador            #')
    print ('#                                     #')
    print ("#* * * * * * * * * * * * * * * * * * *#")
    c = int(input('>_ '))
    if c == 0:
        exit()
    elif c == 1:
        print ('Quem joga primeiro? \n')
        p = int(input('>_ '))
        t = random.sample(range(1,30),4)
        k = 'HvsHg'
        game(win, p, t, jog, j, k)
    elif c == 2:
        print ('Quem joga primeiro? \n')
        p = int(input('>_ '))
        t = random.sample(range(1,30),4)
        start(t,p)
    elif c == 3:
        menu2()
    else:
        print('Nao e uma opcao valida. \n')
        menu()

##############################################################
# Funcao principal/geral que contem o loop principal do jogo #
##############################################################

def game(win, p, t, jog, j, k):
    """loop principal do jogo: ira continuar neste loop até se verificar
    que o jogo terminou"""
    k = 'HvsH'
    while win == 0:
        if p == 1:
            mostrartab(t, k)
            
            jog = jogada(jog, p)

            y = inc(t, jog)
            
            limjog(p, jog, t, y, k)

            # ao atribuir o valor 2 a variavel p a funcao "salta" para
            # a parte do jogador 2
            p = 2
        else:
            mostrartab(t, k)
            
            jog = jogada(jog, p)

            y = inc(t, jog)

            limjog(p, jog, t, y, k)

            # ao atribuir o valor 1 a variavel c a funcao "salta" para
            # a parte do jogador 1
            p = 1
###################################
# Funcao para mostrar o tabuleiro #
###################################

def mostrartab(t, k):
    if k == 'HvsHg':
        c1=435
        c2=435
        c3=435
        c4=435
        
        for i in range(t[0]):
            cl1.create_image(0, c1, anchor = NW, image = barra)
            cl1.place(x = 240, y = 160)
            c1 -= 15

        for i in range(t[1]):
            cl2.create_image(0, c2, anchor = NW, image = barra)
            cl2.place(x = 390, y = 160)
            c2 -=15

        for i in range(t[2]):
            cl3.create_image(0, c3, anchor = NW, image = barra)
            cl3.place(x = 540, y = 160)
            c3 -=15

        for i in range(t[3]):
            cl4.create_image(0, c4, anchor = NW, image = barra)
            cl4.place(x = 690, y = 160)
            c4 -=15
    else:
        print ('\nTabuleiro: ', t[0], t[1], t[2], t[3], ' \n ')

###############################################
# Funcao para a criacao da lista com a jogada #
###############################################

def jogada(jog, p):

    """introducao da jogada numa lista chamada j que vai ser uma
    lista temporaria que contem todos os numeros inseridos como
    strings e inicializaçao da lista onde vao ser guardados apenas
    os numeros apos a filtracao da lista temporaria cujo conteudo
    sao apenas strings """
            
    # criar a lista temporaria dos numeros como strings
    j = input ('Jogador ' + str(p) + ': ')
    j = j.split()
    jog = []

    # guardar os numeros ja convertidos para inteiros na lista jog
    for char in j:              
        jog.append(int(char))

    return jog

#######################################################
# Funcao para incrementar os numeros maiores que zero #
#######################################################

def inc(t, jog):
    """variaveis acumuladoras para contar quantos sao os numeros
    maiores que zero na jogada (y). """
    y = 0 

    """verificar cada elemento da lista que contem a jogada e sera
    incrementada a variavel y por cada valor encontrado maior que zero"""
    for n in jog:
        if n > 0:
            y += 1
            
    return y

##########################################################
# Funcao para limitar as jogadas de acordo com as regras # 
##########################################################

def limjog(p, jog, t, y, k):
    """aqui sao limitadas as jogadas - quando o numero de valores
    maiores que zero e maior que dois, ou seja, quando retiramos
    objectos de mais que duas pilhas é mostrada uma mensagem de erro.
    O mesmo acontece para o caso em que o numero de objectos retirados
    de uma pilha é maior que o numero de objectos que se encontram na
    mesma e o caso em que nao sao retirados nenhum objecto de nenhuma pilha"""
    if y > 2:
        joginv(p, jog, t, k)
    elif (t[0]-jog[0] < 0 or t[1]-jog[1] < 0 or t[2]-jog[2] < 0 or t[3]-jog[3] < 0):
        joginv(p, jog, t, k)
    elif y == 0:
        joginv(p, jog, t, k)
    else:
        novotab(jog, t)            
        gameover(t, p, k)

#########################################
# Funcao para mostrar a jogada invalida #
#########################################

def joginv(p, jog, t, k):
    print ('\nJogada invalida.')
    if k == 'HvsH':
        game(win, p, t, jog, j, k)
    elif k == 'HvsC':
        hvsc(win, p, t, jog, j, k)
    else:
        messagebox.showinfo("Jogada Inválida!", "Jogada Inválida!")
        start(t,p)
        
       
################################################################################

                    ##########################################
                    # Nim - Humano vs Computador: Modo texto #
                    ##########################################


#######################################################################
# Funcao que mostra um segundo menu e que pergunta quem joga primeiro #
#######################################################################

def menu2():
    print ('Quem joga primeiro? \n')
    print ('1 - Humano    2 - Computador \n')
    p = int(input('>_ '))
    jog = [0,0,0,0]
    t = random.sample(range(1,30),4)
    hvsc(win, p, t, jog, j, k)

######################################################
# Funcao com o algoritmo para a jogada do computador #
######################################################

def comp(t, jog, p, k):
    """Para este algoritmo sao necessarias 3 variaveis acumuladoras para
    contar quantos numeros ha no tabuleiro iguais a um(u), iguais a zero(z)
     maiores que um (o), iguais a dois (d) e mais 2 variaveis (a e b) para determinar
    aleatoriamente quais os indices que vao ser alvo de uma jogada"""
    a = 0
    b = 0
    z = 0
    u = 0
    o = 0
    d = 0
    
    for i in t:
        if i == 1:
            u += 1
        elif i == 0:
            z += 1
        elif i > 1:
            o += 1
        elif i == 2:
            d += 1
            
    if (z == 1 and u == 1) or (z == 1 and u == 2):
        """Se houver 1 zero e 1 um ou 1 zero e 2 uns os restantes numeros
        maiores que 1 no tabuleiro o comp ira reduzir aqueles maiores que
        um a um ficando um tabuleiro do tipo:  0 1 1 1  deixando margem
        para uma victoria na proxima jogada."""
        v = 0
        for n in t: 
            if n > 1:
                jog[v] = t[v]-1
                t[v] = 1
            v +=1
    elif z == 3 or z == 2:
        """Se houverem 3 ou 2 zeros no tabuleiro o comp ira por o tabuleiro
        a zeros e ganhar"""
        v = 0
        for n in t: 
            if n >= 1:
                jog[v] = t[v]
                t[v] = 0
            v +=1
    elif z == 1 and o == 3:
        """Se houverem 3 numeros maiores que um e 1 zero no tabuleiro o comp
        vai efectuar uma jogada aleatoria com os indices aleatorios a e b"""
        a, b = random.randint(0, 3), random.randint(0, 3)

        """na seguinte condicao e verificado se o indice a e diferente
        do indice b, e se o numero que esta na posicao a ou b e diferente
        de 1 e de 0 para que impedir que o range do randint seja de 1 a 1 ou
        de 1 a 0 o que e impossivel. Se esta condicao nao for cumprida e chamada
        de novo a funcao do algoritmo para obter outros valores para as
        variaveis a e b"""
        if a == b or(t[a] == 1 or t[a] == 0) or (t[b] == 1 or t[b] == 0):
            comp(t, jog, p, k)
        else:
            jog[a], jog[b] = random.randint(1, t[a]), random.randint(1, t[b])
            """se o resultado da jogada deixar mais um zero no tabuleiro vai
            ficar um tabuleiro do tipo 0 0 5 10 que nao e o que se quer pois
            vai dar a vitoria imediata ao jogador logo se isto acontecer
            vai ter que ser chamada a funcao do algoritmo novamente recursivamente
            para obter novos valores para as variaveis a e b e para a jogada"""
            if jog[a] == t[a] or jog[b] == t[b]:
                jog = [0,0,0,0]
                comp(t, jog, p, k)
            else:
                t = novotab(jog, t)
    elif u == 1 and o == 3:
        """se for detectado 1 um e 3 numeros maiores que 1 o comp ira colocar
        um desses 3 numeros maiores que um a dois ficando um tabuleiro do
        tipo 1 2 8 6 """
        a = random.randint(0, 3)

        """ apos ter sido verificado que o numero na posiçao a no tabuleiro
        e maior que 2, procede-se entao para a deteccao do numero de 2
        que ha no tabuleiro. Se houverem 2 dois, o outro numero maior que
        dois ira ser colocado a 2, ficando um tabuleiro do tipo 1 2 2 2.
        Se houver apenas 1 dois e colocado um dos outros numeros maiores
        que 2 a dois ficando um tabuleiro do tipo 1 2 2 8. Por ultimo
        se houverem 3 dois irá ser colocado 1 desses dois a um ficando um
        tabuleiro do tipo 1 2 2 1. """
        if d == 3:
            if t[a] == 1:
                comp(t, jog, p, k)
            else:
                jog[a] =  1
                t[a] = 1 
        else:
            if t[a] == 1 or t[a] == 2:
                comp(t, jog, p, k)
            else:
                jog[a] = t[a] - 2
                t[a] = 2
    elif u == 2 and o == 2:
        """Se houverem 2 uns e 2 numeros maiores que 1 o comp ira colocar um
        dos numeros maiores que um a zero e o outro a 1 para ficar um
        tabuleiro do tipo 1 1 1 0 garantindo assim a vitoria ao computador
        visto que qualquer que seja a jogada do jogadar o tabuleiro fica do tipo
        1 1 0 0 ou 1 0 0 0 """
        a, b = random.randint(0, 3), random.randint(0, 3)
        
        
        """na seguinte condicao e verificado se o indice a e diferente
        do indice b, e se os numeros que estao nas posicoes a ou b sao diferentes
        de 1. Se esta condicao nao for cumprida e chamada de novo a funcao
        do algoritmo recursivamente para obter outros valores para as variaveis
        a e b"""
        if a == b or t[a] == 1 or t[b] == 1:
            comp(t, jog, p, k)
        else:
            jog[a], jog[b] = t[a] - 1, t[b]

            t = novotab(jog, t)
    elif u == 3 and z == 1:
        """se o tabuleiro tiver 3 uns e 1 zero nao ha muito que se possa fazer
        visto que qualquer que seja a jogada o computador ira perder nesta situacao,
        logo ou tira 2 uns ou tira apenas 1. Aqui optamos por tirar 2 uns."""
        a, b = random.randint(0, 3), random.randint(0, 3)

        """na seguinte condicao e verificado se o indice a e diferente
        do indice b, e se os numeros que estao nas posicoes a ou b sao diferentes
        de 0 para nao resultar em tabuleiros com numeros negativos. Se esta
        condicao nao for cumprida e chamada de novo a funcao do algoritmo
        recursivamente para obter outros valores para as variaveis a e b"""
        if a == b or t[a] == 0 or t[b] == 0:
            comp(t, jog, p, k)
        else:
            jog[a], jog[b] = 1, 1
            t = novotab(jog, t)
    elif u == 3 and o == 1:
        """se forem detectados 3 uns e um numero maior que 1 o comp vai reduzir
        esse numero a 0 deixando um tabuleiro do tipo 1 1 1 0 que ira garantir
        a vitoria do computador """
        a = random.randint(0, 3)

        """na seguinte condicao e verificado se o numero que esta na posicao a
        e diferente de 1 garantir que o jogador na proxima jogada nao tenha
        hipotese de ganhar. Se esta condicao nao for cumprida e chamada de novo
        a funcao do algoritmo de novo a funcao do algoritmo recursivamente para
        obter outros valores para a variavel a"""
        if t[a] == 1:
            comp(t, jog, p, k)
        else:
            jog[a] = t[a]
            t = novotab(jog, t)
    elif u == 4:
        """se houverem 4 uns no tabuleiro o computador remove algum desses uns
        de modo a que se obtenha o tabuleiro vencedor para o computador do tipo
        1 1 1 0 """
        a = random.randint(0, 3)
        jog[a] = 1
        t = novotab(jog, t)
    else:
        """enquanto nao achar um 0 ou um 1 vai jogando aleatoriamente ate que se
        verifique o caso"""
        a, b = random.randint(0, 3), random.randint(0, 3)

        """na seguinte condicao e verificado se e reduzido algum numero do
        tabuleiro a zero, caso isto se verifique é chamada a funcao do
        algoritmo recursivamente para obter novos valores para a jogada"""
        jog[a], jog[b] = random.randint(1, t[a]), random.randint(1, t[b])
        if a == b and (jog[a] == t[a] or jog[b] == t[b]):
            jog = [0,0,0,0]
            comp(t, jog, p, k)
        else:
            t = novotab(jog, t)

    return jog, t
            
############################################################################
# Funcao principal/geral que contem o loop principal do modo hum. vs comp. #
############################################################################

def hvsc(win, p, t, jog, j, k):
    """loop principal do jogo: ira continuar neste loop até se verificar
    que o jogo terminou"""
    k = 'HvsC'
    while win == 0:
        if p == 1:
            mostrartab(t, k)
            
            jog = jogada(jog, p)

            y = inc(t, jog)
            
            limjog(p, jog, t, y, k)

            jog = [0, 0, 0, 0]

            # ao atribuir o valor computador a variavel p a funcao "salta" para
            # a parte do computador
            p = 'Computador'
        else:
            mostrartab(t, k)

            comp(t, jog, p, k)

            print('Computador:', jog[0], jog[1], jog[2], jog[3])

            gameover(t, p, k)

            # ao atribuir o valor 1 a variavel p a funcao "salta" para
            # a parte do jogador
            p = 1


                        #######################
######################### Modo gráfico - HvsH #################################           
                        #######################
      
def start(t,p):
    root.geometry("1024x800")
    root.resizable(FALSE, FALSE)

    varl1 = StringVar()
    varl2 = StringVar()
    varl3 = StringVar()
    varl4 = StringVar()

    F = Canvas(root, bg = "#A0DC6B", bd = 0, height = 800, width = 1024, relief = FLAT)

    Ecra = PhotoImage(file = "Ecrã.gif")

    F.create_image(0,0, anchor = NW, image = Ecra)
    F.pack()
############################################################

######################Colunas#########################
    cl1 = Canvas(root, bg = "#A0DC6B", bd = 0, relief = FLAT, height = 450, width = 70)
    cl1.place(x = 240, y = 160)

    cl2 = Canvas(root, bg = "#A0DC6B", bd = 0, height = 450, width = 70, relief = FLAT)
    cl2.place(x = 390, y = 160)

    cl3 = Canvas(root, bg = "#A0DC6B", bd = 0, height = 450, width = 70, relief = FLAT)
    cl3.place(x = 540, y = 160)

    cl4 = Canvas(root, bg = "#A0DC6B", bd = 0, height = 450, width = 70, relief = FLAT)
    cl4.place(x = 690, y = 160)
#####################################################

#############################Entries################################
    E1 = Entry(root, bg = "#A0DC6B", width = 5, font = ("Consolas", 12))
    E1.place(x = 250, y = 640)

    E2 = Entry(root, bg = "#A0DC6B", width = 5, font = ("Consolas", 12))
    E2.place(x = 400, y = 640)

    E3 = Entry(root, bg = "#A0DC6B", width = 5, font = ("Consolas", 12))
    E3.place(x = 550, y = 640)

    E4 = Entry(root, bg = "#A0DC6B", width = 5, font = ("Consolas", 12))
    E4.place(x = 700, y = 640)

    E1.insert(0, '0')
    E2.insert(0, '0')
    E3.insert(0, '0')
    E4.insert(0, '0')
####################################################################

###############################################Labels##########################################
    
    
    L1 = Label(root, bg = "#A0DC6B", textvariable = varl1 , relief = FLAT, font = ("Consolas", 12))
    L1.place(x = 264, y = 55)
    varl1.set(t[0])

    L2 = Label(root, bg = "#A0DC6B", textvariable = varl2 , relief = FLAT, font = ("Consolas", 12))
    L2.place(x = 415, y = 55)
    varl2.set(t[1])

    L3 = Label(root, bg = "#A0DC6B", textvariable = varl3 , relief = FLAT, font = ("Consolas", 12))
    L3.place(x = 565, y = 55)
    varl3.set(t[2])

    L4 = Label(root, bg = "#A0DC6B", textvariable = varl4 , relief = FLAT, font = ("Consolas", 12))
    L4.place(x = 715, y = 55)
    varl4.set(t[3])

    jogador = StringVar()

    mostrador = Label(root, bg = "#A0DC6B", textvariable = jogador, font = ("Consolas", 16), relief = FLAT)
    mostrador.place(x = 800, y = 80)

    def mudarjog(p):
        if p == 1:
            jogador.set('Jogador 1')
        elif p == 2:
            jogador.set('Jogador 2')

    mudarjog(p)

################################################################################################

##############################Criar Butões######################################
    def jogadag():
        k = 'HvsHg'
        
        jog = [int(E1.get()),int(E2.get()),int(E3.get()),int(E4.get())]

        y = inc(t, jog)

        if limjog(p, jog, t, y, k) == False:
            jogadag()

            
        cl1.delete(0, ALL)
        cl2.delete(0, ALL)
        cl3.delete(0, ALL)
        cl4.delete(0, ALL)

        E1.delete(0, END)
        E2.delete(0, END)
        E3.delete(0, END)
        E4.delete(0, END)

        E1.insert(0, '0')
        E2.insert(0, '0')
        E3.insert(0, '0')
        E4.insert(0, '0')

        c1=435
        c2=435
        c3=435
        c4=435
        
        for i in range(t[0]):
            cl1.create_image(0, c1, anchor = NW, image = barra)
            cl1.place(x = 240, y = 160)
            c1 -= 15

        for i in range(t[1]):
            cl2.create_image(0, c2, anchor = NW, image = barra)
            cl2.place(x = 390, y = 160)
            c2 -=15

        for i in range(t[2]):
            cl3.create_image(0, c3, anchor = NW, image = barra)
            cl3.place(x = 540, y = 160)
            c3 -=15

        for i in range(t[3]):
            cl4.create_image(0, c4, anchor = NW, image = barra)
            cl4.place(x = 690, y = 160)
            c4 -=15

        L1 = Label(root, bg = "#A0DC6B", textvariable = varl1 , relief = FLAT, font = ("Consolas", 12))
        L1.place(x = 264, y = 55)
        varl1.set(t[0])

        L2 = Label(root, bg = "#A0DC6B", textvariable = varl2 , relief = FLAT, font = ("Consolas", 12))
        L2.place(x = 415, y = 55)
        varl2.set(t[1])

        L3 = Label(root, bg = "#A0DC6B", textvariable = varl3 , relief = FLAT, font = ("Consolas", 12))
        L3.place(x = 565, y = 55)
        varl3.set(t[2])

        L4 = Label(root, bg = "#A0DC6B", textvariable = varl4 , relief = FLAT, font = ("Consolas", 12))
        L4.place(x = 715, y = 55)
        varl4.set(t[3])

        def gameovergraf():
            if (t[0] == 0 and t[1] == 0 and t[2] == 0 and t[3] == 0):
                win = 1
                if jogador.get() == 'Jogador 1':
                    messagebox.showinfo("Fim de jogo","Ganhou o Jogador 1!")
                    root.destroy()
                elif jogador.get() == 'Jogador 2':
                    messagebox.showinfo("Fim de jogo", "Ganhou o Jogador 2!")
                    root.destroy()

        gameovergraf()
        
        if jogador.get() == 'Jogador 1':
            jogador.set('Jogador 2')
        elif jogador.get() == 'Jogador 2':
            jogador.set('Jogador 1') 
        
################################################################################

########################### Funções dentro de funções ##########################
    barra = PhotoImage(file = "Barras.gif")
    c1=435
    c2=435
    c3=435
    c4=435
        
    for i in range(t[0]):
        cl1.create_image(0, c1, anchor = NW, image = barra)
        cl1.place(x = 240, y = 160)
        c1 -= 15

    for i in range(t[1]):
        cl2.create_image(0, c2, anchor = NW, image = barra)
        cl2.place(x = 390, y = 160)
        c2 -=15

    for i in range(t[2]):
        cl3.create_image(0, c3, anchor = NW, image = barra)
        cl3.place(x = 540, y = 160)
        c3 -=15

    for i in range(t[3]):
        cl4.create_image(0, c4, anchor = NW, image = barra)
        cl4.place(x = 690, y = 160)
        c4 -=15
    

    B = Button(root, text = "jogada", command = jogadag)
    B.place(x =830, y = 580)

            
    
    root.configure()
    root.mainloop()



    
menu()
