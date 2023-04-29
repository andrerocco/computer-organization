# Implemente um programa que chame um procedimento para calcular as raízes de uma equação
# completa do segundo grau, na forma Ax² + Bx + C = 0. Os coeficientes da equação, todos em ponto
# flutuante de precisão dupla, devem ser informados pelo teclado e os valores das raízes devem ser
# apresentados no monitor

.data
	TEXT1: .asciiz "Insira os coeficientes de Ax² + Bx + C = 0 para obter as raízes\nA: "
	.align 2
	TEXT2: .asciiz "B: "
	.align 2
	TEXT3: .asciiz "C: " 
	.align 2
	ERRO: .asciiz "Não foi possível calcular a raiz (delta < 0)"
	.align 2
	TEXTO_R1: .asciiz "\nRaiz 1: "
	.align 2
	TEXTO_R2: .asciiz "\nRaiz 2: "
	.align 2
.text
MAIN:
	la $a0, TEXT1
	jal IMPRIME_TEXTO
	
	jal LE_DOUBLE
	mov.d $f2, $f0
	# $f2 = A
	
	la $a0, TEXT2
	jal IMPRIME_TEXTO
	
	jal LE_DOUBLE
	mov.d $f4, $f0
	# $f4 = B
	
	la $a0, TEXT3
	jal IMPRIME_TEXTO
	
	jal LE_DOUBLE
	mov.d $f6, $f0
	# $f6 = C
	
	jal RAIZ_F_QUADRATICA
	
	li $v0, 10
	syscall

# Imprime a string cujo endereço base deve estar em $a0
IMPRIME_TEXTO:
	li $v0, 4
	syscall
	jr $ra

# Lê um valor double e o armazena em $f0
LE_DOUBLE:
	li $v0, 7
	syscall
	jr $ra
	
# Resolve uma Ax² + Bx + C = 0
RAIZ_F_QUADRATICA:
	# $f2 = A
	# $f4 = B
	# $f6 = C
	
	# raiz_1 = -B / 2*A + sqrt(B²-4.A.C) / 2*A
	# raiz_1 = -B / 2*A - sqrt(B²-4.A.C) / 2*A
	
	add.d $f14, $f2, $f2 		# $f14 = 2*A
	
	# $f16 = -B / $f14
	neg.d $f16, $f4 		# $f16 = -B
	div.d $f16, $f16, $f14 		# $f16  = -B / 2*A = $f16 / $f14
	
	# $f20 = 4.A.C
	add.d $f20, $f2, $f2
	add.d $f20, $f20, $f2
	add.d $f20, $f20, $f2		# $f20 = 4.A	
	mul.d $f20, $f20, $f2
	mul.d $f20, $f20, $f6		# $f20 = 4.A.C
	
	# $f18 = B²-$f20
	mul.d $f18, $f4, $f4
	sub.d $f18, $f18, $f20
	
	sub.d $f20, $f20, $f20 # $f20 = 0
	c.lt.d $f18, $f20 # Se $f18 é menor do que 0, c1 flag será true
	bc1t ERRO_DELTA
	
	sqrt.d $f18, $f18 # $f18 = sqrt($f18)
	div.d $f18, $f18, $f14 # $f18 = sqrt(B²-4.A.C) / 2.A
	
	# Calcula e imprime a raiz 1
	# raiz_1 = $f16 + $f18
	add.d $f12, $f16, $f18
	
	la $a0, TEXTO_R1
	li $v0, 4
	syscall
	
	li $v0, 3
	syscall
	
	# Calcula e imprime a raiz 2
	# raiz_1 = $f16 - $f18
	sub.d $f12, $f16, $f18
	
	la $a0, TEXTO_R2
	li $v0, 4
	syscall
	
	li $v0, 3
	syscall
	
	jr $ra

ERRO_DELTA:
	la $a0, ERRO
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
