# Considere que o processador MIPS está sendo utilizado para controlar um conjunto de 32
# dispositivos externos. Cada dispositivo recebe um bit indicando se ele deve ser ligado (=1) ou
# desligado (=0). Estes bits estão armazenados no endereço de dados 0x10010020. Implemente um
# programa que faça as seguintes operações:
# - O usuário deve informar pelo teclado se quer ligar ou desligar um bit. Exemplo: se digitar 1, é
# para ligar algum bit. Se digitar 0, é para desligar algum bit;
# - O usuário deve informar, na sequência, qual bit deve ser ligado/desligado. Por exemplo, ao digitar
# 2, então o bit 2 do endereço 0x10010020 deve ser ligado ou desligado (conforme instrução
# anterior).
# - Os estados anteriores dos outros bits devem ser preservados obrigatoriamente.

.data
	# prompt1: .asciiz "Digite 0 para desligar um bit ou 1 para ligar um bit: "
	# prompt2: .asciiz "Digite o número do bit que deseja ligar/desligar (0-31): "
	# message1: .asciiz "Bit desligado!"
	# message2: .asciiz "Bit ligado!"
.text
START:
	li $s4, 0x10010020
	sw $zero, ($s4)		# Inicia 0x10010020 na memória com uma palavra de zeros
MAIN:
	# Lê a resposta do usuário e armazena no registrador $t0
	li $v0, 5
	syscall
	move $s0, $v0 		# $t0 = 0 ou 1
    	
    	# Lê a resposta do usuário e armazena no registrador $t1
	li $v0, 5
	syscall
	move $s1, $v0 		# $t1 = 0-31
	
	li $s2, 0x00000001	# Prepara a máscara
	jal DESLOCA_BIT
	
	# Inverte $s2 se $s0 é zero (desligar)
	beq $s0, 1, ligar 	# Pula a condição desligar se a instrução era de ligar
	lw $t0, ($s4)		# Carrega da memória
	desligar:
		# Inverte o valor de $s2
		not $s2, $s2
		and $t0, $t0, $s2		# Desliga o bit selecionado
		j end_condicao
	ligar:
		or $t0, $t0, $s2 
	end_condicao:
	sw $t0, ($s4)		# Armazena na memória o que foi modificado
	
	j MAIN
	
# Deloca
DESLOCA_BIT:
	# $s1 é a quantidade de vezes que irá ocorrer o deslocamento
	# $s2 é o registrador que irá sofrer o deslocamento
	move $t0, $zero		# Contador inicia em 0
	
	loop:
		beq $t0, $s1, exit_loop	# Sai do loop se contador == $s1 
		sll $s2, $s2, 1		# Desloca a máscara $t1 vezes
		addi $t0, $t0, 1	# contador += 1
		j loop
	exit_loop:
		jr $ra