# Escreva um programa em Assembly do MIPS que receba uma string do teclado com at� 7 d�gitos e
# armazene esta string recebida na mem�ria de dados. Sugest�o: use o comando 8 na chamada de sistema syscall.

.data
	TEXT: .space 8
	.align 2
.text
	# $a0 = address of input buffer
	la $a0, TEXT
	# $a1 = maximum number of characters to read 
	li $a1, 8
	li $v0, 8
	syscall 