# Lucas Cardoso Soares 22100631
# Andre Amaral Rocco 22100605

.data
	.eqv SIZE 48		# Define o tamanho de uma linha/coluna da matriz quadrada
	.eqv BLOCK_SIZE 4	# Define o tamanho do bloco utilizando no cache blocking
.text
main:
	# ARMAZENAMENTO DAS MATRIZES --------------
	
	# $s0 = SIZE
	li $s0, SIZE 		# Armazena o tamanho
	
	# $s1 = SIZE*SIZE*4
	mul $s1, $s0, $s0
	mul $s1, $s1, 4
	
	# $s2 = Endereco de A
	move $a0, $s1		# Número de bytes que serão alocados
	li $v0, 9		# 9 = Alocar memoria na heap
	syscall
	move $s2, $v0
	
	# $s3 = Endereco de B
	li $v0, 9
	syscall
	move $s3, $v0
	
	# LOOP FOR --------------
	
	li $t0, 0	# i = 0
	li $t1, 0	# j = 0
	
	loop_i:
	bge $t0, SIZE, end_i	# i < SIZE
	li $t1, 0		# j = 0
	
		loop_j:
		bge $t1, SIZE, end_j	# j < SIZE
		move $t2, $t0		# ii = i
	
			loop_ii:
			addi $t4, $t0, BLOCK_SIZE	# i + BLOCK_SIZE
			bge $t2, $t4, end_ii		# ii < i + BLOCK_SIZE
			move $t3, $t1			# jj = j
			
				loop_jj:
				addi $t6, $t1, BLOCK_SIZE	# j + BLOCK_SIZE
				bge $t3, $t6, end_jj		# jj < j + BLOCK_SIZE
				
				# Calcula o deslocamento do endereco atual
				# $t8 = A[ii*SIZE + jj] (e multiplicar o valor por 4 bytes)
				mul $t8, $t2, SIZE	# $t8 = ii*SIZE
				add $t8, $t8, $t3	# $t8 = ii*SIZE + jj = $t8 + $t3
				mul $t8, $t8, 4		# Multiplica por 4 bytes
				add $t8, $t8, $s2	# &A + deslocamento calculado
				
				# $t9 = B[jj*SIZE + ii] (e multiplicar o valor por 4 bytes)
				mul $t9, $t3, SIZE  	# $t9 = jj*SIZE
				add $t9, $t9, $t2	# $t9 = jj*SIZE + ii = $t9 + $t2
				mul $t9, $t9, 4		# Multiplica por 4 bytes
				add $t9, $t9, $s3	# &B + deslocamento calculado
				
				# Carrega os valores de A[ii,jj] em $f0 e B[jj,ii] em $f1
				l.s $f0, ($t8)		# $f0 = A[ii,jj]
				l.s $f1, ($t9)		# $f1 = B[jj,ii]
				
				add.s $f0, $f0, $f1	# $f0 = A[ii,jj] + B[jj,ii]
				s.s $f0, ($t8)		# A[ii,jj] = $f0
				
				addi $t3, $t3, 1	# jj += 1
				j loop_jj
	
				end_jj:				
				addi $t2, $t2, 1	# ii += 1
				j loop_ii
				
			end_ii:
			addi $t1, $t1, BLOCK_SIZE	# j += BLOCK_SIZE
			j loop_j
	
		end_j:
		addi $t0, $t0, BLOCK_SIZE	# i += BLOCK_SIZE
		j loop_i
	
	end_i:
	
	# Saindo do programa
	li $v0, 10
	syscall
