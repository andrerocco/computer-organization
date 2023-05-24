# André Amaral Rocco - 22100605
# Lucas Cardoso Soares - 22100631

# 1) Implemente um programa no MARS que percorrerá uma matriz inteira de 16 por 16 elementos, linha
# após linha, atribuindo aos elementos os valores de 0 a 255 na ordem. Para isso, seu programa deverá
# incluir o seguinte algoritmo:

# for (row = 0; row < 16; row++)
# 	for (col = 0; col < 16; col++)
# 		data[row][col] = value++;

.data
	MATRIX: .space 1024
.text
	la $s0, MATRIX
	li $t1, 16 	# Armazena o tamanho
	
	li $t3, 0 	# $t3 = i
	li $t4, 0	# $t4 = j
	
	li $t5, 0	# Contador de repetições totais
	
	for_row:
		for_collumn:
		mul $t6, $t4, 4		# 4*j
		mul $t7, $t3, $t1	# 16*i
		mul $t7, $t7, 4		# 16*i*4
		move $t0, $s0
		add $t0, $t0, $t6
		add $t0, $t0, $t7	# (16*i)+(4*j)
		sw $t5, ($t0)		# Armazena o número atual no endereço
		
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
