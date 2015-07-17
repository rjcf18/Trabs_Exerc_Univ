import operator
import copy
import os
from collections import Counter
from numpy import *
from numpy.linalg import eig
import sys
sys.setrecursionlimit(5000)

########################################################################
#                  COMPRESSOR IMAGENS FORMATO PBM                      #
########################################################################

"""esta funcao converte um simbolo para uma string binaria de acordo com
   o grupo, ou seja, se o grupo for por exemplo de 8 apenas um byte sera 
   necessario para guardar o simbolo que recebe como argumento"""

def converteIntParabitString(num, numBits):
    bitString = bin(num)[2:]
    if len(bitString) < numBits:
        bitString ='0'*(numBits - len(bitString)) + bin(num)[2:]
    return bitString

"""gera uma bitstring com a arvore em pos-ordem (fEsq, fDir, No)"""    
def postOrder(arvore, grupo):
    noEsq = getRamoEsq(arvore)
    noDir = getRamoDir(arvore)
    return "0"+getPostOrderAux(noEsq, grupo)+"0"+getPostOrderAux(noDir, grupo)


def getPostOrderAux(arvore, grupo):
    if isFolha(arvore):
        return "1"+converteIntParabitString(arvore[0], grupo)
    else:
        return "0"+getPostOrderAux(getRamoEsq(arvore), grupo)+"0"+getPostOrderAux(getRamoDir(arvore), grupo)

"""devolve um dicionario com os simbolos e as respectivas frequencias agrupando n a n"""
def getFrequencias(ficheiro, grupo):
    dic = {}
    total = 0
    bitString = getBitString(ficheiro)
    if len(bitString)%grupo != 0:
        bitString += '0'*(grupo - len(bitString)%grupo)
    for i  in range(0,len(bitString), grupo):
        grupoBits = bitString[i:i+grupo]
        grupoBits = int(grupoBits, 2)
        if grupoBits in dic:
            dic[grupoBits]+=1
        else:
            dic.update({grupoBits:1})
        total +=1
    #print(dic)
    return { int(key):(value/total) for key,value in dic.items()}

"""calcula a taxa de compressao para uma imagem agrupando n a n (grupo)"""
def calcTaxaCompressaoNominal(ficheiro, grupo):
    tamAntesComp = len(getBitString(ficheiro))
    tamDepoisComp = calcTamComp(ficheiro, grupo)
    return (1-((tamDepoisComp)/(tamAntesComp)))*100

"""calcula a taxa de compressao maxima para um certo tamanho de grupo"""

def calcTaxaMaxCompressao(ficheiro, grupo):
	return calcEntropia(ficheiro)/grupo*100

"""devolve o tamanho da imagem depois de comprimida em bits (sem contar com a arvore)"""
def calcTamComp(ficheiro, grupo):
    
    freq = getFrequencias(ficheiro, grupo)
    
    bitStringAntesComp = getBitString(ficheiro)
    tamAntesComp = len(bitStringAntesComp)
    
    cods = geraCodigos(ficheiro, grupo)
    
    listaFreqs = [(k,v) for k,v in freq.items()]
    
    tamDepoisComp = sum([ tamAntesComp*v*len(cods[k]) for k,v in listaFreqs])/grupo
    
    return tamDepoisComp

"""devolve o tamanho original da imagem em bits"""
def calcTamOriginal(ficheiro):
    return len(getBitString(ficheiro))

"""retorna uma string com os bits da imagem"""
def getBitString(ficheiro):
    file = open(ficheiro, "rb").read()
    string = ""
    mascara = 1
    for byte in file:
        for i in range(7, -1, -1):
            string += str((byte>>i) & mascara)
    return string


"""devolve uma string com os bits codificados para a imagem comprimida"""
def getBitStringComprimida(bitStringOrig, cods, grupo):
    
    stringComprimida = ""
    
    # Ja tem os zeros no fim falta codificar a bitString
    for i  in range(0,len(bitStringOrig), grupo):
        parbit = int(bitStringOrig[i:i+grupo],2)
        if parbit in cods:
            stringComprimida += bitList_to_bitString(cods[parbit])

    tamComp = len(stringComprimida)
    resto = tamComp%grupo
    if resto != 0:
        numZeros = (grupo - resto)
        stringComprimida += numZeros*'0'
    
    return stringComprimida

"""devolve uma string com os bits codificados para a imagem comprimida"""
def getBitStringFichComp(ficheiro, grupo):
    file = open(ficheiro, "rb").read()
    bitStringOrig = getBitString(ficheiro)
    tamOriginal = len(bitStringOrig)
    resto = tamOriginal%grupo
    
    if resto != 0:
        bitStringOrig += '0'*(grupo-resto)
    cods = {int(k):v for k,v in geraCodigos(ficheiro, grupo).items()}
   
    stringComprimida = ""
    mascara = (2**grupo)-1
    
    # Ja tem os zeros no fim falta codificar a bitString
    for byte in file:
        for i in range(0, 8, grupo):
            parbit = byte>>i & mascara
            if parbit in cods:
                for c in cods[parbit]:
                    stringComprimida += str(c)
    
    return stringComprimida

"""cria um tuplo com o simbolo e a frequencia associada a esse simbolo (no da arvore)"""
def criaFolha(Simbolo, freq):
    return (Simbolo, freq)

"""verifica se o objecto que recebe como argumento cumpre com as condicoes para ser um folha
   devolve true se for um folha e false caso nao seja"""
def isFolha(x):
    return isinstance(x, tuple) and \
            len(x) == 2 and \
            isinstance(x[0], int) and \
            isinstance(x[1], float)

"""faz o get do simbolo de uma folha"""           
def getSimbolo(folha):
    return folha[0]

"""faz o get do ramo direito da arvore de huffman"""
def getRamoDir(arvoreHuff):
    return arvoreHuff[1]

"""faz o get do ramo esquerdo da arvore de huffman"""
def getRamoEsq(arvoreHuff):
    return arvoreHuff[0]

""" se o objecto que receber como argumento for uma folha devolve uma lista com o simbolo dessa folha,
    caso seja uma arvore com mais de uma folha devolve a terceira posicao da lista que representa 
    o conjunto de simbolos da arvore ordenado pela frequencia """
def getSimbolos(t):
    if isFolha(t):
        return [getSimbolo(t)]
    else:
        return t[2]

"""cria uma arvore de huffman representada por uma lista composta por:
     - o ramo esquerdo, ramo direito, uma lista com os simbolos presentes
       na arvore e a soma das frequencias de cada ramo respectivamente"""
def criaArvoreHuff(ramoEsq, ramoDir):
    return [ramoEsq, ramoDir, getSimbolos(ramoEsq) + getSimbolos(ramoDir), getFreq(ramoEsq)+getFreq(ramoDir)]

'''se receber como argumento uma folha devolve a segunda posicao do tuplo, se for uma arvore devolve
 a ultima posicao da lista '''
def getFreq(arvoreHuff):
    if isFolha(arvoreHuff):return arvoreHuff[1]
    else: return arvoreHuff[3]

"""funcao que cria um dicionario com os simbolos e respectivos codigos  
   para um ficheiro agrupando n a n"""
def geraCodigos(ficheiro, grupo):
    arvore = constroiArvoreHuff(ficheiro, grupo)
    simbolos = getSimbolos(arvore)
    return {s:codificaSimbolo(s, arvore) for s in simbolos}
    
"""funcao que codifica um simbolo de acordo com uma arvore de huffman que recebe como 
argumento. Devolve a lista com o codigo corresponte ao simbolo.""" 
def codificaSimbolo(simbolo, arvore):
    codigo = []
    ramoActual = arvore
    while not isFolha(ramoActual):
        if simbolo in getSimbolos(getRamoEsq(ramoActual)):
            codigo.append(0)
            ramoActual = getRamoEsq(ramoActual)
        elif simbolo in getSimbolos(getRamoDir(ramoActual)):
            codigo.append(1)
            ramoActual = getRamoDir(ramoActual)
    return codigo

"""funcao que compara a frequencia de uma folha(folha1) com a frequencia de outra (folha2)"""
def comparaFolhas(folha1,folha2):
    freq1 = getFreq(folha1)
    freq2 = getFreq(folha2)
    if freq1 < freq2:
        return -1
    elif freq1 == freq2:
        return 0
    else:
        return 1

"""funcao para inserir um elemento na lista que ira representar a arvore de huffman.
    nesta funcao ir-se-a inserir o elemento no indice onde estiver um elemento com uma
    frequencia menor ou igual iterando a lista recursivamente"""
def insereElem(e, lista, pos):
    if pos == len(lista):
        lista.append(e)
    elif comparaFolhas(e, lista[pos]) == -1 or comparaFolhas(e, lista[pos]) == 0:
        lista.insert(pos, e)
    else:
        insereElem(e,lista, pos+1)

"""funcao que ira construir a arvore de huffman para um ficheiro agrupando n a n"""
def constroiArvoreHuff(ficheiro, grupo):
    freq = getFrequencias(ficheiro, grupo)
    listaFolhas = [(k,v) for k,v in freq.items()]
    listaFolhas.sort(key=lambda tup: tup[1])
    if len(listaFolhas) == 1:
        return listaFolhas[0]
    elif len(listaFolhas) == 0:
        return None
    else:
        while len(listaFolhas) > 2:
            novaFolha = criaArvoreHuff(listaFolhas[0], listaFolhas[1])
            del listaFolhas[0]
            del listaFolhas[0]
            insereElem(novaFolha, listaFolhas, 0)
        
        return criaArvoreHuff(listaFolhas[0], listaFolhas[1])

"""devolve o numero de simbolos numa arvore"""
def getNumSimbolos(arvore):
    return len(arvore[2])

"""calcula qual o modo de agrupar que irá maximizar a taxa de compressao do ficheiro"""
def grupoOptimo(ficheiro):
    #string = getBitString(ficheiro)
    #tamOriginal = len(string)
	grupo = 2
	taxaComp = 0
	print ("\nGrupo: ", grupo)
	print("Comprimento médio do codigo por simbolo: ", calcCompMedioCod(ficheiro, grupo))
	print("Taxa Compressao nominal (sem header)", calcTaxaCompressaoNominal(ficheiro,grupo))
	print("Taxa de compressão real (com header)" , calcTaxaCompressaoReal(ficheiro,grupo))
	#print("Taxa de Compressao Maxima: ", calcTaxaCompressaoMax(ficheiro, grupo))
	for g in range(3, 33):
		taxaCompAux = calcTaxaCompressaoReal(ficheiro, grupo)
		if (taxaCompAux >= taxaComp):
			grupo = g
			taxaComp = taxaCompAux
			print ("\nGrupo: ", grupo)
			print("Comprimento médio do codigo por simbolo: ", calcCompMedioCod(ficheiro, grupo))
			print("Taxa Compressao nominal (sem header)", calcTaxaCompressaoNominal(ficheiro,grupo))
			print("Taxa de compressão real (com header)" , calcTaxaCompressaoReal(ficheiro,grupo))
			#print("Taxa de Compressao Maxima: ", calcTaxaCompressaoMax(ficheiro, grupo))			
	
	return grupo

"""devolve a string binaria correspondente a lista de 0's e 1's que recebe 
   como argumento"""
def binListTobinStr(binList):
    return '0b' + ''.join(map(lambda x: str(x), binList))

"""cria um byte array a partir do conjunto de 1' e 0's que se encontra na lista
   que recebe como parametro """
def codeTobyteArray(cod):
    ba = bytearray()
    
    bincodC = cod[:]
    codlen = len(cod)
    r = codlen % 8
    if r != 0:
        for i in range(8 -r): cod.append(0)
    
    for i in range(0, len (bincodC)-8 +1, 8):
        ba.append(int(binListTobinStr(cod[i:i+8]), 2))
    return ba 

"""funcao que escreve o array de bytes para para o ficheiro comprimido"""
def escreveFicheiro(ficheiro, binLst):
    with open(ficheiro, 'wb') as out:
        out.write(codeTobyteArray(binLst))
        out.flush

"""calcula e converte o tamanho do ficheiro comprimido para binario"""
def getbitStringTamFichComp(ficheiro, grupo):
    tamFichComp = calcTamComp(ficheiro, grupo)
    return bin(tamFichComp)[2:]

"""cria uma lista com todos os bits da bitstring que recebe como argumento"""
def bitString_to_bitList(bitString):
    return [int(l) for l in bitString]

def bitList_to_bitString(bitList):
    bitString = ""

    for bit in bitList:
        bitString += str(bit)

    return bitString
    
"""gera a bitstring que ira conter o grupo, o numero de simbolos e a arvore em 
   pos ordem para posteriormente colocar antes da bitstring resultante da
   codificacao do ficheiro original"""    
def geraHeader(ficheiro, grupo, numZeros):
    arvore = constroiArvoreHuff(ficheiro, grupo)
    output = converteIntParabitString(grupo, 8) + converteIntParabitString(numZeros, 8) + postOrder(arvore, grupo)
    return output    

def comprimir(ficheiro):
    grupoOpt = grupoOptimo(ficheiro)
    mostraDados(ficheiro)
    print("\nO grupo para o qual a taxa de compressao e maxima e: " + str(grupoOpt) + 
          "\n Taxa de compressao para o grupo optimo: " + 
            str(calcTaxaCompressaoReal(ficheiro, grupoOpt)))
    grupo = grupoOpt
    
    tamOrig = len(getBitString(ficheiro))
    resto = tamOrig%grupo
    numZeros=0
    if resto != 0:
        numZeros = (grupo - resto)

    cods = geraCodigos(ficheiro, grupo)
    output = geraHeader(ficheiro, grupo, numZeros) + getBitStringComprimida(getBitString(ficheiro),cods, grupo)

    listaOutput = [int(b.strip()) for b in output]
    ficheiro = ficheiro[:len(ficheiro)-4]+'.cpbm'
    escreveFicheiro(ficheiro, listaOutput)


                    ##############################    
                    #     MARKOV E ESTACIONARIA   #
                    ##############################


def criaMatrizProbConjunta(bitString):
    numTransicoes = len(bitString) - 1
    zeroTozero = sum([1 for i in range(numTransicoes) if bitString[i] == '0' and bitString[i+1] == '0'])
    zeroToone = sum([1 for i in range(numTransicoes) if bitString[i] == '1' and bitString[i+1] == '0'])
    oneTozero = sum([1 for i in range(numTransicoes) if bitString[i] == '0' and bitString[i+1] == '1'])
    oneToone = sum([1 for i in range(numTransicoes) if bitString[i] == '1' and bitString[i+1] == '1'])
    total = zeroTozero+zeroToone+oneTozero+oneToone
    #print("0-0: ",zeroTozero, "1-0: ", oneTozero, "0-1: ",zeroToone, "1-1: ",oneToone)
    matriz = [[zeroTozero/total , oneTozero/total],
              [zeroToone/total  ,  oneToone/total]]

    return matriz

"""cria a matriz de markov para as transicoes do estado anterior para o 
   seguinte - P(Xt|Xt-1) - para uma determinada sequencia de bits"""
def criaMatrizMarkov(bitString):
    numTransicoes = len(bitString) - 1
    zeroTozero = sum([1 for i in range(numTransicoes) if bitString[i] == '0' and bitString[i+1] == '0'])
    zeroToone = sum([1 for i in range(numTransicoes) if bitString[i] == '1' and bitString[i+1] == '0'])
    oneTozero = sum([1 for i in range(numTransicoes) if bitString[i] == '0' and bitString[i+1] == '1'])
    oneToone = sum([1 for i in range(numTransicoes) if bitString[i] == '1' and bitString[i+1] == '1'])
    matrizMarkov = [[zeroTozero/(zeroTozero+zeroToone) , oneTozero/(oneTozero+oneToone)],
                    [zeroToone/(zeroTozero+zeroToone)  ,  oneToone/(oneTozero+oneToone)]]
    return matrizMarkov

"""calcula a distribuicao estacionaria para uma certa cadeia de markov
   recebendo como argumento a matriz dessa cadeia de markov"""
def calcDistEstacionaria(matriz):
    matriz = array(matriz)
    val, vec = eig(matriz) 
    estacionaria = array(vec[:,where(abs(val-1)<1e-8)[0][0]].flat)
    estacionaria = estacionaria / sum(estacionaria)

    return estacionaria

                        ###################    
                        #     ENTROPIAS    #
                        ###################
                    

"""calcula a entropia da imagem antes de comprimida usando as 
    frequencias calculadas - H(Xt) """
def calcEntropia(ficheiro):
    freq = getFrequencias(ficheiro, 1)
    return -sum ([f*log2(f) for f in freq.values()])    

"""calcula a entropia condicional para a imagem que recebe como argumento """
def calcEntropiaCondicional(ficheiro):
    bitString = getBitString(ficheiro)
    matriz = criaMatrizMarkov(bitString)
    estac = calcDistEstacionaria(matriz)
    listaProbs = [matriz[e][i] for e in range(len(matriz)) for i in range(len(matriz))]
    return -sum([estac[j]*sum([matriz[i][j]*log2(matriz[i][j]) for i in range(len(matriz))]) for j in range(len(estac))])
    
"""calcula a informacao mutua para a imagem que recebe como argumento"""
def calcInformacaoMutua(ficheiro):
    entropiaXt = calcEntropia(ficheiro)
    entropiaCond = calcEntropiaCondicional(ficheiro)
    return entropiaXt - entropiaCond

def calcEntropiaConjunta(ficheiro):
    bitString = getBitString(ficheiro)
    matriz = criaMatrizProbConjunta(bitString)
    listaProbs = [matriz[e][i] for e in range(len(matriz)) for i in range(len(matriz))]
    return -sum([p*log2(p) for p in listaProbs])

# calcula o comprimento medio
def calcCompMedioCod(ficheiro, grupo):
	freq = getFrequencias(ficheiro, grupo)
	cods = geraCodigos(ficheiro, grupo)
	return (sum([freq[i]*len(cods[i]) for i in range(len(freq)) if i in freq.keys()])/grupo)

def mostraDados(ficheiro):
	bitString = getBitString(ficheiro)
	matrizConj = criaMatrizProbConjunta(bitString)
	matrizMarkov = criaMatrizMarkov(bitString)
	
	print("\nEntropia do ficheiro - H(Xt): ", calcEntropia(ficheiro))
	print("\nEntropia Condicional - H(Xt|Xt-1): ", calcEntropiaCondicional(ficheiro))
	print("\nEntropia Conjunta - H(Xt, Xt-1): ", calcEntropiaConjunta(ficheiro))
	print("\nMatriz Markov H(Xt|Xt-1): \n",array(matrizMarkov))
	print("\nDistribuicao Estacionaria: ", calcDistEstacionaria(matrizMarkov))

def calcTaxaCompressaoMax(ficheiro, grupo):
	return (calcEntropia(ficheiro)/grupo)*100

def calcTaxaCompressaoReal(ficheiro, grupo):

    codigos = geraCodigos(ficheiro, grupo)
    bitStringOrig = getBitString(ficheiro)
    bitStringComp = getBitStringComprimida(bitStringOrig, codigos, grupo)
    header = geraHeader(ficheiro, grupo, grupo-(len(bitStringOrig)%grupo))

    return (1 - (len(bitStringComp)+len(header))/len(bitStringOrig))*100

	

#############################################################################################
