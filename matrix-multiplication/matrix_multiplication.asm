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

	STRING: .asciiz "               "
	.align 2
	fout: .asciiz "array.txt"
	.align 2
.text
main:
	jal matrix_multiply

	# O código abaixo abre um arquivo para ser escrito.
	li	$v0, 13			# Comando para abrir novo arquivo.
	la	$a0, fout		# Carrega o nome do arquivo a ser aberto.
	li	$a1, 1			# Aberto para escrita (0: lêr; 1: escrever).
	li	$a2, 0			# Modo ignorado (neste caso).
	syscall				# Chamada de sistema. Descritor do arquivo é colocado em $v0.
	move	$s6, $v0		# Salva descritor do arquivo para uso no fechamento posterior.
	
	# Chama o procedimento de conversão de dados escritos no buffer ARRAY para o buffer STRING em ASCII.
	jal	transfer		# Chama procedimento para manipulação dos arrrays. 

	# Após o retorno do procedimento, salva o buffer STRING no arquivo que foi aberto anteriormente.		
	li	$v0, 15			# Comando para escrever no arquivo.
	move	$a0, $s6		# Passa o descritor do arquivo previamente salvo.
	la	$a1, STRING		# Passa endereço base do buffer a ser salvo.
	li	$a2, 44			# Delimita tamanho do buffer a ser escrito.
	syscall				# Chamada de sistema. Escreve buffer no arquivo.
	
	# Após transferir o buffer para o arquvio, o código abaixo fecha o arquivo com uma chamada no SO.
	li	$v0, 16			# Comando para fechamento do arquivo.
	move	$a0, $s6		# Passa o descritor do arquivo que será fechado.
	syscall				# Arquivo é fechado pelo Sistema Operacional.
	
	li $v0, 10
	syscall

matrix_multiply:
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

	jr $ra

transfer:
	addi	$sp, $sp, -12		# Prepara PUSH para salvar dados de a0 e a1 (usados na rotina principal!)
	sw	$ra, 8($sp)		# Salva retorno - Stack Pointer.
	sw	$a0, 4($sp)		# Salva $a0.
	sw	$a1, 0($sp)		# Salva $a1.

	la	$a0, MATRIX_R		# Atualiza os endereços de ARRAY e STRING em $a0 e $a1.
	la	$a1, STRING
		
	li	$s2, 9			# Limite de iterações a serem feitas para transferir os dados
	li	$s7, 0   		# Será usado para contar laço de loop.
	li	$s4, 0  		# Índice do ARRAY começando em i = 0
	li	$s5, 0   		# Índice da STRING começando em j = 0
		
	loop:	
	# Nesta sequência vamos tirar um dado de ARRAY[i]
	move	$s3, $s4		# Pega índice de ARRAY.
	add	$t1, $s3, $s3		# Aponta para o próximo índice (2*i).
	add	$t1, $t1, $t1		# (4*i), sendo que i está armazenado em $s3.
	add	$t1, $t1, $a0		# Endereço Base + 4*i --> agora, apontando para o elemento do array.
	
	lw	$t0, 0($t1)		# $t0 <-- ARRAY[i].
	addi	$t0, $t0, 48		# Incrementa de 48 para transformar em caractere ASCII.
	addi	$s4, $s4, 1		# Incrementa índice i para a próxima iteração.
	
	# Nesta sequência vamos colocar o dado retirado de ARRAY[i] em STRING[j]
	move	$s3, $s5		# Pega índice da STRING de destino.
	add	$t1, $s3, $s3		# Aponta para o próximo índice (2*j)
	add	$t1, $t1, $t1		# (4*j), sendo que j está armazenado em $s3
	add	$t1, $t1, $a1		# Endereço Base + 4*i --> agora, apontando para o elemento do array.
	
	sw	$t0, 0($t1)		# Armazena conteúdo retirado de ARRAY[i] em STRING[j].
	li	$t0, 32			# Coloca caracter de "espaco em branco" (ASCII) em $t0.
	sw	$t0, 4($t1)		# Armazena espeço em branco em STRING[j+1].
	addi	$s5, $s5, 1		# Incrementa índice j para a próxima iteração.
	addi	$s7, $s7, 1		# Incrementa laço do loop.
	bne	$s2, $s7, loop
	
	lw	$a1, 0($sp)		# Restaura $a1.
	lw	$a0, 4($sp)		# Restaura $a0.
	lw	$ra, 8($sp)		# Restaura $ra.
	addi	$sp, $sp, 12		# Atualiza $SP (POP de três instruções).
	jr	$ra			# Retorna do procedimento para o programa principal.
