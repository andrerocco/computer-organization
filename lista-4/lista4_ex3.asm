.data
	RESULT: .word 0
.text
main:
	li $v0, 5 # Comando para ler um int
	syscall
	move $a0, $v0 # Coloca o valor da base em $a0
	
	li $v0, 5 # Comando para ler um int
	syscall
	move $a1, $v0 # Coloca o valor do expoente em $a1
	
	# Passando os argumentos para a função pow()
	jal pow # Chama a função pow()
	
	# Ao fazer a chamada de função, o endereço da instrução na linha abaixo será armazenado em $ra
	la $t0, RESULT
	sw $v0, ($t0)
	
	# exit program
	li $v0, 10 # Comando para sair do programa
	syscall
pow:
	move $t0, $a0 # base
	move $t1, $a1 # expoente
	li $t3, 0 # contador
	li $t4, 1 # resultado
	# if $a1 == 0: return $t4
	beq $a1, $zero, end
	# else: go to loop
	# j loop
loop:
	slt $t5, $t3, $t1 # Se contador ($t3) < expoente ($t1) então $t5 = 1
	beq $t5, $zero, end # if contador >= expoente: go to end
	mul $t4, $t4, $t0 # resultado *= expoente
	addi $t3, $t3, 1 # contador += 1
	j loop
end:
	move $v0, $t4 # Coloca o resultado em $v0
	jr $ra # Retorna para a chamada da função	
	
	