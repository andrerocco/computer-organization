# A função abaixo, escrita em linguagem C, calcula o fatorial de um número. Implemente um
# programa em Assembly para o MIPS que:
# – Receba via teclado o valor do número a ser calculado o fatorial;
# – Chame a função fatorial( ) para calcular o fatorial do número;
# – Mostre o resultado na tela do computador

# int fatorial(int n) {
# 	if (n < 1) {
#		return 1;
# 	} else {
# 		return (n * fatorial(n-1));
#	}
# }

.data
	prompt: 	.asciiz "Insira o número cujo fatorial deve ser calculado: "
	feedback:	.asciiz "\nO fatorial do número é: "
	numero: 	.word 0
	resultado: 	.word 0	
.text
main:
	# Imprime a mensagem e recebe o número do usuário
	la $a0, prompt
	li $v0, 4
	syscall		# Imprime a mensagem inicial
	
	li $v0, 5
	syscall
	sw $v0, numero	# Armazena o número na memória
	
	# Chama a função fatorial
	lw $a0, numero
	jal fatorial
	sw $v0, resultado
	
	# Imprime o feedback com o resultado
	la $a0, feedback
	li $v0, 4
	syscall
	
	lw $a0, resultado
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

fatorial:
	# Vamos subtrair a quantidade de bytes que vamos utilizar da stack do $sp. Fazemos
	# a operação de subtração porque o stack pointer é armazenado de cima para baixo,
	# então estamos adicionando espaço
	
	subu $sp, $sp, 8	# Libera 2 palavras
	sw $ra, 0($sp)		# Armazena o endereço de retonro
	sw $s0, 4($sp)
	
	# Caso base
	li $v0, 1
	beq $a0, 0, fatorial_fim
	
	# Caso de recursão
	move $s0, $a0
	sub $a0, $a0, 1		# Argumento para a proxima chamada é N-1
	jal fatorial		# fact * (fact-1)
	
	# Esse trecho do código só será executado uma vez que uma das chamadas recursivas de
	# factorial retornar, e todas as outras que fizeram a chamada começarem a retornar
	# também.
	
	mul $v0, $s0, $v0 	# valor retonado agora = valor retornado previamente * valor atual
	
	fatorial_fim:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8	# Reduzir o tamanho da stack
		
		jr $ra			# Retorna da função