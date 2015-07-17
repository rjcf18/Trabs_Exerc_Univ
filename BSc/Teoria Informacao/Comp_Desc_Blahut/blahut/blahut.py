from numpy import *
from ast import literal_eval
import sys


			##############################################
			#		CAPACIDADE DO CANAL - BLAHUT		 #
			##############################################

######################
# Exemplos de canais #
######################

#Canal binario simetrico (distribuicao uniforme - 1/2)
c1 = [[0.8, 0.2],
      [0.2, 0.8]]
      
#Canal binario nao simetrico (distribuicao uniforme - 1/2)
c2 = [[0.6, 0.7],
	  [0.4, 0.3]]

#Canal binario sem erros (distribuicao uniforme - 1/2)
c3 = [[1, 0],
	  [0, 1]]

#Canal binario com perdas (distribuicao uniforme - 1/2)
c4 = [[0.8,   0],
	  [0.2, 0.2],
	  [0  , 0.8]]

#Canal com saidas nao sobrepostas (distribuicao uniforme - 1/2)	  
c5 = [[0.5 ,   0],
	  [0.5 ,   0],
	  [0   , 0.3],
	  [0   , 0.7]]
	  	  
#Maquina de escrever ruidosa 9 chars (distribuicao uniforme - 1/9)
c6 = [[0.5, 0 , 0 ,0  ,0  ,0  ,0  ,0  ,0.5],
	  [0.5,0.5, 0 ,0  ,0  ,0  ,0  ,0  , 0 ],
	  [ 0 ,0.5,0.5,0  ,0  ,0  ,0  ,0  , 0 ],
	  [ 0 , 0 ,0.5,0.5,0  ,0  ,0  ,0  , 0 ],
	  [ 0 , 0 , 0 ,0.5,0.5,0  ,0  ,0  , 0 ],
	  [ 0 , 0 , 0 ,0  ,0.5,0.5,0  ,0  , 0 ],
	  [ 0 , 0 , 0 ,0  ,0  ,0.5,0.5,0  , 0 ],
	  [ 0 , 0 , 0 ,0  ,0  ,0  ,0.5,0.5, 0 ],
	  [ 0 , 0 , 0 ,0  ,0  ,0  ,0  ,0.5,0.5]]

"""calculo da matriz """
def calcCj(matriz, p, c):
	dimMatriz = (len(matriz), len(matriz[0]))	
	#Calculo  Cj
	for j in range(dimMatriz[1]):
		somatoriok = 0
		for k in range(dimMatriz[0]):
			somatorioj = 0
			somatorioj = sum([p[x]*matriz[k][x] for x in range(dimMatriz[1])])
			if matriz[k][j] ==  0:
				logaritmo = 0
			else:
				logaritmo = log2(matriz[k][j]/somatorioj)
			somatoriok += matriz[k][j]*logaritmo
		c[j] = 2**(somatoriok)
	return c

def calcIl(p, c):
	tamMatriz = len(p)
	#Limite inferior da capacidade do canal (Il) 
	somatoriok = 0
	somatoriok = sum([p[j]*c[j] for j in range(tamMatriz)])
	return log2(somatoriok)

def calcIu(c):	
	#Limite superior da capacidade do canal (Iu)
	return log2(max(c))	

def blahut(matriz, erro):
	dimMatriz = (len(matriz), len(matriz[0]))
	
	""" Distribuicao de probabilidades uniforme de acordo com a 
	matriz de transicoes recebida"""
	p = [1/dimMatriz[1] for i in range(dimMatriz[1])]
	
	"""lista com as diferentes capacidades do canal que irao ser 
	 calculadas ao longo das iteracoes do algoritmo"""
	c = [0.0 for i in range(dimMatriz[1])]  
	while True:
		
		c = calcCj(matriz, p, c)
		
		Il = calcIl(p, c)
		print("\nIl: ", Il) 
		
		Iu = calcIu(c)
		print("Iu: ", Iu)
		
		diferenca = Iu - Il
		print("\nDiferenca: ", diferenca)
		
		if diferenca < erro or diferenca == 0:
			capacidadeMax = Il # abordagem conservadora
			if capacidadeMax == 1:
				print("\nA capacidade maxima e de: 1 bit.")
			else:
				print("\nA capacidade maxima e de: " + str(capacidadeMax)+" bits." )
			break
		else:
			sumPjCj = sum([p[i]*c[i] for i in range(dimMatriz[1])])
			p = [p[j]*(c[j]/sumPjCj) for j in range(dimMatriz[1])]

"""verifica se o conteudo da string e um float fazendo um try"""
def isFloat(string):
    try:
        float(string)
        return True
    except ValueError:
        return False

"""descodificar uma expressao dentro de uma string, por exemplo,
    uma string '[[1,2],[3,4]]' para uma lista [[1,2],[3,4]]"""
def literalEval(s):
	try:
		le = literal_eval(s)
		return le
	except ValueError:
		return False

def main():
	while True:
		opcao = ''
		print("\n              ######################################################")
		print("              #      ALGORITMO DE BLAHUT - CAPACIDADE DO CANAL     #")
		print("              ######################################################")
		print("\nDeseja calcular a capacidade para que canal?: ",
			  "\n1 - Canal binario simetrico (distribuicao uniforme - 1/2).",
			  "\n2 - Canal binario nao simetrico (distribuicao uniforme - 1/2).",
			  "\n3 - Canal binario sem erros (distribuicao uniforme - 1/2).",
			  "\n4 - Canal binario com perdas (distribuicao uniforme - 1/2).",
			  "\n5 - Canal com saidas nao sobrepostas (distribuicao uniforme - 1/2).",
			  "\n6 - Maquina de escrever ruidosa 9 chars (distribuicao uniforme - 1/9).",
			  "\n7 - Inserir uma matriz de transicoes para P(Xt|Xt-1).",
			  "\n8 - Sair.")
		opcao = input("\n>>> ")
		while not opcao.isdigit() or not (0<int(opcao)<9):
			print("Erro: Opcao invalida. Insira uma opcao valida (de 1 a 8)")
			opcao = input("\n>>> ")
		opcao = int(opcao)
		if opcao == 8:
			sys.exit()
		erro = input("\nInsira o erro (epsilon) com que deseja calcular a capacidade: ")
		while not isFloat(erro) or float(erro) < 0:
			print("Erro: Valor invalido. Insira um valor valido para o erro(ex.: '0.01', '1',...).")
			erro = input("\n>>> ")
		erro = float(erro)
		if opcao == 1:
			print("\nMatriz: ")
			print(array(c1))
			blahut(c1,erro)
		elif opcao ==  2:
			print("\nMatriz: ")
			print(array(c2))
			blahut(c2,erro)
		elif opcao ==  3:
			print("\nMatriz: ")
			print(array(c3))
			blahut(c3,erro)
		elif opcao ==  4:
			print("\nMatriz: ")
			print(array(c4))
			blahut(c4,erro)
		elif opcao ==  5:
			print("\nMatriz: ")
			print(array(c5))
			blahut(c5,erro)
		elif opcao ==  6:
			print("\nMatriz: ")
			print(array(c6))
			blahut(c6,erro)
		elif opcao ==  7:
			print("\nInsira a matriz do canal para o qual deseja calcular a capacidade: ")
			print(" Por exemplo: " + str([[0.5,0.5],[0.5,0.5]]))
			m = input(">>> ")
			le = literalEval(m)
			while not isinstance(le, list) or le == False:
				print("Erro: Insira uma matriz valida.")
				m = input("\n>>> ")
				le = literalEval(m)
			blahut(le, erro)
		print("\nDeseja continuar a calcular a capacidade de canais? ")
		print("1 - Sim")		
		print("2 - Nao (Sair)")
		opcao2 = input("\n>>> ")
		while not opcao2.isdigit() or not (0<int(opcao2)<3):
			print("Erro: Opcao invalida. Insira uma opcao valida (de 1 ou 2)")
			print("\nDeseja continuar a calcular a capacidade de canais? ")
			print("1 - Sim")		
			print("2 - Nao (Sair)")
			opcao2 = input("\n>>> ")
		opcao2= int(opcao2)
		if opcao2 == 2:
			sys.exit()
			
if __name__ ==  "__main__":
	main();
