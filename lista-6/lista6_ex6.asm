# O m�todo iterativo de Newton pode ser usado para aproximar a raiz quadrada de um n�mero x,
# usando a express�o: guess = ((x/guess) + guess) / 2. Deve-se iniciar o algoritmo com o valor 1
# (guess). Escreva uma fun��o chamada square_root que recebe um par�metro de precis�o dupla x,
# calcula, e retorna o valor aproximado da raiz quadrada de x. Escreva um loop que se repita 20 vezes
# e calcula 20 valores de palpite e, em seguida, retorna o palpite final ap�s 20 itera��es. Compare o
# resultado da instru��o sqrt.d com o resultado de sua fun��o square_root. Qual � o erro em valor
# absoluto?

.data
	GUESS: .double 1.0
	DOIS: .double 2.0
.text
MAIN:
	# $f0 = x (n�mero cuja raiz quadrada ser� estimada)
	li $v0, 7
	syscall
	
	# $f2 ser� guess = 1
	ldc1 $f2, GUESS
	
	jal SQUARE_ROOT	# $f12 = guess com 20 itera��es
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall		# Encerra o programa
	
SQUARE_ROOT:
	li $t0, 0	# $t0 ser� o contador
	ldc1 $f20, DOIS	# $f20 = 2.0

	loop:
		# guess = ((x/guess) + guess) / 2
		div.d $f4, $f0, $f2	# $f4 = x / guess
		# $f4 + guess
		add.d $f4, $f4, $f2	# $f4 = $f4 + guess
		# Neste ponto, $f4 = (x/guess) + guess
		# $f4 / 2
		div.d $f4, $f4, $f20	# $f4 = $f4 / 2
		# guess = $f4
		mov.d $f2, $f4
		
		# Incrementa o contador
		addi $t0, $t0, 1
		blt $t0, 20, loop
	
	mov.d $f12, $f2	# $f12 = guess final
	jr $ra
		
	