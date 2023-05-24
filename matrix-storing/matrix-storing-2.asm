# Andr� Amaral Rocco - 22100605
# Lucas Cardoso Soares - 22100631

# 2) Similar ao exerc�cio anterior, implemente um programa no MARS que percorrer� uma matriz inteira de
# 16 por 16 elementos, coluna ap�s coluna, atribuindo aos elementos os valores de 0 a 255 na ordem. Para
# isso, seu programa dever� incluir o seguinte algoritmo:

# for (col = 0; col < 16; col++)
# 	for (row = 0; row < 16; row++)
# 		data[row][col] = value++;

.data
	MATRIX: .space 1024
.text
	la $s0, MATRIX
	li $t1, 16 	# Armazena o tamanho
	
	li $t3, 0 	# $t3 = i
	li $t4, 0	# $t4 = j
	
	li $t5, 0	# Contador de repeti��es totais
	
	for_row:
		for_collumn:
		mul $t6, $t3, 4		# 4*j
		mul $t7, $t4, $t1	# 16*i
		mul $t7, $t7, 4		# 16*i*4
		move $t0, $s0
		add $t0, $t0, $t6
		add $t0, $t0, $t7	# (16*i)+(4*j)
		sw $t5, ($t0)		# Armazena o n�mero atual no endere�o
		
		addi $t5, $t5, 1		# Incrementa o contador total
	
		# CONTROLE DO LOOP COLUNA >>>
		addi $t4, $t4, 1		# contador_coluna += 1;
		blt $t4, $t1, for_collumn	# Repete o loop enquanto $s1 < 3
		li $t4, 0			# Zera o contador se o loop finalizou
		# FIM CONTROLE DO LOOP COLUNA <<<
		
	# CONTROLE DO LOOP LINHA >>>
	addi $t3, $t3, 1		# contador_linha += 1;
	blt $t3, $t1, for_row		# Repete o loop enquanto $s1 < 3
	li $t3, 0			# Zera o contador se o loop finalizou
	# FIM CONTROLE DO LOOP LINHA <<<
	
	li $v0, 10
	syscall
