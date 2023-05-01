# Considere que o processador MIPS est� sendo utilizado para controlar um conjunto de 32
# dispositivos externos. Cada dispositivo recebe um bit indicando se ele deve ser ligado (=1) ou
# desligado (=0). Estes bits est�o armazenados no endere�o de dados 0x10010020. Implemente um
# programa que fa�a as seguintes opera��es:
# - O usu�rio deve informar pelo teclado se quer ligar ou desligar um bit. Exemplo: se digitar 1, �
# para ligar algum bit. Se digitar 0, � para desligar algum bit;
# - O usu�rio deve informar, na sequ�ncia, qual bit deve ser ligado/desligado. Por exemplo, ao digitar
# 2, ent�o o bit 2 do endere�o 0x10010020 deve ser ligado ou desligado (conforme instru��o
# anterior).
# - Os estados anteriores dos outros bits devem ser preservados obrigatoriamente.

.data
	# prompt1: .asciiz "Digite 0 para desligar um bit ou 1 para ligar um bit: "
	# prompt2: .asciiz "Digite o n�mero do bit que deseja ligar/desligar (0-31): "
	# message1: .asciiz "Bit desligado!"
	# message2: .asciiz "Bit ligado!"
.text
START:
	li $s4, 0x10010020
	sw $zero, ($s4)		# Inicia 0x10010020 na mem�ria com uma palavra de zeros
MAIN:
	# L� a resposta do usu�rio e armazena no registrador $t0
	li $v0, 5
	syscall
	move $s0, $v0 		# $t0 = 0 ou 1
    	
    	# L� a resposta do usu�rio e armazena no registrador $t1
	li $v0, 5
	syscall
	move $s1, $v0 		# $t1 = 0-31
	
	li $s2, 0x00000001	# Prepara a m�scara
	jal DESLOCA_BIT
	
	# Inverte $s2 se $s0 � zero (desligar)
	beq $s0, 1, ligar 	# Pula a condi��o desligar se a instru��o era de ligar
	lw $t0, ($s4)		# Carrega da mem�ria
	desligar:
		# Inverte o valor de $s2
		not $s2, $s2
		and $t0, $t0, $s2		# Desliga o bit selecionado
		j end_condicao
	ligar:
		or $t0, $t0, $s2 
	end_condicao:
	sw $t0, ($s4)		# Armazena na mem�ria o que foi modificado
	
	j MAIN
	
# Deloca
DESLOCA_BIT:
	# $s1 � a quantidade de vezes que ir� ocorrer o deslocamento
	# $s2 � o registrador que ir� sofrer o deslocamento
	move $t0, $zero		# Contador inicia em 0
	
	loop:
		beq $t0, $s1, exit_loop	# Sai do loop se contador == $s1 
		sll $s2, $s2, 1		# Desloca a m�scara $t1 vezes
		addi $t0, $t0, 1	# contador += 1
		j loop
	exit_loop:
		jr $ra