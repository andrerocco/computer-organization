# Dadas as matrizes A e B (abaixo), elabore um programa em Assembly para o processador MIPS (usando o
# simulador MARS) que encontre a matriz resultante do produto: A.B. Armazene a matriz resultante na
# memória de dados.

# | 1  2  3 |     | 1 -2  5 |
# | 0  1  4 |  x  | 0  1 -4 |
# | 0  0  1 |     | 0  0  1 |

.data
	MATRIX_A: .word 1,  2,  3,  0,  1,  4,  0,  0,  1	# Matriz A
	MATRIX_B: .word 1, -2,  5,  0,  1, -4,  0,  0,  1	# Matriz B
	MATRIX_R: .space 36					# Matriz R (Resultado)
.text
	li $s0, 0	# $s0 é o contador da linha atual = i
	li $s1, 0	# $s1 é o contador da coluna atual = j
	
	# R[linha][coluna]
	# R[i][j] = A[i][1] * B[1][j] + A[i][2] * B[2][j] + A[i][3] * B[3][j]
	
	loop_linha:
		loop_coluna:
			li $t1, 0
			li $t2, 0
			li $t3, 0
			li $t4, 0
			la $t5, MATRIX_R
			la $t6, MATRIX_A
			la $t7, MATRIX_B
		
			# R[i][j] = A[i][1] * B[1][j] + A[i][2] * B[2][j] + A[i][3] * B[3][j]
			# $t0 irá acumular o resultado R[i][j]
			li $t0, 0
			
			# $t2 = A[i][1]
			mul $t4, $s0, 12	# INICIO >>>  $t2 = A[i][1]
			add $t4, $t4, $t6
			lw $t2, ($t4)		# FIM    <<<
			
			# $t3 = B[1][j]
			mul $t4, $s1, 4		# INICIO >>> $t3 = B[1][j]
			add $t4, $t4, $t7
			lw $t3, ($t4)		# FIM    <<<
			
			mul $t1, $t2, $t3	# $t1 = A[i][1] * B[1][j]
			add $t0, $t0, $t1	# $t0 += $t1
			
			
			# $t2 = A[i][2]
			mul $t4, $s0, 12	# INICIO >>> $t2 = A[i][2]
			addi $t4, $t4, 4	# Desloca em 1 word (4 bytes)
			add $t4, $t4, $t6
			lw $t2, ($t4)		# FIM    <<<
			
			# $t3 = B[2][j]
			mul $t4, $s1, 4		# INICIO >>> $t3 = B[2][j]
			add $t4, $t4, $t7
			addi $t4, $t4, 12	# Desloca em 3 words (12 bytes)
			lw $t3, ($t4)		# FIM    <<<
			
			mul $t1, $t2, $t3	# $t1 = A[i][2] + B[2][j]
			add $t0, $t0, $t1	# $t0 += $t1
			
			
			# $t2 = A[i][3]
			mul $t4, $s0, 12	# INICIO >>> $t2 = A[i][3]
			addi $t4, $t4, 8	# Desloca em 2 words (8 bytes)
			add $t4, $t4, $t6
			lw $t2, ($t4)		# FIM    <<<
			
			# $t3 = B[3][j]
			mul $t4, $s1, 4		# INICIO >>> $t3 = B[3][j]
			add $t4, $t4, $t7
			addi $t4, $t4, 24	# Desloca em 6 words (24 bytes)
			lw $t3, ($t4)		# FIM    <<<
			
			mul $t1, $t2, $t3	# $t1 = A[i][3] + B[3][j]
			add $t0, $t0, $t1	# $t0 += $t1
			
			
			
			# Nesse momento $t0 contém o devido valor de R[i][j]
			li $t4, 0		# Reinicia $t4
			mul $t4, $s1, 4		# Desloca para a coluna
			mul $t1, $s0, 12
			add $t4, $t4, $t1	# Desloca para a linha
			add $t4, $t4, $t5
			sw $t0, ($t4)
			
			
			# CONTROLE DO LOOP COLUNA >>>
			addi $s1, $s1, 1	# contador_coluna += 1;
			blt $s1, 3, loop_coluna	# Repete o loop enquanto $s1 < 3
			li $s1, 0		# Zera o contador se o loop finalizou
			# FIM CONTROLE DO LOOP COLUNA <<<
		
		# CONTROLE DO LOOP LINHA >>>
		addi $s0, $s0, 1	# contador_linha += 1;
		blt $s0, 3, loop_coluna	# Repete o loop enquanto $s1 < 3
		li $s0, 0		# Zera o contador se o loop finalizou
		# FIM CONTROLE DO LOOP LINHA <<<
