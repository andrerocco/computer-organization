# Escreva um programa em Assembly do MIPS que implemente a função escrita em alto nível
# apresentada abaixo. Considere que:
# – Os valores de g, h, i, j devem ser números inteiros informados pelo usuário via teclado;
# – Os valores lidos (g, h, i, j) e o valor calculado (f) devem ser armazenados em memória;
# – A função calcula() deverá ser implementada como um procedimento no Assembly do MIPS

# int calcula(int g, int h, int i, int j) {
# 	int f;
#	f = (g + h) - (i + j);
#	return f;
# }

.data
.text
MAIN:
	li $v0, 5
	syscall
	move $a0, $v0	# $a0 = g
	
	li $v0, 5
	syscall
	move $a1, $v0	# $a1 = h
	
	li $v0, 5
	syscall
	move $a2, $v0	# $a2 = i
	
	li $v0, 5
	syscall
	move $a3, $v0	# $a3 = j
	
	jal CALCULA
	
	li $v0, 10
	syscall		# Finaliza o programa
	
CALCULA:
	move $v0, $zero
	
	add $t0, $a0, $a1
	add $t1, $a2, $a3
	sub $v0, $t0, $t1
	
	jr $ra