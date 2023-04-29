# Faça um programa que calcule o somatório de 1 até 5 (1+2+3+4+5)

.data
	SUM: .word 0
.text
main:
	li $t0, 1 # Inicializa o contador com 1
	li $t1, 6
	li $s0, 0 # Inicializa o valor da soma com 0

loop:
	add $s0, $s0, $t0
	addi $t0, $t0, 1

	slt $t2, $t0, $t1 # Compara $t0 com $t1 e define $t2 como 1 se $t0 < $t1
	bne $t2, $zero, loop # Vai para o endereço loop se $t2 != $zero (ou seja, $t0 >= $t1)
	
	la $t0, SUM
	sw $s0, 0($t0)