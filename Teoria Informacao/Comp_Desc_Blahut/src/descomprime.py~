import operator
import os

########################################################################
#                        DESCOMPRIME IMAGEM                            #
########################################################################

def getBitStringDescomprimida(filename):
    bitStringDescomprimida = ""
    grupoString = ""

    bitString = getBitString(filename)
    sizeBitString = len(bitString)
    
    grupo = int(bitString[0:8],2)
    lixo = int(bitString[8:16],2)
    header = getHeader(bitString[16:], grupo)
    arvore = gerarArvore(header, grupo)
    codigos = constroiCodAPartirDaArvore(arvore)

    dataPosition = len(header)+16
    for choke in range(dataPosition, sizeBitString, grupo):
        if sizeBitString - dataPosition != lixo:
            bitStringDescomprimida += bitList_to_bitString(codigos[int(choke, 2)])

    return bitStringDescomprimida

# New
# Funciona
# Devolve a arvore em post-order
def getPostOrder(bitString, grupo):
    numSimbolos = 2**grupo
    
    position = 0
    header = ""
    
    countNumSimbolo = 0
    bitsRemainder = 0
    isSimbolo = False
    
    while(countNumSimbolo != numSimbolos):
        c = bitString[position]
        if isSimbolo:
            bitsRemainder -= 1
            if bitsRemainder == 0:
                countNumSimbolo += 1
                isSimbolo = False
        else:
            if c == '1':
                bitsRemainder = grupo
                isSimbolo = True
        header += c
        position += 1

    return header

def bitString_to_bitList(bitString):
	return [int(l) for l in bitString]

def bitList_to_bitString(bitList):
    bitString = ""
    
    for bit in bitList:
        bitString += str(bit)
    
    return bitString

# New
# Funciona
def constroiCodAPartirDaArvore(arvore):
    if arvore == None:
        return {}
    else:
        if isNo(arvore[0]):
            no = {arvore[0]:[]}
            return no
        else:
            esquerda = insereZeros(constroiCodAPartirDaArvore(arvore[0]))
            direita = insereUns(constroiCodAPartirDaArvore(arvore[1]))
            esquerda.update(direita)
            return esquerda
# New
# Funciona
def insereZeros(dict):
    { k:(v.append(0)) for k,v in dict.items()}
    return dict
# New
# Funciona
def insereUns(dict):
    { k:(v.append(1)) for k,v in dict.items()}
    return dict

# New
# gera a arvore a partir da bitstring que representa a arvore em pos ordem
# Funciona
def gerarArvore(bitString, group, posicao=[]):
    resultado = [None, None]
    if posicao[0] > (len(bitString) - 1):
        return None

    if(posicao[0] < len(bitString) and bitString[posicao[0]] == '0' and resultado[0] == None):
        posicao[0] += 1
        resultado[0] = gerarArvore(bitString, group, posicao)
 
    if(posicao[0] < len(bitString) and bitString[posicao[0]] == '0' and resultado[1] == None):
        posicao[0] += 1
        resultado[1] = gerarArvore(bitString, group, posicao)

    if(posicao[0] < len(bitString) and bitString[posicao[0]] == '1' and resultado[0] == None):
        
        resultado[0] = int(bitString[posicao[0]+1:posicao[0] + group + 1],2)
        posicao[0] += 1 + group

    if(posicao[0] < len(bitString) and bitString[posicao[0]] == '1' and resultado[1] == None):
        
        resultado[1] = int(bitString[posicao[0]+1:posicao[0] + group + 1],2)
        posicao[0] += 1 + group

    return resultado
    
#print(gerarArvore('011100010101100100', 2, [0]))

"""faz o get do simbolo de um no"""           
def getSimbolo(no):
	return no
	
"""funcao que codifica um simbolo de acordo com uma arvore de huffman que recebe como 
argumento. Devolve a lista com o codigo corresponte ao simbolo.""" 
def codificaSimbolo(simbolo, numSimbolos):
	codigo = []
	num = numSimbolos
	ramoActual = arvore
	while not isNo(ramoActual) :
		if isNo(ramoActual) == list:
			codigo.append(0)
			ramoActual = ramoActual[0]
		elif type(ramoActual) == int:
			codigo.append(1)
			ramoActual = ramoActual[1]
	return codigo

def geraCodigos(arvore):
	simbolos = getSimbolos(arvore)
	return {s:codificaSimbolo(s, arvore) for s in simbolos}

"""funcao para criar no com o simbolo e numero de simbolos"""
def criaNo(simbolo):
	return simbolo

"""verifica se o objecto que recebe como argumento cumpre com as condicoes para ser um no
   devolve true se for um no e false caso nao seja"""
def isNo(x):
    return isinstance(x, int)

"""faz o get do simbolo de um no"""           
def getSimbolo(no):
	return no

"""faz o get do ramo direito da arvore de huffman"""
def getRamoDir(no):
	return no[1]

"""faz o get do ramo esquerdo da arvore de huffman"""
def getRamoEsq(no):
	return no[0]

def getSimbolos(t):
	if isNo(t):
		return [t]
	elif t != None:
		return getSimbolos(t)
	
		
"""retorna uma string com os bits da imagem"""
def getBitString(ficheiro):
    file = open(ficheiro, "rb").read()
    string = ""
    mascara = 1
    for byte in file:
        for i in range(7, -1, -1):
            string += str((byte>>i) & mascara)
    return string

"""Funcao para descodificar uma lista com uma sequencia de 0's e 1's devolvendo uma lista
   com os simbolos pela ordem que estao na sequencia recebida como argumento """
def descodificaBits(cod, arvore):
	if cod == []:
		return []
	ramoActual = arvore
	ramoSeguinte = None
	descodificacao = []
	while cod != []:
		ramoSeguinte = seleccionaRamo(cod[0], ramoActual)
		if isNo(ramoSeguinte):
			descodificacao.append(getSimbolo(ramoSeguinte))
			ramoActual = arvore
		else:
			ramoActual = ramoSeguinte
		del cod[0]
	return descodificacao
	
"""Selecciona o ramo a seguir de acordo com o bit lido, para o ramo 
   filho esquerdo se for 0 ou para o direito se for 1"""
def seleccionaRamo(bit, tree):
    if bit == 0:
        return getRamoEsq(tree)
    elif bit == 1:
        return getRamoDir(tree)	

def descomprime():
	ficheiro = ''
	ficheiro = input("Insira o ficheiro que deseja descomprimir(Do tipo ficheiro.cpbm) : ")
	while not os.path.exists(ficheiro):
		print("ERRO: Ficheiro nao existente.\n")
		ficheiro = input("Insira o ficheiro que deseja descomprimir(Do tipo ficheiro.cpbm) : ")
	grupo = ''
	numSimbolos = ''
	
	bitString = getBitString(ficheiro)
	for i in range(len(bitString)):
		if 0 <= i < 8:
			grupo += bitString[i]
		elif 8<=i<24:
			numSimbolos += bitString[i]
	bitString = bitString[24:]
	grupo = int(grupo, 2)
	numSimbolos = int(numSimbolos, 2)
	arvore = descodificaArvoreCods(bitString, numSimbolos, grupo)
	return arvore
	
