# Implemente um programa que chame um procedimento para calcular a raiz de uma equação
# completa do primeiro grau, na forma Ax + B = 0. Os coeficientes, todos em ponto flutuante de
# precisão simples, devem ser informados pelo teclado. O valor da raiz deve ser apresentado no
# monitor.

.data
	TEXT1: .asciiz "Insira os coeficientes da equação de primeiro grau Ax + B = 0 \n"
	.align 2
	TEXT2: .asciiz "A: "
	.align 2
	TEXT3: .asciiz "B: "
	.align 2
	
.text
MAIN:
	la $a0, TEXT1
	li $v0, 4
	syscall # Imprime "Insira os coeficientes da equação de primeiro grau Ax + B = 0"
	
	la $a0, TEXT2
	li $v0, 4
	syscall # Imprime "A: "
	
	la $v0, 6
	syscall
	mov.s $f1, $f0 # $f1 = A
	
	la $a0, TEXT3
	li $v0, 4
	syscall # Imprime "B: "
	
	la $v0, 6
	syscall
	mov.s $f2, $f0 # $f2 = B
	
	jal RAIZ
	
	# Imprime $f12 que contém o resultado
	li $v0, 2
	syscall
	
	# Encerra o programa
	li $v0, 10
	syscall

RAIZ:
	# Ax + B = 0
	# $f1 = A e $f2 = B
	# x = -B / A
	neg.s $f2, $f2         # $f2 = -B
	div.s $f12, $f2, $f1    # $f12 = -B / A
	jr $ra

	