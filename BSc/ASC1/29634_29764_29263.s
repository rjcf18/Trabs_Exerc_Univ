.data
Token:.space 150
Entrada:.space 150
Pilha:.space 1024

ZERO:.asciiz "0"
Neg:.asciiz "neg"
Swap:.asciiz "swap"
Del:.asciiz "del"
Clear:.asciiz "clear"
Dup:.asciiz "dup"
Plus:.asciiz "+"
Minus:.asciiz "-"
Times:.asciiz "*"
Div:.asciiz "/"
Mostra_pilha:.asciiz "Pilha: \n"
Consola:.asciiz "\n >> "
BR:.asciiz "\n\n"
Invalid_Caracter:.asciiz "ERRO: foi inserido um caractere inválido..."
Pilha_vazia:.asciiz "(vazia)"
EXIT:.asciiz "exit"
DivBZ:.asciiz "ERRO, n√£o se pode dividir por zero"

.text

	la $t0, Pilha
	li $t1, '\0'
	sw $t1, 0($t0)
main:
	
	jal Print_Pilha
	nop
	
	la $t0, Pilha
	
	jal Input
	nop
	
	move $a0, $v0
	
	addi $sp, $sp, -4	#
	sw $a0, 0($sp)		#
				#
	la $a1, EXIT		#
				# Terminar o programa
	jal StrComp		#
	nop			#
				#
	lw $a0, 0($sp)		#
	addi $sp, $sp, 4	#
	
	bne $v0, $zero, ENDPROGRAM
	nop
		la $a1, Token
		jal StrToken
		nop
	
	j main

#########################################
# Função para converter de String para Inteiro
# Param: a0(String)
# Return: v0 (Inteiro) 
#########################################
Atoi:
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	
	add $t2, $zero, $zero
sum_loop:
	lb $t1, ($a0) # load the byte *S into $t1, 
	addu $a0, $a0, 1 # and increment S,
	## use 10 instead of ÔøΩ\nÔøΩ due to SPIM bug!
	beq $t1, 10, end_sum_loop
	blt $t1, '0', end_sum_loop 
	bgt $t1, '9', end_sum_loop
		mul $t2, $t2, 10
		sub $t1, $t1, '0'
		add $t2, $t2, $t1
	b sum_loop 
end_sum_loop:
	move $v0, $t2
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	nop
###################END###################

#########################################
# Função para mostrar o conteúo da pilha 
# Param: none
# Return: none
#########################################
Print_Pilha:
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	
	la $a0, Mostra_pilha
	li $v0, 4
	syscall
	
	la $s1, Pilha
	li $s0, 0	# Counter
	li $t0, 0x3b9ac9ff
loop_print_pilha:
	lw $t1, 0($s1)
	
	bne $t1, $t0 , Not_zero
	nop
		la $a0, ZERO
		jal Print
		nop
		
		addi $s1, $s1, 4	# Incrementa a Pilha
		addi $s0, $s0, 1	# Incrementa o Counter
		j loop_print_pilha
Not_zero:
	
	beq $t1, '\0', END_print_pilha
	nop
		move $a0, $t1
		li $v0, 1	# serviÔøΩo de Print Integer
		syscall
		
		la $a0, BR
		li $v0, 4
		syscall
		
		addi $s1, $s1, 4	# Incrementa a Pilha
		addi $s0, $s0, 1	# Incrementa o Counter
		j loop_print_pilha
		#addi 
END_print_pilha:
	bne $s0, $zero, Nao_vazia
	nop
		la $a0, Pilha_vazia
		li $v0, 4	# serviÔøΩo de Print String
		syscall	
Nao_vazia:
	lw $s0, 0($sp)
	lw $s1, 4($sp)	
	lw $ra, 8($sp)
	addi $sp, $sp, 8
	jr $ra
	nop

###################END###################

#########################################
# Função para inserir na pilha 1 número na pilha
# Param: a0(String)
# Return: none
#########################################
Insere_Pilha:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $a0, 8($sp)
	
	jal Atoi
	nop
	move $a0, $v0
	
	la $s0, Pilha
loop2:
	lw $t0, 0($s0)
	beq $t0, '\0', END_loop_Pilha
	nop
		addi $s0, $s0, 4
		j loop2
		nop
END_loop_Pilha:	
	sw $a0, 0($s0)
	addi $s0, $s0, 4
	li $t0, '\0'
	sw $t0, 0($s0)
	#############
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	nop
###################END###################

#########################################
# Função para fazer o print duma String na Consola
# Param: a0(String)
# Return: none
#########################################
Print:
	li $v0, 4
	syscall
	la $a0, BR
	li $v0, 4
	syscall
	jr $ra
	nop
###################END###################

#########################################
# FunÔøΩÔøΩo para ler uma String
# Param: none
# Return: v0 (EndereÔøΩo da entrada)
#########################################
Input:
	la $a0, Consola
	li $v0, 4	# serviÔøΩo de Print
	syscall
	
	la $a0, Entrada
	li $a1, 150	# espaÔøΩo para a entrada
	li $v0, 8	# serviÔøΩo
	syscall
	
	move $v0, $a0 
	jr $ra
	nop
###################END###################

#########################################
# FunÔøΩÔøΩo para para partir a String por espaÔøΩos
# Param: a0(endereÔøΩo do Input), a1 ( EndereÔøΩo do Token)
# Return: none
#########################################
StrToken:
	addi $sp, $sp, -12
	sw $ra, 8($sp)	# Volta para o Main
	sw $a1, 4($sp)	# EndereÔøΩo do Token
	sw $a0, 0($sp)	# EndereÔøΩo do Input
	
loop:
	lb $t0, 0($a0) # lÔøΩ um caractere da String de entrada
	
	beq $t0,'\0', END_StrToken # verifica o fim da String de entrada
	beq $t0, 0x0a, END_StrToken
		beq $t0, 0x20, Espaco # Salta quando $s0 for um espaÔøΩo
		nop
			sb $t0, 0($a1)
			addi $a1, $a1, 1	# incrementa o Token
			addi $a0, $a0, 1	# incrementa a Entrada
	j loop
	nop
Espaco:
	li $t0, '\0'
	sb $t0, 0($a1)
	
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	la $a0, Token
	jal Verifica	# Verifica o Token
	nop
	
	lw $a0, 4($sp)
	la $a1, Token
	addi $sp, $sp, 8
	
	addi $a0, $a0, 1	# avanÔøΩa uma posiÔøΩÔøΩo no Input
	
	j loop
	nop
END_StrToken:
	li $t0, '\0'
	sb $t0, 0($a1)
	
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	la $a0, Token
	jal Verifica	# Verifica o Token
	nop
	
	lw $a0, 4($sp)
	sw $a1, 0($sp)
	addi $sp, $sp, 8
	
	lw $ra, 8($sp)	# Back to main
	lw $a1, 4($sp)	# EndereÔøΩo do Token
	lw $a0, 0($sp)	# EndereÔøΩo do Input
	addi $sp, $sp, 12
	jr $ra
	nop
	
###################END###################

#########################################
# FunÔøΩÔøΩo para verificar se o Input ÔøΩ um nÔøΩ, operaÔøΩÔøΩo ou comando
# Param: (EndereÔøΩo do Token)
# Return: 0 (False) or 1 (True)
#########################################
Verifica:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	jal LenStr
	nop
	move $t0, $v0	# Tamanho do Token
	
	lw $a0, 0($sp)
	
	slti $t1, $t0, 2
	beq $t1, $zero, BIGT_ONE	# Salta se o tamanho do Token for maior do que um
	nop				# Um Token de tamanho 1 sÔøΩ pode ser uma operaÔøΩÔøΩo ou um nÔøΩmero
		lb $t2, 0($a0)
		
		bne $t2, 0x2a, CASE2	# MULT
		nop
			# Verifica se hÔøΩ pelo menos dois nÔøΩ na pilha
			# e Multiplica os dois nÔøΩ do topo da pilha
			la $a0, Pilha
			jal MULT
			nop
		j END_verifica
		nop
	CASE2:	bne $t2, 0x2b, CASE3	# PLUS
		nop
			# Verifica se hÔøΩ pelo menos dois nÔøΩ na pilha
			# e Soma os dois nÔøΩ do topo da pilha
			la $a0, Pilha
			jal PLUS
			nop
		j END_verifica
		nop	
	CASE3:	bne $t2, 0x2d, CASE4	# MINUS
		nop
			# Verifica se hÔøΩ pelo menos dois nÔøΩ na pilha
			# e Subtrai os dois nÔøΩ do topo da pilha
			la $a0, Pilha
			jal SUBT
			nop
		j END_verifica
		nop
	CASE4:	bne $t2, 0x2f, CASE_ZERO	# DIVISION
		nop
			# Verifica se hÔøΩ pelo menos dois nÔøΩ na pilha
			# e Divide os dois nÔøΩ do topo da pilha
			# O numero do topo da pilha ÔøΩ o denominador
			# e o imediatamente a seguir ÔøΩ o numerador
			# Verificar se o denominador ÔøΩ diferente de ZERO
			la $a0, Pilha
			jal DIVISION
			nop
		j END_verifica
		nop
	
	CASE_ZERO:
		bne $t2, 0x30, CASE5
		nop
			jal Zero
			nop
			
		j END_verifica
		nop
	CASE5:
		slti $t1, $t2, 0x31
		slti $t3, $t0, 0x40	# verifica se o caractere estÔøΩ entre os valores hexadecimais 0x30 e 0x39, inclusive.
		beq $t1, $t3, NOTHING
		nop
			# Converte para Inteiro 
			# e coloca o nÔøΩmero na pilha
			la $a0, Token
			jal Insere_Pilha
			nop
			#la $a0, NUMERO
			#jal Print
			#nop
		j END_verifica
		nop
BIGT_ONE:
#loop1:
	#lb $t0, 0($a0)	# LÔøΩ um caractere da String
	beq $t0, $zero, CASE6
	nop	
		la $a1, Neg	# NEGATION
		jal StrComp
		nop
		beq $v0, $zero, CASE6
		nop
			# Verifica se hÔøΩ pelo menos um nÔøΩ na pilha
			# e troca o sinal do mesmo
			la $a0, Pilha
			jal NEGATION
			nop
		j END_verifica
		nop
	CASE6:	la $a1, Swap	# SWAP
		jal StrComp
		nop
		beq $v0, $zero, CASE7
		nop
			# Verifica se hÔøΩ pelo menos dois nÔøΩ na pilha
			# e troca-os de lugar
			la $a0, Pilha
			jal TROCA
			nop
		j END_verifica
		nop
	CASE7:	la $a1, Del	# DELETE
		jal StrComp
		nop
		beq $v0, $zero, CASE8
		nop
			# Verifica se hÔøΩ pelo menos um nÔøΩ na pilha
			# e elimina-o
			la $a0, Pilha
			jal DELETE
			nop
		j END_verifica
		nop
	CASE8:	la $a1, Clear	# CLEAR
		jal StrComp
		nop
		beq $v0, $zero, CASE9
		nop
			# Limpa a pilha
			la $a0, Pilha
			jal LIMPAR
			nop
		j END_verifica
		nop
	CASE9:	la $a1, Dup	# DUPLICATE
		jal StrComp
		nop
		beq $v0, $zero, CASE10
		nop
			# Duplica o nÔøΩ que estÔøΩ no topo da pilha
			la $a0, Pilha
			jal DUPLICATE
			nop
		j END_verifica
		nop
	CASE10:
		loop1:
			lb $t0, 0($a0)
			beqz $t0, E_NUM
			nop
				slti $t1, $t0, 0x30
				slti $t2, $t0, 0x40	# verifica se o caractere estÔøΩ entre os valores hexadecimais 0x30 e 0x39, inclusive.
				beq $t1, $t2, NOTHING
				nop		
					addi $a0, $a0,1
				j loop1
				nop
		E_NUM:
			#la $a0, NUMERO
			#jal Print
			#nop
			la $a0, Token
			jal Insere_Pilha
			nop
			j END_verifica
			nop
	NOTHING:
		li $v0, 0
		la $a0, Invalid_Caracter
		jal Print
		nop
	
END_verifica:

	lw $ra, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	nop
	
###################END###################


###################FUNCOES###############


#########################################
# FunÔøΩÔøΩo que soma os dois ultimos nÔøΩmeros da pilha
# Param: a0(Pilha) 
#########################################

PLUS:
	li $t3, 0x3b9ac9ff
IminyourloopSoma:
	lw $t0, 0($a0)
	beq $t0, '\0', END_PLUS
	nop
		addi $a0, $a0, 4
		j IminyourloopSoma
		nop
END_PLUS:
	sub $a0, $a0, 8
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	bne $t1, $t3, SALTA_ZERO
	nop
		bne $t2, $t3, ZERO_T2
		nop
			sw $t3, 0($a0)
			j FIM_PLUS
			nop
ZERO_T2:
	sw $t2, 0($a0)
						
SALTA_ZERO:
	bne $t2, $t3, SALTA_ZERO_2
	nop
		bne $t1, 0x3b9ac9ff, ZERO_T1_2
		nop
			sw $t3, 0($a0)
			j FIM_PLUS
			nop
ZERO_T1_2:
	sw $t1, 0($a0)
SALTA_ZERO_2:
	add $t1, $t1, $t2
	sw $t1, 0($a0)
FIM_PLUS:
	li $t0, '\0'
	sw $t0, 4($a0)
	jr $ra
	nop

#########################################
# FunÔøΩÔøΩo que subtrai os dois ultimos nÔøΩmeros da pilha
# Param: a0(Pilha) 
#########################################

SUBT:
	li $t3, 0x3b9ac9ff
IminyourloopSub:
	lw $t0, 0($a0)
	beq $t0, '\0', END_SUBT
	nop
		addi $a0, $a0, 4
		j IminyourloopSub
		nop
END_SUBT:
	sub $a0, $a0, 8
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	bne $t1, $t3, SUBT_ZERO_T1 # caso o t1 seja zero
	nop
		add $t2, $zero, $t2
		sw $t2, 0($a0)
		j END_SUBT_ZERO
		nop
SUBT_ZERO_T1:
	bne $t2, $t3, SUBT_ZERO	# caso o t2 seja zero
	nop
		sw $t1, 0($a0)
		j END_SUBT_ZERO
		nop
SUBT_ZERO:
	sub $t1, $t1, $t2
END_SUBT_ZERO:
	sw $t1, 0($a0)
	li $t0, '\0'
	sw $t0, 4($a0)
	jr $ra
	nop
#########################################
# FunÔøΩÔøΩo que multiplica os 2 ultimos nÔøΩmeros da pilha
# Param: a0(Pilha) 
#########################################

MULT:
	li $t3, 0x3b9ac9ff
IminyourloopMul:
	lw $t0, 0($a0)
	beq $t0, '\0', END_MULT
	nop
		addi $a0, $a0, 4
		j IminyourloopMul
		nop
END_MULT:
	sub $a0, $a0, 8
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	bne $t2, $t3, MULT_ZERO
	nop
		sw $t3, 0($a0)
	bne $t1, $t3, MULT_ZERO
	nop
		sw $t3, 0($a0)
MULT_ZERO:	
	
	mul $t1, $t1, $t2
	sw $t1, 0($a0)
	li $t0, '\0'
	sw $t0, 4($a0)
	jr $ra
	nop

#########################################
# FunÔøΩÔøΩo que divide os ultimos dois numeros da pilha (o √∫ltimo corresponde ao denominador)
# Param: a0(Pilha) 
#########################################

DIVISION:
IminyourloopDiv:
	lw $t0, 0($a0)
	beq $t0, '\0', END_DIV
	nop
		addi $a0, $a0, 4
		j IminyourloopDiv
		nop
END_DIV:
	sub $a0, $a0, 8
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	beq $t2, 0x3b9ac9ff, DividedByZero
	nop
	div $t1, $t1, $t2
	sw $t1, 0($a0)
	li $t0, '\0'
	sw $t0, 4($a0)
	jr $ra
	nop


#########################################
# FunÔøΩÔøΩo chamada, caso o divisor seja 0
# Param: a0(String) 
#########################################

DividedByZero:
la $a0, DivBZ
li $v0, 4
syscall
jr $ra
nop

#########################################
# Fun√ß√£o que troca o sinal do ultimo elemento da pilha
# Param: a0(Pilha) 
#########################################

NEGATION:

IminyourloopNeg:
	lw $t0, 0($a0)
	beq $t0, 0x3b9ac9ff, NEGATION_ZERO
	beq $t0, '\0', END_NEG
	nop
		addi $a0, $a0, 4
		j IminyourloopNeg
		nop
END_NEG:
	sub $a0, $a0, 4
	lw $t1, 0($a0)
	move $t2, $zero
	sub $t1, $t2, $t1
	sw $t1, 0($a0)
NEGATION_ZERO:
	jr $ra
	nop

#########################################
# Fun√ß√£o que troca os dois ultimos elementos da pilha
# Param: a0(Pilha) 
#########################################
	
TROCA:
IminyourloopSwap:
	lw $t0, 0($a0)
	beq $t0, '\0', END_SWAP
	nop
		addi $a0, $a0, 4
		j IminyourloopSwap
		nop
END_SWAP:
	sub $a0, $a0, 8
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	sw $t2, 0($a0)
	sw $t1, 4($a0)
	jr $ra
	nop

#########################################
# Fun√ß√£o que elimina o ultimo elemento da pilha
# Param: a0(Pilha) 
#########################################
	
DELETE:
IminyourloopDel:
	lw $t0, 0($a0)
	beq $t0, '\0', END_DEL
	nop
		addi $a0, $a0, 4
		j IminyourloopDel
		nop
END_DEL:
	sub $a0, $a0, 4
	li $t0, '\0'
	sw $t0, 4($a0)

#########################################
# Fun√ß√£o que limpa a pilha
# Param: a0(Pilha) 
#########################################

LIMPAR:
li $t0, '\0'
sw $t0, 0 ($a0)
jr $ra
nop

#########################################
# Fun√ß√£o que insere o ultimo elemento da pilha de novo
# Param: a0(Pilha) 
#########################################
	
DUPLICATE:
IminyourloopDup:
	lw $t0, 0($a0)
	beq $t0, '\0', END_DUP
	nop
		addi $a0, $a0, 4
		j IminyourloopDup
		nop

END_DUP:

	sub $a0, $a0, 4
	lw $t1, 0($a0)
	addi $a0, $a0, 4
	sw $t1, 0($a0)
	jr $ra
	nop

###################END###################


#########################################
# FunÔøΩÔøΩo para comparar duas Strings
# Param: a0 (Input), a1(Comando)
# Return: 0 (False) or 1 (True)
#########################################

StrComp:
	addi $sp, $sp, -28 # reserva espaÔøΩo na pilha
	sw $s0, 24($sp)	# INPUT
	sw $s1, 20($sp)	# COMMAND
	sw $s2, 16($sp)	# Tamanho da String INPUT
	sw $s3, 12($sp)	# Tamanho da String COMMAND
	sw $a1, 8($sp)
	sw $a0, 4($sp)
	sw $ra, 0($sp)	# endereÔøΩo para sair da funÔøΩao
	
	jal LenStr	# 
	nop		#
	addi $s2, $v0, 0	# Retorna o tamanho da String de INPUT
	
	addi $a0, $a1, 0
	jal LenStr
	nop
	addi $s3, $v0, 0	# Retorna o tamanho da String COMMAND
	
	lw $a1, 8($sp)	# Retoma o valor do COMMAND
	lw $a0, 4($sp)	# Retoma o valor do INPUT
	
	li $v0, 0
	
	bne $s2,$s3, END_StrComp # Salta se nÔøΩo tiverem o mesmo tamanho
	nop
FOR_Str_Comp:	
		lb $s0, 0($a0)	# lê uma posição do INPUT
		lb $s1, 0($a1)	# lê uma posição do COMANDO
		
		beq $s1, '\0', EQUALS	# Verifica o fim da String
		
			bne $s0, $s1, END_StrComp	# Compara as posições das duas Strings
			nop
				addi $a0, $a0, 1	# Avança uma posição no array INPUT
				addi $a1, $a1, 1	# Avança uma posição no array COMMAND
			
		j FOR_Str_Comp
		nop
EQUALS:
	li $v0, 1
	
END_StrComp:
	
	lw $s0, 24($sp)
	lw $s1, 20($sp)	
	lw $s2, 16($sp)
	lw $s3, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 28	# liberta o espaço da pilha
	jr $ra
	nop
###################END###################	
	
	
#########################################
# Função para saber o tamanho de um array
# Param: $a0(Array de String)
# Return: $v0(tamanho do Array)
#########################################		
LenStr:
	addi $sp, $sp, -16 # reserva espaÔøΩo na pilha
	sw $s0, 12($sp)	# Guarda os valores das "variÔøΩveis locais"
	sw $s1, 8($sp)	#
	sw $a0, 4($sp)
	sw $ra, 0($sp)	# endereÔøΩo para sair da funÔøΩao
	
	addi $s0, $s0, 0	# Inicializa as variÔøΩveis locais
	addi $s1, $s1, 0	#
	
	addi $s1, $zero, 0 # Contador
	addi $v0, $zero, 0
FOR1:	
	lb $s0, 0($a0)
	beq $s0, $zero, END
	beq $s0, 0x0a, END
	nop
		addi $a0, $a0, 1	# AvanÔøΩa uma posição no array
		addi $s1, $s1, 1	# Contador
	j FOR1
	nop
END:
	addi $v0, $s1, 0
	sub $a0, $a0, $s1
	lw $s0, 12($sp)	#	Retorna os valores das "variÔøΩveis locais"
	lw $s1, 8($sp)	#
	sw $a0, 4($sp)
	lw $ra, 0($sp)	# endereÔøΩo para sair da funÔøΩao
	addi $sp,$sp, 16	# liberta o espaÔøΩo da pilha
	jr $ra
	nop
###################END###################

#########################################
# Função para inserir o "zero" na pilha
# Param: a0(Pilha) 
#########################################
Zero:
	addi $sp, $sp, -12
	sw $s0, 8($sp)
	sw $a0, 4($sp)
	sw $ra, 0($sp)
	
	la $s0, Pilha
loop_zero:
	lw $t0, 0($s0)
	beq $t0, '\0', end_zero
	nop
		addi $s0, $s0, 4
		j loop_zero
		nop
	
end_zero:
	li $t0, 0x3b9ac9ff
	sw $t0, 0($s0)
	
	
	lw $s0, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	nop

###################END###################
ENDPROGRAM:
