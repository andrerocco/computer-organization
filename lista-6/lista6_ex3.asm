# Escreva um programa que receba dois valores inteiros S e C, calcule e exiba a média:
# MEDIA = S (float) / C (float) como um número de ponto flutuante de precisão simples. Dica: use a
# instrução de conversão adequada para converter S e C de palavras inteiras em flutuação de
# precisão simples.

.data
	TEXT1: .asciiz "Insira o valor S: "
	.align 2
	TEXT2: .asciiz "Insira o valor C: "
	.align 2
	TEXT3: .asciiz "A média é: "
	.align 2
.text
MAIN:
	# Imprime a mensagem "Insira o valor S: "
	la $a0, TEXT1
	li $v0, 4
	syscall
	
	# Lê o valor de S como um int
	li $v0, 5
	syscall
	move $t0, $v0 # $t0 = S
    
	# Imprime a mensagem "Insira o valor C: "
	la $a0, TEXT2
	li $v0, 4
	syscall
    
	# Lê o valor de C como um float
	li $v0, 5
	syscall
	move $t1, $v0 # $t1 = C
	
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	mtc1 $t1, $f1
	cvt.s.w $f1, $f1
	jal MEDIA # O resultado será armazenado em $f12
	
	la $a0, TEXT3
	li $v0, 4
	syscall
	
	li $v0, 2
	syscall	
	
	# Finaliza o programa
	li $v0, 10
	syscall

MEDIA:
	div.s $f12, $f0, $f1
	jr $ra

	
