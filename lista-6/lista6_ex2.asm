# Implemente um programa que converta a temperatura dada em Fahrenheit via teclado para Celsius. Premissas:
# - Utilize a equação de conversão TC/5 = (TF – 32)/9, em que TC é a temperatura em Celsius e TF em fahreinheit;
# - A equação de conversão deve ser implementada como um procedimento.

.data
	TEXT1: .asciiz "Digite o valor em F: "
	.align 2
	TRINTA_E_DOIS: .float 32.0
	NOVE: .float 9.0
	CINCO: .float 5.0
.text
MAIN:
	li $v0, 4
	la $a0, TEXT1
	syscall

	li $v0, 6 # Ler um float
	syscall # $f0 = Temperatura em Fahrenheit
	
	jal CONVERTE_CELCIUS
	
	# Encerra o programa
    	li $v0, 10
    	syscall
	
CONVERTE_CELCIUS:
	# TC/5 = (TF – 32)/9
	# TC = ((TF – 32) / 9) * 5
	# $f0
	l.s $f1, TRINTA_E_DOIS
	l.s $f2, NOVE
	l.s $f3, CINCO
	
	# $f12 = ($f0 - 32)
	sub.s $f12, $f0, $f1
	# $f12 = $f12 / 9
	div.s $f12, $f12, $f2
	# $f12 = $f12 * 5
	mul.s $f12, $f12, $f3
	
	jr $ra