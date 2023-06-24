# André Amaral Rocco - 22100605
# Lucas Cardoso Soares - 22100631

# 1) Implemente o algoritmo abaixo no MARS que realiza a soma de uma matriz com outra transposta. O
# tamanho das matrizes (MAX) deve ser parametrizável:

# float A[MAX, MAX], B[MAX, MAX]
# for (i=0; i<MAX; i++) {
# 	for (j=0; j<MAX; j++) {
# 		A[i,j] = A[i,j] + B[j,i]
# 	}
# }

.data
	.eqv SIZE 16 	# Define o tamanho de uma linha/coluna da matriz quadrada
.text
main:
	# ARMAZENAMENTO DAS MATRIZES --------------
	
	# $s0 = SIZE
	li $s0, SIZE 		# Armazena o tamanho
	
	# $s1 = SIZE*SIZE*4
	mul $s1, $s0, $s0
	mul $s1, $s1, 4
	
	# $s2 = Endereço de A
	move $a0, $s1		# Número de bytes que serão alocados
	li $v0, 9		# 9 = Alocar memória na heap
	syscall
	move $s2, $v0
	
	# $s3 = Endereço de B
	li $v0, 9
	syscall
	move $s3, $v0
	
	# LOOP FOR --------------
	
	# li $t1, SIZE 	# Armazena o tamanho
	li $t3, 0 	# $t3 = i
	li $t4, 0	# $t4 = j
	
	for_row:
		for_collumn:	
		# Calcula o deslocamento do endereço atual
		# $t0 = A[i*SIZE + j] (e multiplicar o valor por 4 bytes)
		mul $t0, $t3, SIZE	# $t0 = i*SIZE
		add $t0, $t0, $t4	# $t0 = i*SIZE + j = $t0 + $t4
		mul $t0, $t0, 4		# Multiplica por 4 bytes
		add $t0, $t0, $s2	# Endereço de A + deslocamento calculado
		
		# $t1 = B[j*SIZE + i] (e multiplicar o valor por 4 bytes)
		mul $t1, $t4, SIZE  	# $t1 = j*SIZE
		add $t1, $t1, $t3	# $t1 = j*SIZE + i = $t1 + $t3
		mul $t1, $t1, 4		# Multiplica por 4 bytes
		add $t1, $t1, $s3	# Endereço de B + deslocamento calculado
		
		# Carrega os valores de A[i,j] em $f0 e B[j,i] em $f1
		l.s $f0, ($t0)		# $f0 = A[i,j]
		l.s $f1, ($t1)		# $f1 = B[j,i]
		
		add.s $f0, $f0, $f1	# $f0 = A[i,j] + B[j,i]
		s.s $f0, ($t0)		# A[i,j] = $f0

		# CONTROLE DO LOOP COLUNA >>>
		addi $t4, $t4, 1		# contador_coluna += 1;
		blt $t4, SIZE, for_collumn	# Repete o loop enquanto $s1 < 3
		li $t4, 0			# Zera o contador se o loop finalizou
		# FIM CONTROLE DO LOOP COLUNA <<<
		
	# CONTROLE DO LOOP LINHA >>>
	addi $t3, $t3, 1		# contador_linha += 1;
	blt $t3, SIZE, for_row		# Repete o loop enquanto $s1 < 3
	li $t3, 0			# Zera o contador se o loop finalizou
	# FIM CONTROLE DO LOOP LINHA <<<
	
	li $v0, 10
	syscall
